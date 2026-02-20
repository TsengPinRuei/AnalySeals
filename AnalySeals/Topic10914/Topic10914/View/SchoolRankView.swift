//
//  SchoolRankView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/19.
//

import SwiftUI

struct SchoolRankView: View
{
    @Environment(\.dismiss) private var dismiss
    
    @State private var rank: String="Academic"
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    //Tab選擇器用
    @State private var current: RankTab = .normal
    @State private var shake: CGFloat=0
    
    enum RankTab: String
    {
        case normal="普通大學"
        case technology="科技大學"
    }
    
    //MARK: 大學種類選擇
    private func TabText(_ tab: RankTab) -> some View
    {
        Text(tab.rawValue)
            .font(.title3)
            .fontWeight(.semibold)
            .contentTransition(.interpolate)
            .padding(.vertical, 12)
            .padding(.horizontal, 40)
            .contentShape(.rect)
            .onTapGesture
            {
                withAnimation(.snappy)
                {
                    self.current=tab
                }
                
                //動畫時甩動tab會更具體
                withAnimation(.bouncy)
                {
                    self.shake=tab == .normal ? -10:10
                }
                
                //當動畫結束時 讓tab回到原位置
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2)
                {
                    withAnimation(.bouncy)
                    {
                        self.shake=0
                    }
                }
            }
    }
    
    var body: some View
    {
        VStack
        {
            //MARK: Tab選擇器
            HStack(spacing: 0)
            {
                TabText(.normal)
                    .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
                    //當前選擇的動態Tab
                    .overlay
                    {
                        //只需要實現其中一邊的圓角度數 所以建立一個自定義圖形
                        TabCorner(corner: [.topLeft, .bottomLeft], radius: 60)
                            .fill(Color(.side))
                            .overlay
                        {
                            TabText(.technology)
                                .foregroundStyle(self.current == .normal ? .clear:Color(.sideText))
                            //翻面之後會水平顛倒 要顛倒回來
                                .scaleEffect(x: -1)
                        }
                        .overlay(TabText(.normal).foregroundStyle(self.current == .normal ? Color(.sideText):.clear))
                        //翻面動畫
                        .rotation3DEffect(
                            .init(
                                degrees: self.current == .normal ? 0:180),
                            axis: (x: 0, y: 1, z: 0),
                            anchor: .trailing,
                            perspective: 0.5
                        )
                    }
                    //推到最上面
                    .zIndex(1)
                    .contentShape(.rect)
                
                TabText(.technology)
                    .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
                    .zIndex(0)
            }
            .background
            {
                ZStack
                {
                    Capsule().fill(Color(.capsule))
                    
                    Capsule().stroke(Color(.capsule), lineWidth: 10)
                }
            }
            //甩動
            .rotation3DEffect(.init(degrees: self.shake), axis: (x: 0, y: 1, z: 0))
            .padding(.top)
            .padding(.bottom, 10)
            
            //MARK: View
            TabView(selection: self.$current)
            {
                NormalRankView(rank: self.$rank).tag(RankTab.normal)
                
                TechnologyRankView(rank: self.$rank).tag(RankTab.technology)
            }
            //利用Github的套件讓SwiftUI更方便使用UIKit的功能
            .introspect(.tabView, on: .iOS(.v13, .v14, .v15, .v16, .v17))
            {tab in
                //隱藏TabView中的tabBar
                tab.tabBar.isHidden=true
            }
        }
        .background(Color(red: 200/255, green: 200/255, blue: 200/255))
        .modifyNavigationBarStyle(title: "學校排名", display: .inline)
        //MARK: Toolbar
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
            
            //MARK: Picker
            ToolbarItem(placement: .topBarTrailing)
            {
                Picker("", selection: self.$rank)
                {
                    Text("Academic").tag("Academic")
                    
                    Text("Center").tag("Center")
                    
                    Text("QS").tag("QS")
                    
                    Text("THE").tag("THE")
                    
                    Text("US News").tag("USNews")
                }
                .tint(Color(.toolbar))
            }
        }
        .onAppear
        {
            //0.5秒之後再顯示返回主頁 比較順暢好看
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
            {
                withAnimation(.easeInOut)
                {
                    self.showBackButton=true
                }
            }
        }
    }
}
