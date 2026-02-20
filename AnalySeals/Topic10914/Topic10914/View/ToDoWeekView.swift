//
//  ToDoWeekView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/16.
//

import SwiftUI

struct ToDoWeekView: View
{
    //記錄深淺模式
    @AppStorage("activateDark") private var activeDark: Bool=false
    
    @Environment(\.dismiss) private var dismiss
    
    @Namespace private var animation
    
    @State private var createTask: Bool=false
    @State private var createWeek: Bool=false
    @State private var disableAdd: Bool=false
    @State private var weekIndex: Int=1
    @State private var currentDate: Date=Date()
    @State private var week: [[Date.WeekDay]]=[]
    
    @ViewBuilder
    private func WeekView(_ week: [Date.WeekDay]) -> some View
    {
        HStack(spacing: 0)
        {
            ForEach(week)
            {day in
                VStack
                {
                    Text(day.date.format("E"))
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(.toolbar))
                    
                    Text(day.date.format("dd"))
                        .font(.headline)
                        .foregroundStyle(self.isSameDate(day.date, self.currentDate) ? .white:Color(.toolbar))
                        .frame(width: 50, height: 55)
                        .background
                        {
                            if(self.isSameDate(day.date, self.currentDate))
                            {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                                    .offset(y: 5)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: self.animation)
                            }
                            if(day.date.isToday)
                            {
                                Capsule()
                                    .fill(self.isSameDate(day.date, self.currentDate) ? .white:Color(.toolbar))
                                    .frame(width: 15, height: 5)
                                    .verticalSpacing(.bottom)
                            }
                        }
                }
                .horizontalSpacing(.center)
                .onTapGesture
                {
                    withAnimation(.snappy)
                    {
                        self.currentDate=day.date
                    }
                }
            }
        }
        .background
        {
            GeometryReader
            {
                let minX: CGFloat=$0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: TasksOffsetKey.self, value: minX)
                    .onPreferenceChange(TasksOffsetKey.self)
                    {value in
                        if(value.rounded()==15 && self.createWeek)
                        {
                            self.paginateWeek()
                            self.createWeek=false
                        }
                    }
            }
        }
    }
    
    private func paginateWeek()
    {
        if(self.week.indices.contains(self.weekIndex))
        {
            if let first=self.week[self.weekIndex].first?.date, self.weekIndex==0
            {
                self.week.insert(first.createPreviousWeek(), at: 0)
                self.week.removeLast()
                self.weekIndex=1
            }
            if let last=self.week[self.weekIndex].last?.date, self.weekIndex==self.week.count-1
            {
                self.week.append(last.createNextWeek())
                self.week.removeFirst()
                self.weekIndex=self.week.count-2
            }
        }
    }
    
    var body: some View
    {
        NavigationStack
        {
            VStack(alignment: .leading, spacing: 0)
            {
                TabView(selection: self.$weekIndex)
                {
                    ForEach(self.week.indices, id: \.self)
                    {index in
                        let week: [Date.WeekDay]=self.week[index]
                        
                        self.WeekView(week).tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 100)
                .padding()
                .frame(maxWidth: .infinity)
                .background
                {
                    Rectangle()
                        .fill((self.activeDark ? Color(.rectangle):Color.gray).opacity(0.8))
                        .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                        .ignoresSafeArea(.all)
                }
                
                ScrollView(.vertical)
                {
                    VStack
                    {
                        WeekTaskView(date: self.$currentDate, disableAdd: self.$disableAdd)
                    }
                    .padding(.top)
                    .horizontalSpacing(.center)
                    .verticalSpacing(.center)
                }
            }
            .background(Color(.background))
            .navigationTitle("我的進度表")
            .toolbarTitleDisplayMode(.large)
            .toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button
                    {
                        self.dismiss()
                    }
                    label:
                    {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                }
            }
            .verticalSpacing(.top)
            .frame(maxWidth: .infinity)
            .onAppear
            {
                if(self.week.isEmpty)
                {
                    let week: [Date.WeekDay]=Date().getWeek()
                    
                    if let first=week.first?.date
                    {
                        self.week.append(first.createPreviousWeek())
                    }
                    self.week.append(week)
                    if let last=week.last?.date
                    {
                        self.week.append(last.createNextWeek())
                    }
                }
            }
            .overlay(alignment: .bottomTrailing)
            {
                Button
                {
                    self.createTask.toggle()
                }
                label:
                {
                    Image(systemName: "plus")
                        .imageScale(.medium)
                        .padding()
                        .foregroundStyle(Color.primary.opacity(0.8))
                        .colorInvert()
                        .background(Color(.toolbar).opacity(0.8))
                        .clipShape(.circle)
                        .padding(.trailing)
                }
                .sheet(isPresented: self.$createTask)
                {
                    NewWeekTaskView()
                        .presentationDetents([.fraction(0.7)])
                        .presentationBackground(.ultraThickMaterial)
                        .presentationCornerRadius(30)
                }
                .disabled(self.disableAdd)
            }
        }
    }
}
