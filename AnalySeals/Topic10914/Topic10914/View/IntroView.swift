//
//  IntroView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/25.
//

import SwiftUI

struct IntroView: View
{
    //顯示倒數的狀態
    @State private var showCountDown: Bool=false
    //顯示文字的狀態
    @State private var showText: Bool=false
    @State private var sleep: Bool=false
    //啟動應用程式的狀態
    @State private var start: Bool=false
    @State private var count: Int=0
    @State private var text: String=""
    //圖片及名稱透明度
    @State private var opacity: CGFloat=0.5
    //圖片大小
    @State private var scale: CGFloat=0.5
    //計時器
    @State private var timer: Timer?
    
    //倒數用
    private let calendar: Calendar=Calendar.current
    private let backColor: Color=Color(red: 229/255, green: 227/255, blue: 205/255)
    private let nameColor: Color=Color(red: 53/255, green: 72/255, blue: 45/255)
    private let textColor: Color=Color(red: 40/255, green: 53/255, blue: 45/255)
    //統測倒數 學測倒數
    private var component: (DateComponents, DateComponents)=(DateComponents(), DateComponents())
    private let emotion: [ImageResource]=[.emotionVeryAngry, .emotionAngry, .emotionNormal, .emotionHappy, .emotionVeryHappy]
    
    private func setText() -> String
    {
        let topic: [String] =
        [
            "有人說光是「粒子」\n有人說光是「波」\n那你覺得光是什麼\n光是找大學就筋疲力盡了",
            "有人相愛\n有人夜裡開車看海\n有人連大學都選不出來",
            "「大學英文怎麼拼？」\n「UNIVERSITY」\n「我拼VERSITY欸。\n  有你，大學生活才完整。」",
            "沒大學找得到工作嗎？\n好工作不會，但茶湯會。",
            "分什麼社會組還是自然組，\n有大學都是人生勝利組。"
        ]
        
        return topic[Int.random(in: 0..<topic.count)]
    }
    
    //MARK: init()
    init()
    {
        self.component.0.year=2024
        self.component.0.month=5
        self.component.0.day=4
        self.component.1.year=2024
        self.component.1.month=1
        self.component.1.day=20
    }
    
    var body: some View
    {
        if(self.start)
        {
            //MARK: ContentView
            ContentView().transition(.opacity)
        }
        else
        {
            ZStack
            {
                //MARK: 背景顏色
                self.backColor.ignoresSafeArea(.all)
                
                //MARK: 時間倒數
                TimelineView(.periodic(from: .now, by: 1))
                {time in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hexa: "999999").opacity(0.5))
                        .frame(height: self.showCountDown ? 100:50)
                        .frame(maxWidth: self.showCountDown ? .infinity:180)
                        .overlay
                        {
                            if(self.showCountDown)
                            {
                                HStack
                                {
                                    //MARK: 統測倒數
                                    VStack
                                    {
                                        Text("統一入學測驗")
                                        
                                        if let date=self.calendar.date(from: self.component.0)
                                        {
                                            Text(date, style: .timer)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    //MARK: 分科倒數
                                    VStack
                                    {
                                        Text("學科能力測驗")
                                        
                                        if let date=self.calendar.date(from: self.component.1)
                                        {
                                            Text(date, style: .timer)
                                        }
                                    }
                                }
                                .bold()
                                .font(.title3)
                                .foregroundStyle(self.textColor)
                                .padding()
                                .transition(.scale.animation(.snappy))
                            }
                            else
                            {
                                //MARK: 未顯示測驗倒數
                                Text("打開測驗倒數")
                                    .bold()
                                    .font(.title3)
                                    .foregroundStyle(self.textColor)
                                    .padding()
                                    .transition(.opacity)
                            }
                        }
                        .onTapGesture
                        {
                            withAnimation(.bouncy)
                            {
                                self.showCountDown.toggle()
                            }
                        }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal)
                .padding(.top, UIScreen.main.bounds.height*0.1)
                
                //讓文字對齊圖片
                HStack
                {
                    VStack
                    {
                        //MARK: 圖片
                        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            //文字顯示後縮小圖片
                            .frame(width: self.showText ? 100:150)
                            //文字顯示後縮小角度
                            .clipShape(.rect(cornerRadius: self.showText ? 10:20))
                            .background
                            {
                                RoundedRectangle(cornerRadius: self.showText ? 10:20).fill(.black.shadow(.drop(radius: 5)))
                            }
                        
                        //MARK: 名稱
                        Text("豹讀詩書\nAnalySeals")
                            .bold()
                            //文字顯示後縮小名稱字體
                            .font(self.showText ? .body:.title)
                            .foregroundStyle(self.nameColor)
                            .multilineTextAlignment(.center)
                    }
                    .scaleEffect(self.scale)
                    .opacity(self.opacity)
                    
                    //顯示文字時才將圖片及名稱擠過去
                    if(self.showText)
                    {
                        //MARK: 文字
                        Text(self.text)
                            .bold()
                            .font(.title3)
                            .foregroundStyle(self.textColor)
                            .onTapGesture
                            {
                                withAnimation(.easeInOut)
                                {
                                    self.text=self.setText()
                                }
                            }
                            .transition(.push(from: .trailing))
                    }
                }
                
                //MARK: 睡眠畫面
                if(self.sleep)
                {
                    ZStack
                    {
                        Color.black
                            .opacity(0.8)
                            .ignoresSafeArea(.all)
                        
                        Image(self.emotion[self.count%self.emotion.count])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            //啟動計時器 更改海報圖案
                            .onAppear
                            {
                                self.count=0
                                self.timer=Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true)
                                {_ in
                                    self.count+=1
                                }
                            }
                            //關閉計時器
                            .onDisappear
                            {
                                self.timer?.invalidate()
                                self.timer=nil
                            }
                    }
                    .transition(.opacity)
                }
                
                //MARK: 睡眠模式
                Button
                {
                    withAnimation(.smooth)
                    {
                        self.sleep = !self.sleep
                        //防止螢幕關閉
                        UIApplication.shared.isIdleTimerDisabled=self.sleep
                        //調整螢幕亮度到最暗
                        UIScreen.main.brightness=self.sleep ? 0:0.6
                    }
                }
                label:
                {
                    Text("睡眠模式")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(.black))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding([.top, .trailing])
            }
            .transition(.opacity)
            //MARK: 強制啟動
            .onTapGesture
            {
                if(!self.sleep)
                {
                    withAnimation(.easeInOut)
                    {
                        self.start=true
                    }
                }
            }
            //MARK: 圖片動畫
            .onAppear
            {
                //耗時1.2秒
                withAnimation(.easeInOut(duration: 1.2), completionCriteria: .logicallyComplete)
                {
                    self.scale=1
                    self.opacity=1
                }
                completion:
                {
                    //顯示文字動畫
                    withAnimation(.easeInOut(duration: 1.2))
                    {
                        self.text=self.setText()
                        self.showText=true
                    }
                }
            }
        }
    }
}
