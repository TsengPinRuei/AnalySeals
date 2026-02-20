//
//  Date.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/7.
//

import Foundation

extension Date: RawRepresentable
{
    struct WeekDay: Identifiable
    {
        var id: UUID=UUID()
        var date: Date
    }
    
    //MARK: 擴充Date初始化 才能用在AppStorage
    public var rawValue: String
    {
        self.timeIntervalSinceReferenceDate.description
    }
    
    //MARK: 判斷是否為過去
    var isPast: Bool
    {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    //MARK: 判斷是否為同一小時
    var isSameHour: Bool
    {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    //MARK: 判斷是否為同一天
    var isToday: Bool
    {
        return Calendar.current.isDateInToday(self)
    }
    
    //MARK: 擴充Date初始化 才能用在AppStorage
    public init?(rawValue: String)
    {
        self=Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
    
    //MARK: 取得當前月份
    static var currentMonth: Date
    {
        let calendar: Calendar=Calendar.current
        
        guard let current: Date=calendar.date(from: Calendar.current.dateComponents([.month, .year], from: .now)) else { return .now }
        return current
    }
    static func updateHour(_ value: Int) -> Date
    {
        let calendar: Calendar=Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: Date()) ?? Date()
    }
    
    //MARK: 根據當前週 創建上一週
    func createPreviousWeek() -> [WeekDay]
    {
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: self)
        
        guard let next=calendar.date(byAdding: .day, value: -7, to: start) else { return [] }
        return self.getWeek(next)
    }
    //MARK: 根據當前週 創建下一週
    func createNextWeek() -> [WeekDay]
    {
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: self)
        
        guard let next=calendar.date(byAdding: .day, value: 1, to: start) else { return [] }
        return self.getWeek(next)
    }
    //MARK: 格式化日期
    func format(_ format: String) -> String
    {
        let formatter: DateFormatter=DateFormatter()
        formatter.dateFormat=format
        return formatter.string(from: self)
    }
    //MARK: 取得當日所在當前週
    func getWeek(_ date: Date=Date()) -> [WeekDay]
    {
        let calendar: Calendar=Calendar.current
        let startDate: Date=calendar.startOfDay(for: date)
        var week: [WeekDay]=[]
        let weekDate: DateInterval?=calendar.dateInterval(of: .weekOfMonth, for: startDate)
        
        guard weekDate?.start != nil else { return [] }
        for i in 0..<7
        {
            if let weekDay=calendar.date(byAdding: .day, value: i, to: startDate)
            {
                week.append(WeekDay(date: weekDay))
            }
        }
        return week
    }
}
