//
//  LotteryView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/5/22.
//

import SwiftUI

struct LotteryView: View
{
    @AppStorage("lottery") private var lottery: [String]=[]
    
    @Binding var selection: Int
    
    @State private var showLottery: Bool=false
    @State private var degree: Double=0
    @State private var lotteryNumber: Int = -1
    @State private var height: CGFloat=100
    @State private var width: CGFloat=20
    @State private var y: CGFloat=400
    
    private let lotteryText: [String]=["你得配合環境行事", "木已成舟", "現在妥協 將來無恙", "及早開始", "你不會失望的", "放下吧", "天下無不散的筵席", "不必在意", "其他人不見得會贊同", "先把你的環境整理好", "現在就動起來吧", "你得先付出努力", "會有貴人的", "做就對了", "你可能有大麻煩了", "會有好結果的", "把握現在", "不要指望他", "問你自己", "一分耕耘 一分收穫"]
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                //MARK: 跑動畫的RoundedRectangle
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(self.width == .infinity ? .clear:Color(red: 245/255, green: 230/255, blue: 220/255))
                    .frame(maxWidth: self.width)
                    .frame(height: self.height)
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(self.y<400 ? 1:0)
                
                //MARK: 籤
                Image("lottery".appending(String(self.lotteryNumber)))
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(self.showLottery ? 1:0)
            }
            .offset(y: self.y)
            .zIndex(self.y<400 ? 100:0)
            
            Spacer()
            
            //MARK: 抽籤動畫
            Button
            {
                self.showLottery=false
                self.lotteryNumber=Int.random(in: 1...20)
                if(!self.lottery.contains(self.lotteryText[self.lotteryNumber-1]))
                {
                    self.lottery.append(self.lotteryText[self.lotteryNumber-1])
                }
                
                withAnimation(.easeIn)
                {
                    self.width=20
                    self.height=150
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(0.25))
                {
                    self.degree-=30
                }
                withAnimation(.linear.delay(0.5))
                {
                    self.y=400
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(0.5))
                {
                    self.degree+=60
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(0.75))
                {
                    self.degree-=60
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(1))
                {
                    self.degree+=60
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(1.25))
                {
                    self.degree-=60
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(1.5))
                {
                    self.degree+=60
                }
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(1.75))
                {
                    self.degree-=30
                }
                withAnimation(.linear.delay(2))
                {
                    self.y=0
                }
                withAnimation(.linear.delay(2.25))
                {
                    self.y=50
                }
                withAnimation(.easeOut.delay(2.5))
                {
                    self.width = .infinity
                    self.height=250
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2.5)
                {
                    withAnimation(.easeInOut)
                    {
                        self.showLottery=true
                    }
                }
            }
            label:
            {
                Image(.lotteryBox)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .rotationEffect(Angle(degrees: self.degree))
            }
        }
        .padding(.bottom)
    }
}
