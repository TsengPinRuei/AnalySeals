//
//  View.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/21.
//

import SwiftUI

extension View
{
    //MARK: 用於切換深淺模式的圖片集
    @MainActor
    @ViewBuilder
    func createImage(
        toggle: Bool,
        current: Binding<UIImage?>,
        previous: Binding<UIImage?>,
        activate: Binding<Bool>
    ) -> some View
    {
        self
            .onChange(of: toggle)
            {(_, new) in
                SwiftUI.Task {
                    if let window=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?
                        .windows
                        .first(where: { $0.isKeyWindow })
                        {
                            let image: UIImageView=UIImageView()
                            image.frame=window.frame
                            image.image=window.rootViewController?.view.image(window.frame.size)
                            image.contentMode = .scaleAspectFit
                            window.addSubview(image)
                            
                            if let rootView=window.rootViewController?.view
                            {
                                let frame=rootView.frame.size
                                
                                activate.wrappedValue = !new
                                previous.wrappedValue=rootView.image(frame)
                                activate.wrappedValue=new
                                try await SwiftUI.Task.sleep(for: .seconds(0.01))
                                current.wrappedValue=rootView.image(frame)
                                try await SwiftUI.Task.sleep(for: .seconds(0.01))
                                image.removeFromSuperview()
                            }
                        }
                }
            }
    }
    @ViewBuilder
    func horizontalSpacing(_ alignment: Alignment) -> some View
    {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    //MARK: 切換深淺模式動畫的起始位置
    @ViewBuilder
    func switchPoint(value: @escaping (CGRect) -> ()) -> some View
    {
        self
            .overlay
            {
                GeometryReader
                {reader in
                    let rectangle=reader.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PointKey.self, value: rectangle)
                        .onPreferenceChange(PointKey.self)
                    {preference in
                        value(preference)
                    }
                }
            }
    }
    @ViewBuilder
    func verticalSpacing(_ alignment: Alignment) -> some View
    {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    //MARK: 自訂角度設定
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View
    {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    //MARK: 提取月份中的所有日期
    func extractDate(_ month: Date) -> [MonthDay]
    {
        let calendar: Calendar=Calendar.current
        let format: DateFormatter=DateFormatter()
        var day: [MonthDay]=[]
        
        guard let range=calendar
            .range(of: .day, in: .month, for: month)?
            .compactMap({value -> Date? in
                return calendar.date(byAdding: .day, value: value-1, to: month)}
            ) else { return day }
        
        let first: Int=calendar.component(.weekday, from: range.first!)
        
        for i in Array(0..<first-1).reversed()
        {
            guard let date=calendar.date(byAdding: .day, value: -i-1, to: range.first!) else { return day }
            let symbol=format.string(from: date)
            day.append(MonthDay(symbol: symbol, date: date, ignore: true))
        }
        
        format.dateFormat="dd"
        range.forEach
        {date in
            let symbol: String=format.string(from: date)
            day.append(MonthDay(symbol: symbol, date: date))
        }
        
        let last: Int=7-calendar.component(.weekday, from: range.last!)
        
        if(last>0)
        {
            for i in 0..<last
            {
                guard let date=calendar.date(byAdding: .day, value: i+1, to: range.last!) else { return day }
                let symbol=format.string(from: date)
                day.append(MonthDay(symbol: symbol, date: date, ignore: true))
            }
        }
        
        return day
    }
    //MARK: 自訂字體大小
    func fontSize(size: String) -> some View
    {
        switch(size)
        {
            case "大":
                return self.font(.system(size: 24))
            case "中":
                return self.font(.system(size: 18))
            case "小":
                return self.font(.system(size: 12))
            default:
                return self.font(.none)
        }
    }
    //MARK: 判斷同一天
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool
    {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    //MARK: 限制TextField字數
    func limitInput(text: Binding<String>, max: Int) -> some View
    {
        self.modifier(TextLimit(text: text, max: max))
    }
    //MARK: 自訂MBTIView中的Section介面
    func mbtiSectionStyle() -> some View
    {
        self
            .font(.title2.bold())
            .headerProminence(.increased)
            .listRowBackground(Color(.systemGray3).opacity(0.5))
            .listRowSeparator(.hidden)
    }
    //MARK: 自訂Button介面
    func modifyButtonTextStyle(width: CGFloat, height: CGFloat, fgColor: Color) -> some View
    {
        self
            .foregroundStyle(fgColor)
            .frame(maxWidth: width)
            .frame(maxHeight: height)
            .background(Color(.button))
            .clipShape(.rect(cornerRadius: 10))
    }
    func modifyHeadImageStyle(height: CGFloat) -> some View
    {
        self
            .frame(height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(.black, lineWidth: 1))
    }
    //MARK: 自訂Navigation Bar介面
    func modifyNavigationBarStyle(title: String, display: ToolbarTitleDisplayMode) -> some View
    {
        self
            .navigationTitle(title)
            .toolbarTitleDisplayMode(display)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.background) ,for: .navigationBar)
            //隱藏系統預設的NavigationBarBackButton
            .navigationBarBackButtonHidden(true)
    }
    //MARK: 自訂Picker介面
    func modifyPickerStyle(width: CGFloat) -> some View
    {
        self
            .tint(Color(.fieldText))
            .frame(maxWidth: width)
            .padding(10)
            .background(Color(.field))
            .clipShape(.rect(cornerRadius: 20))
    }
    //MARK: 過指定時間之後發送通知
    func notificateInterval()
    {
        let index: Int
        let body: [String]=["祝你上理想的學校喔🤩", "明天還要來找我玩喔🥺"]
        let subtitle: [String]=["測完成績了嗎", "ㄅㄅ"]
        //通知
        let content=UNMutableNotificationContent()
        
        index=Int.random(in: 0..<subtitle.count)
        content.title="AnalySeals"
        content.subtitle=subtitle[index]
        content.body=body[index]
        content.sound=UNNotificationSound.default
        
        //授權通知
        UNUserNotificationCenter.current()
            .add(UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                //離開APP 5秒之後發送通知 不重複
                trigger: UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            ))
    }
    //MARK: 指定時間發送通知
    func notificateTime(time: DateComponents) -> String
    {
        let index: Int
        let subtitle: [String]=["你喜歡的我來了🥰", "今日事今日畢", "小海豹溫馨提醒😎", "每天都是新的開始", "嗷嗷嗷", "最近有新的興趣嗎", "嗷嗷嗷本豹提醒你", "你什麼時候回來", "今天心情如何呀", "🎵～休息～是為了走更長～的路～🎶"]
        let text: [String]=["要不要一起挖掘新的筆記呀？", "今天的進度都完成了嗎？", "你今天寫筆記了嗎？", "你今天讀書了嗎？", "來看看適合你的學校吧！", "要不要分享給大家知道呀🤩。", "關鍵時刻不要倦怠喔。", "本豹好想你🥺...", "分享給本豹聽聽呀！", "奮鬥的時候也要記得休息喔～"]
        //通知
        let content=UNMutableNotificationContent()
        
        index=Int.random(in: 0..<subtitle.count)
        content.title="AnalySeals"
        content.subtitle=subtitle[index]
        content.body=text[index]
        content.sound=UNNotificationSound.default
        
        //授權通知
        UNUserNotificationCenter
            .current()
            .add(UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                //離開APP 每time時間發送通知
                trigger: UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            ))
        
        //回傳副標題及內容
        return subtitle[index].appending("\n").appending(text[index])
    }
    //MARK: TextField的placeholder
    func placeholder<Content: View>(when show: Bool, @ViewBuilder placeholder: () -> Content) -> some View
    {
        ZStack(alignment: .leading)
        {
            placeholder().opacity(show ? 1:0)
            self
        }
    }
    //MARK: 載入動畫
    func shimmer(_ configuration: ShimmerConfiguration) -> some View
    {
        self.modifier(ShimmerEffect(configuration: configuration))
    }
    //MARK: 自訂UpView中的Text樣式
    func signUpButtonTextStyle() -> some View
    {
        self
            .foregroundStyle(.black)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(.button))
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))
    }
    //MARK: 自訂UpView中的TextField介面
    func signUpFieldStyle() -> some View
    {
        self
            .font(.title3)
            .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThickMaterial))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))
    }
    //MARK: 自訂UpView中的Picker介面
    func signUpPickerStyle() -> some View
    {
        self
            .pickerStyle(.wheel)
            .tint(.black)
            .frame(height: 110)
    }
}
