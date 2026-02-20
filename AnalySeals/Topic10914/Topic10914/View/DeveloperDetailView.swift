//
//  DeveloperDetailView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/8.
//

import SwiftUI

struct DeveloperDetailView: View
{
    //顯示開發者資訊的狀態
    @Binding var showDetail: Bool
    //人物動畫的狀態
    @Binding var showHero: Bool
    //動畫所需的Slider
    @Binding var progress: CGFloat
    //開發者資料
    @Binding var developer: Developer?
    
    //Slider拖曳用動畫
    @GestureState private var drag: Bool=false
    
    @State private var showSleepText: Bool=true
    @State private var count: Int=0
    //亂數
    @State private var random: Int=0
    @State private var offset: CGFloat = .zero
    //亂數計時器
    @State private var timer: Timer?
    
    //MARK: 開發者內容
    private func DeveloperContent(id: String, random: Int) -> some View
    {
        switch(id)
        {
            //MARK: 蕭能陽
            case "10914102":
                let text: [String] =
                [
                    "啥？什麼？可以吃嗎？",
                    "我負責，什麼都一點點、什麼都不厲害，",
                    "美術、影片、文字、好像什麼都碰一下。"
                ]
                
                return AnyView(
                    VStack(alignment: .leading)
                    {
                        ForEach(text, id: \.self)
                        {index in
                            Text(index).font(.headline)
                        }
                    }
                    .padding(30)
                    //顯示右上角與左下角的邊框（對應iPhone 14 Pro格式）
                    .background(Rectangle().stroke(Color(.toolbar), style: StrokeStyle(lineWidth: 3, dash: [0, 300, 100, 125])))
                )
            //MARK: 曾品瑞
            case "10914054":
                let text: [String] =
                [
                    "知人知面不織布",
                    "鳩佔雀巢檸檬茶",
                    "下不維力炸醬麵",
                    "打是情，Marz23",
                    "拖泥帶水，你帶賽",
                    "講歸講，傑尼龜傑尼",
                    "遇強則強，玉米濃湯",
                    "麻雀雖小，武藏小次郎",
                    "得了便宜還Minecraft",
                    "夜路走多了，總匯三明治",
                    "因為你值得，寶礦力水得",
                    "你越是這樣，我悅氏礦泉水",
                    "越難的事情，交給越南人做",
                    "Miska Muska Mos Burger",
                    "玫瑰帶刺，人心帶私，宇智波帶土",
                    "人比人氣死人，人比蛋餅起司蛋餅",
                    "一山還有一山高，蘿蔔還有蘿蔔糕"
                ].sorted(by: <)
                
                return AnyView(
                    VStack(spacing: 1)
                    {
                        VStack(spacing: 5)
                        {
                            Text("偷偷放老爸笑話在這邊\n應該不會被發現吧...")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .fill(Color(.toolbar))
                                .frame(height: 1)
                        }
                        .padding(.horizontal)
                        
                        List
                        {
                            ForEach(text, id: \.self)
                            {index in
                                Text(index)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(Color(.backBar))
                        }
                        .listStyle(.inset)
                        .scrollIndicators(.hidden)
                        .scrollContentBackground(.hidden)
                    }
                )
            //MARK: 毛淑娟
            case "10914150":
                return AnyView(
                    VStack(spacing: 1)
                    {
                        //九宮格
                        ForEach(0..<3, id: \.self)
                        {iIndex in
                            HStack(spacing: 1)
                            {
                                ForEach(0..<3, id: \.self)
                                {jIndex in
                                    Rectangle()
                                        .fill(Color(.background))
                                        .scaledToFit()
                                        .overlay(iIndex*3+jIndex==random ? .green:.clear)
                                        .overlay
                                    {
                                        Text("\(iIndex*3+jIndex+1)")
                                            .bold()
                                            .font(.title3)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color(.backBar))
                    .background(Rectangle().stroke(Color(.backBar), lineWidth: 3))
                    //點擊停止提示視窗
                    .overlay
                    {
                        //還在計時 && 避免一開始出現停止字串 && 呼吸燈式顯示字串
                        if(self.timer != nil)
                        {
                            if(self.count%5==3 || self.count%5==4)
                            {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .overlay
                                    {
                                        Text("點擊停止")
                                            .bold()
                                            .font(.title)
                                            .foregroundStyle(Color(.backBar))
                                    }
                                    //動畫式淡入淡出
                                    .transition(.opacity.animation(.easeInOut))
                            }
                        }
                        //避免一開始就出現圖片
                        else if(self.count>0)
                        {
                            ZStack
                            {
                                Image("ShuJan".appending("\(self.random)"))
                                    .resizable()
                                    .overlay(Rectangle().fill(.ultraThinMaterial))
                                
                                Image("ShuJan".appending("\(self.random)"))
                                    .resizable()
                                    .scaledToFit()
                            }
                            .transition(.opacity.animation(.easeInOut))
                        }
                    }
                    //點擊停止亂數計時器
                    .onTapGesture
                    {
                        if(self.timer != nil)
                        {
                            self.timer?.invalidate()
                            self.timer=nil
                        }
                    }
                )
            //MARK: 許云瀞
            case "10914003":
                return AnyView(
                    ZStack
                    {
                        Color.white
                        
                        Text("嗨 你逛到我這邊來了\n相逢即是有緣\n我看你需要睡眠\n\n快樂跟金錢不能並存 但你可以選擇加入我們\n只要睡覺\n既可以補充體力 也可以省去多餐費用 還可以擁有快樂\n一舉三得\n\n恭喜你\n睡覺豹神看上了你\n歡迎加入睡教\n晚安 瑪卡巴卡")
                            .font(.headline)
                            .padding(30)
                            .opacity(self.showSleepText ? 1:0)
                            .animation(.easeInOut, value: self.showSleepText)
                        
                        Image(.sleepSeal)
                            .resizable()
                            .scaledToFit()
                            .opacity(self.showSleepText ? 0:1)
                            .animation(.easeInOut, value: self.showSleepText)
                    }
                    .overlay
                    {
                        Rectangle()
                            .stroke(
                                Color(.toolbar),
                                style: StrokeStyle(lineWidth: 3, dash: [0, 320, 100, 400])
                            )
                    }
                    .padding(.bottom)
                )
            //MARK: 黃彥廷
            case "10914009":
                return AnyView(
                    Text("我很愛乾淨，喜歡英文歌、哈利波特，還有科幻片。\nMBTI是INFJ，喜歡安安靜靜的，不喜歡吵吵鬧鬧的，平常生活滿無聊的。\n因為不愛社交，所以基本上都獨來獨往。")
                        .font(.headline)
                        .padding(30)
                        //顯示右上角與左下角的邊框（對應iPhone 14 Pro格式）
                        .background(Rectangle().stroke(Color(.toolbar), style: StrokeStyle(lineWidth: 3, dash: [0, 300, 100, 180])))
                )
            //MARK: 朱芩穎
            case "10914036":
                return AnyView(
                    Text("跟各位魚魚講話的其實是我啦！\n歡迎大家來ＬＩＮＥ的官方帳號跟我聊天呦！")
                        .font(.headline)
                        .padding(30)
                    //顯示右上角與左下角的邊框（對應iPhone 14 Pro格式）
                        .background(Rectangle().stroke(Color(.toolbar), style: StrokeStyle(lineWidth: 3, dash: [0, 320, 100, 80])))
                )
            default:
                return AnyView(EmptyView())
        }
    }
    
    var body: some View
    {
        if let developer=self.developer, self.showDetail
        {
            GeometryReader
            {
                let size=$0.size
                
                VStack
                {
                    //MARK: 開發者圖片
                    Rectangle()
                        .fill(.clear)
                        .overlay
                        {
                            if(!self.showHero)
                            {
                                Image(developer.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: size.width, height: 300)
                                    .clipShape(.rect)
                                    .transition(.identity)
                            }
                        }
                        .frame(height: 300)
                        .anchorPreference(key: DeveloperAnchorKey.self, value: .bounds)
                        {anchor in
                            return ["DESTINATION":anchor]
                        }
                        .visualEffect
                        {(content, proxy) in
                            content
                                .offset(y: proxy.frame(in: .local).minY>0 ? -proxy.frame(in: .local).minY:0)
                        }
                    
                    //MARK: 開發者自定義畫面
                    self.DeveloperContent(id: self.developer!.id, random: self.random)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.vertical)
                        .padding(.horizontal, 10)
                        .overlay(alignment: .topLeading)
                        {
                            if(developer.id=="10914003" && self.showSleepText)
                            {
                                //顯示字體背後的圖片
                                Button("拜見睡眠豹神")
                                {
                                    withAnimation(.easeInOut)
                                    {
                                        self.showSleepText=false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1)
                                    {
                                        withAnimation(.easeInOut)
                                        {
                                            self.showSleepText=true
                                        }
                                    }
                                }
                                .tint(.blue)
                                .background(.ultraThinMaterial)
                                .padding(.leading, 10)
                                .padding(.top)
                            }
                        }
                        //MARK: 計時
                        .onAppear
                        {
                            //無限計時 更新計數
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true)
                            {_ in
                                self.count+=1
                            }
                            //無限計時 決定亂數
                            self.timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
                            {_ in
                                withAnimation(.smooth)
                                {
                                    self.random=Int.random(in: 0...8)
                                }
                            }
                        }
                }
                .ignoresSafeArea(.all)
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(width: size.width)
                //MARK: 背景
                .background
                {
                    Rectangle()
                        .fill(Color(.background))
                        .ignoresSafeArea(.all)
                }
                //MARK: X
                .overlay(alignment: .topTrailing)
                {
                    Button
                    {
                        self.showHero=true
                        withAnimation(.snappy(duration: 0.5, extraBounce: 0), completionCriteria: .logicallyComplete)
                        {
                            self.progress=0
                        }
                        completion:
                        {
                            self.showDetail=false
                            self.developer=nil
                        }
                    }
                    label:
                    {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .imageScale(.medium)
                            .contentShape(.rect)
                            .foregroundStyle(.white, .black)
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .opacity(self.showHero ? 0:1)
                    .animation(.snappy(duration: 0.2, extraBounce: 0), value: self.showHero)
                }
                .offset(x: size.width-(size.width*self.progress))
                //MARK: 拖曳
                .overlay(alignment: .leading)
                {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 10)
                        .contentShape(.rect)
                        .gesture(
                            DragGesture()
                                .updating(self.$drag)
                                {(_, out, _) in
                                    out=true
                                }
                                .onChanged
                                {value in
                                    var translation=value.translation.width
                                    
                                    translation=self.drag ? translation:.zero
                                    translation=translation>0 ? translation:0
                                    
                                    let dragProgress=1-(translation/size.width)
                                    let cappedProgress=min(max(0, dragProgress), 1)
                                    
                                    self.progress=cappedProgress
                                    if(!self.showHero)
                                    {
                                        self.showHero=true
                                    }
                                }
                                .onEnded
                                {value in
                                    let velocity=value.velocity.width
                                    
                                    if(self.offset+velocity>size.width*0.8)
                                    {
                                        withAnimation(.snappy(duration: 0.5, extraBounce: 0), completionCriteria: .logicallyComplete)
                                        {
                                            self.progress = .zero
                                        }
                                        completion:
                                        {
                                            self.offset = .zero
                                            self.showDetail=false
                                            self.showHero=true
                                            self.developer=nil
                                        }
                                    }
                                    else
                                    {
                                        withAnimation(.snappy(duration: 0.5, extraBounce: 0), completionCriteria: .logicallyComplete)
                                        {
                                            self.progress=1
                                            self.offset = .zero
                                        }
                                        completion:
                                        {
                                            self.showHero=false
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
}
