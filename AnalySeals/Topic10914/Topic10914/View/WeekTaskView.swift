//
//  WeekTaskView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/16.
//

import SwiftUI
import SwiftData

struct WeekTaskView: View
{
    @Binding var date: Date
    @Binding var disableAdd: Bool
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var task: [WeekTask]
    
    @State private var showPop: [Bool]=[]
    
    init(date: Binding<Date>, disableAdd: Binding<Bool>)
    {
        self._date=date
        self._disableAdd=disableAdd
        
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: date.wrappedValue)
        let end: Date=calendar.date(byAdding: .day, value: 1, to: start)!
        self._task=Query(
            filter: #Predicate<WeekTask> { return $0.date>=start && $0.date<end },
            sort: [SortDescriptor(\WeekTask.date, order: .reverse)],
            animation: .snappy
        )
    }
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            ForEach(self.task.indices, id: \.self)
            {index in
                WeekTaskItemView(task: self.task[index])
                    .background(alignment: .leading)
                    {
                        if(self.task.last?.id != self.task[index].id)
                        {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 23, y: 45)
                                .allowsHitTesting(false)
                        }
                    }
                    .onTapGesture
                    {
                        self.showPop[index].toggle()
                    }
                    .popover(isPresented: self.showPop.count<self.task.count ? .constant(false):self.$showPop[index])
                    {
                        Button("刪除", systemImage: "trash", role: .destructive)
                        {
                            do
                            {
                                withAnimation(.smooth)
                                {
                                    self.modelContext.delete(self.task[index])
                                }
                                try self.modelContext.save()
                            }
                            catch {}
                        }
                        .bold()
                        .font(.body)
                        .padding(10)
                        .presentationCompactAdaptation(.popover)
                        .presentationBackground(.ultraThinMaterial)
                    }
                    .onChange(of: self.showPop)
                    {(_, new) in
                        for i in new
                        {
                            if(i==true)
                            {
                                withAnimation(.smooth)
                                {
                                    self.disableAdd=true
                                }
                                return
                            }
                        }
                        self.disableAdd=false
                    }
            }
            .onChange(of: self.task)
            {(_, _) in
                self.showPop=Array(repeating: false, count: self.task.count)
            }
            .onAppear
            {
                self.showPop=Array(repeating: false, count: self.task.count)
            }
        }
        .padding(.top)
        .overlay
        {
            if(self.task.isEmpty)
            {
                Text("一事無成")
                    .bold()
                    .font(.title)
                    .foregroundStyle(Color(.toolbar))
                    .frame(width: 300)
                    .padding(.top, UIScreen.main.bounds.height/2)
            }
        }
    }
}
