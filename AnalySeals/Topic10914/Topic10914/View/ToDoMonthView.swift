//
//  ToDoMonthView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/19.
//

import SwiftUI

struct ToDoMonthView: View
{
    @Environment(\.dismiss) private var dismiss
    
    @State private var createTask: Bool=false
    @State private var disableAdd: Bool=false
    @State private var date: Date=Date.now
    @State private var month: Date=Date.currentMonth
    
    private var currentMonth: String { return self.format("MMMM") }
    private var currentYear: String { return self.format("YYYY") }
    private var calendarHeight: CGFloat { return self.titleHeight+self.weekHeight+self.gridHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom) }
    private var gridHeight: CGFloat { return CGFloat(self.monthDay.count/7)*40 }
    private var progress: CGFloat
    {
        let calendar=Calendar.current
        
        if let index=self.monthDay.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: self.date) })
        {
            return CGFloat(index/7).rounded()
        }
        return 1.0
    }
    private var titleHeight: CGFloat { return 60 }
    private var weekHeight: CGFloat { return 30 }
    private var monthDay: [MonthDay] { return self.extractDate(self.month) }
    var safeArea: EdgeInsets
    
    @ViewBuilder
    private func CalendarView() -> some View
    {
        GeometryReader
        {
            let size=$0.size
            let maxHeight: CGFloat=size.height-(self.titleHeight+self.weekHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom))
            let minY: CGFloat=$0.frame(in: .scrollView(axis: .vertical)).minY
            let progress: CGFloat=max(min(-minY/maxHeight, 1), 0)
            
            VStack(alignment: .leading, spacing: 0)
            {
                Text(self.currentMonth)
                    .font(.system(size: 35-5*progress))
                    .offset(y: -32*progress)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .overlay(alignment: .topLeading)
                    {
                        GeometryReader
                        {
                            let size: CGSize=$0.size
                            
                            HStack(spacing: 20)
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
                                .offset(x: -50*progress, y: -10)
                                
                                Text(self.currentYear)
                                    .font(.system(size: 25-5*progress))
                                    .offset(x: (size.width-30)*progress, y: progress)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .topTrailing)
                    {
                        HStack(spacing: 20)
                        {
                            Button("", systemImage: "chevron.left")
                            {
                                self.updateMonth(false)
                            }
                            .contentShape(.rect)
                            
                            Button("", systemImage: "chevron.right")
                            {
                                self.updateMonth(true)
                            }
                            .contentShape(.rect)
                        }
                        .font(.title3)
                        .offset(x: 150*progress)
                    }
                    .frame(height: self.titleHeight)
                
                VStack(spacing: 0)
                {
                    HStack(spacing: 0)
                    {
                        ForEach(Calendar.current.weekdaySymbols, id: \.self)
                        {symbol in
                            Text(symbol.prefix(3))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: self.weekHeight, alignment: .bottom)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0)
                    {
                        ForEach(self.monthDay)
                        {day in
                            Text(day.symbol)
                                .font(.body)
                                .foregroundStyle(day.ignore ? .secondary:.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .overlay(alignment: .bottom)
                                {
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .opacity(Calendar.current.isDate(day.date, inSameDayAs: self.date) ? 1:0)
                                        .offset(y: -progress)
                                }
                                .contentShape(.rect)
                                .onTapGesture
                                {
                                    self.date=day.date
                                }
                        }
                    }
                    .frame(height: self.gridHeight-((self.gridHeight-40)*progress), alignment: .top)
                    .offset(y: self.progress * -40*progress)
                    .contentShape(.rect)
                    .clipped()
                }
                .offset(y: -40*progress)
            }
            .foregroundStyle(Color(.backBar))
            .padding(.horizontal, self.edgePadding(edge: .horizontal))
            .padding(.top, self.edgePadding(edge: .top))
            .padding(.top, self.safeArea.top)
            .padding(.bottom, self.edgePadding(edge: .bottom))
            .frame(maxHeight: .infinity)
            .frame(height: size.height-(maxHeight*progress), alignment: .top)
            .background(Color(.rectangle).gradient)
            .overlay(alignment: .bottom)
            {
                Rectangle()
                    .fill(.black)
                    .frame(height: 1)
            }
            .clipped()
            .contentShape(.rect)
            .offset(y: -minY)
        }
        .frame(height: self.calendarHeight)
        .zIndex(1)
    }
    
    private func format(_ format: String) -> String
    {
        let formatter: DateFormatter=DateFormatter()
        formatter.dateFormat=format
        return formatter.string(from: self.month)
    }
    private func edgePadding(edge: Edge.Set) -> CGFloat
    {
        if(edge == .top || edge == .horizontal)
        {
            return 15
        }
        else if(edge == .bottom)
        {
            return 5
        }
        else
        {
            return 0
        }
    }
    private func updateMonth(_ increment: Bool)
    {
        let calendar: Calendar=Calendar.current
        guard let month: Date=calendar.date(byAdding: .month, value: increment ? 1:-1, to: self.month) else { return }
        guard let date: Date=calendar.date(byAdding: .month, value: increment ? 1:-1, to: self.date) else { return }
        withAnimation(.easeInOut)
        {
            self.month=month
            self.date=date
        }
    }
    
    var body: some View
    {
        let height: CGFloat=self.calendarHeight-(self.titleHeight+self.weekHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom))
        
        ScrollView(.vertical)
        {
            VStack(spacing: 0)
            {
                self.CalendarView()
                
                //MonthTaskView(date: self.$date, disableAdd: self.$disableAdd)
                WeekTaskView(date: self.$date, disableAdd: self.$disableAdd)
                    .padding()
                    .animation(.smooth.speed(5), value: self.date)
            }
        }
        .background(Color(.background))
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(CalendarScroll(height: height))
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
                //NewMonthTaskView()
                NewWeekTaskView()
                    .presentationDetents([.fraction(0.7)])
                    .presentationBackground(.ultraThickMaterial)
                    .presentationCornerRadius(30)
            }
            .disabled(self.disableAdd)
        }
    }
}
