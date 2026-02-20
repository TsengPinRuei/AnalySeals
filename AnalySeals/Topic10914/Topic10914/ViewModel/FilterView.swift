//
//  FilterView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/9.
//

import SwiftUI

struct FilterView<Content: View>: View
{
    @Binding private var filterDate: Date
    
    @FetchRequest private var result: FetchedResults<Task>
    
    var content: ([Task], [Task]) -> Content
    
    init(filterDate: Binding<Date>, @ViewBuilder content: @escaping ([Task], [Task]) -> Content)
    {
        let calendar=Calendar.current
        let start=calendar.startOfDay(for: filterDate.wrappedValue)
        let end=calendar.date(bySettingHour: 23, minute: 59, second: 59, of: start)!
        let predicate=NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [start, end])
        
        //從CoreData抓取資料    sortDescriptors: 依照指定優先級做排序 -> 1.日期 2.標題    predicate: 抓取指定資料的條件 -> 指定日期當天    animation: 動畫
        _result=FetchRequest(
            entity: Task.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true), NSSortDescriptor(keyPath: \Task.title, ascending: true)],
            predicate: predicate,
            animation: .easeInOut(duration: 0.25)
        )
        
        self.content=content
        self._filterDate=filterDate
    }
    
    //分類進度
    func seperateTask() -> ([Task], [Task])
    {
        let complete=self.result.filter{ $0.isComplete }
        let pending=self.result.filter{ !$0.isComplete }
        return (pending, complete)
    }
    
    var body: some View
    {
        self.content(self.seperateTask().0, self.seperateTask().1)
            //使用者點選其他日期
            .onChange(of: self.filterDate)
            {(_, new) in
                self.result.nsPredicate=nil
                
                let calendar=Calendar.current
                let start=calendar.startOfDay(for: new)
                let end=calendar.date(bySettingHour: 23, minute: 59, second: 59, of: start)!
                let predicate=NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [start, end])
                
                self.result.nsPredicate=predicate
            }
    }
}
