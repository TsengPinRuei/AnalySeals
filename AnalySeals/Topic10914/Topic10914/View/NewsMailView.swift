//
//  NewsMailView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/1.
//

import SwiftUI

struct NewsMailView: View
{
    //紀錄字型大小
    @AppStorage("fontSize") private var fontSize: String="預設"
    //通知訊息
    @AppStorage("mail") private var mail: [String]=[]
    //通知訊息是否已讀
    @AppStorage("read") private var read: [Bool]=[]
    
    @Environment(\.dismiss) private var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //發布最新消息的Alert
    @State private var showAdd: Bool=false
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    @State private var index: Int=0
    //最新消息的標題
    @State private var title: String=""
    //最新消息的內容
    @State private var text: String=""
    //最新消息的日期
    @State private var date: String=""
    @State private var news: [News]=[]
    //顯示最新消息的Alert
    @State private var alert: Alerter=Alerter(message: "", show: false)
    
    private let mailSubtitle: [String]=["你喜歡的我來了🥰", "今日事今日畢", "小海豹溫馨提醒😎", "每天都是新的開始", "嗷嗷嗷", "最近有新的興趣嗎", "嗷嗷嗷本豹提醒你", "你什麼時候回來", "今天心情如何呀", "🎵～休息～是為了走更長～的路～🎶"]
    private let mailText: [String]=["要不要一起挖掘新的筆記呀？", "今天的進度都完成了嗎？", "你今天寫筆記了嗎？", "你今天讀書了嗎？", "來看看適合你的學校吧！", "要不要分享給大家知道呀🤩。", "關鍵時刻不要倦怠喔。", "本豹好想你🥺...", "分享給本豹聽聽呀！", "奮鬥的時候也要記得休息喔～"]
    
    //MARK: 全部刪除／全部已讀
    var readButton: some View
    {
        Button
        {
            //全部刪除
            if(self.countRead()==self.read.count)
            {
                self.mail=[]
                self.read=[]
            }
            //全部已讀
            else
            {
                self.read=Array(repeating: true, count: self.mail.count)
            }
        }
        label:
        {
            Text("全部"+(self.countRead()==self.read.count ? "刪除":"已讀"))
                .font(.headline)
                .foregroundStyle(Color(.toolbar))
        }
    }
    
    //MARK: 已讀數量
    private func countRead() -> Int
    {
        var count: Int=0
        
        for index in self.read
        {
            if(index==true)
            {
                count+=1
            }
        }
        
        return count
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.capsule).ignoresSafeArea(.all)
            
            if(self.mail.isEmpty && self.news.isEmpty)
            {
                Image(.nothing)
                    .resizable()
                    .scaledToFit()
            }
            else
            {
                List
                {
                    //MARK: 最新消息
                    DisclosureGroup
                    {
                        ForEach(self.news)
                        {index in
                            Button
                            {
                                self.alert.showAlert(title: index.title, message: index.text.replacingOccurrences(of: " ", with: "\n"))
                            }
                            label:
                            {
                                VStack(alignment: .leading, spacing: 5)
                                {
                                    Text(index.title)
                                        .bold()
                                        .font(.title3)
                                    
                                    Text(index.text.replacingOccurrences(of: " ", with: "\n")).font(.body)
                                    
                                    Text(index.date)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .foregroundStyle(Color(.welcomeTitle))
                            }
                        }
                        .listRowBackground(Color(.rectangle).opacity(0.3))
                        .listRowSeparatorTint(Color(.backBar))
                    }
                    label:
                    {
                        HStack(spacing: 20)
                        {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .scaledToFit()
                                //將圖片調整到適合大小
                                .frame(height: 30)
                            
                            Text("最新消息")
                        }
                        .foregroundStyle(Color(.backBar))
                        .frame(height: 40)
                    }
                    .tint(Color(.backBar))
                    .listRowBackground(Rectangle().fill(.ultraThickMaterial))
                    
                    //MARK: 通知訊息
                    DisclosureGroup
                    {
                        //有通知才會出現
                        if(self.mail.count>0)
                        {
                            self.readButton
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .listRowBackground(Rectangle().fill(.ultraThinMaterial))
                        }
                        
                        ForEach(self.mail.indices, id: \.self)
                        {index in
                            Text(self.mail[index]).fontSize(size: self.fontSize)
                                .foregroundStyle(Color(.fieldText))
                                //背景顏色 根據是否讀取顯示紅色或是綠色
                                .listRowBackground(self.read[index] ? Color(red: 200/255, green: 255/255, blue: 200/255):Color(red: 255/255, green: 200/255, blue: 200/255))
                                //已讀
                                .swipeActions(edge: .leading)
                                {
                                    Button
                                    {
                                        self.read[index]=true
                                    }
                                    label:
                                    {
                                        Text("Read").foregroundStyle(.white)
                                    }
                                    .tint(.green)
                                    //已讀就不能再已讀
                                    .disabled(self.read[index])
                                }
                        }
                        //刪除
                        .onDelete
                        {index in
                            self.mail.remove(atOffsets: index)
                            self.read.remove(atOffsets: index)
                        }
                    }
                    label:
                    {
                        HStack(spacing: 20)
                        {
                            Image(.mail)
                                .resizable()
                                .scaledToFit()
                            
                            Text("通知訊息")
                        }
                        .foregroundStyle(Color(.backBar))
                        .frame(height: 40)
                    }
                    .tint(Color(.backBar))
                    .listRowBackground(Rectangle().fill(.ultraThickMaterial))
                }
                .listStyle(.plain)
            }
        }
        .modifyNavigationBarStyle(title: "消息通知", display: .large)
        .toolbar
        {
            //MARK: 返回主頁
            ToolbarItem(placement: .cancellationAction)
            {
                Button
                {
                    self.dismiss()
                }
                label:
                {
                    HStack(spacing: 3)
                    {
                        Image(systemName: "chevron.left").bold()
                        
                        Text("返回主頁")
                    }
                }
                .opacity(self.showBackButton ? 1:0)
            }
            
            //MARK: 發送通知或消息
            //只有官方帳號可以發送通知或發佈消息
            if(self.user.account=="topicgood123@gmail.com")
            {
                ToolbarItem(placement: .topBarTrailing)
                {
                    HStack
                    {
                        //發送通知
                        Button
                        {
                            self.index=Int.random(in: 0..<self.mailSubtitle.count)
                            self.mail.insert(self.mailSubtitle[self.index].appending("\n").appending(self.mailText[self.index]), at: 0)
                            self.read.insert(false, at: 0)
                        }
                        label:
                        {
                            Text("發送通知")
                                .font(.headline)
                                .foregroundStyle(Color(.toolbar))
                        }
                        
                        //發佈消息
                        Button
                        {
                            self.showAdd.toggle()
                        }
                        label:
                        {
                            Text("發佈消息")
                                .font(.headline)
                                .foregroundStyle(Color(.toolbar))
                        }
                    }
                }
            }
        }
        //避免鍵盤擠壓到畫面
        .ignoresSafeArea(.keyboard)
        //MARK: Firestore
        .onAppear
        {
            //從Firestore中抓取最新消息的資料
            Firestorer().getNews
            {news in
                self.news=news
            }
            
            //0.5秒之後再顯示返回主頁 比較順暢好看
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
            {
                withAnimation(.easeInOut)
                {
                    self.showBackButton=true
                }
            }
        }
        //MARK: 新增消息Alert
        //addNews觸發動作 顯示自定義的alert
        .alert("發佈到最新消息", isPresented: self.$showAdd)
        {
            TextField("版本", text: self.$title)
                .bold()
                .foregroundStyle(.orange)
            
            TextField("內容", text: self.$text).foregroundStyle(.orange)
            
            TextField("時間", text: self.$date).foregroundStyle(.orange)
            
            Button("取消", role: .none)
            {
                self.title=""
                self.text=""
                self.date=""
            }
            
            //MARK: 發佈
            Button("發佈", role: .none)
            {
                //將最新消息存進Firestore 用編號做文件
                Firestorer()
                    .addNews(
                        news: News(title: self.title, text: self.text, date: self.date),
                        number: String(self.news.count)
                    )
                
                self.title=""
                self.text=""
                self.date=""
                
                //清除所有最新消息
                self.news.removeAll()
                //從資料庫更新最新消息的資料
                Firestorer().getNews
                {news in
                    self.news=news
                }
            }
        }
        //alert觸發動作 顯示自定義的alert
        .alert(isPresented: self.$alert.show)
        {
            return Alert(title: Text(self.alert.title!), message: Text(self.alert.message), dismissButton: .default(Text("確認")))
        }
    }
}
