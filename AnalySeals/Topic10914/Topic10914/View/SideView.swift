//
//  SideView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/14.
//

import SwiftUI

let itemId: Int=10914000

//sideBar的背景顏色
var sideColor: Color=Color(.side)
//存放系統相關的設定
var System: [SideItem]=[
    //因為要對齊 所以前面加一個空格
    SideItem(id: itemId+1,icon: "doc.text.image", text: "筆記"),
    SideItem(id: itemId+2,icon: "bookmark.fill", text: " 收藏"),
    SideItem(id: itemId+3,icon: "gearshape.fill", text: "設定"),
    SideItem(id: itemId+9,icon: "wand.and.stars", text: "心誠則靈")
]
//存放使用者可以執行的操作
var Action: [SideItem]=[
    SideItem(id: itemId+4, icon: "tray.full.fill",text: "消息通知"),
    SideItem(id: itemId+5, icon: "link",text: "學校連結"),
    SideItem(id: itemId+6, icon: "chart.bar.fill",text: "學校排名"),
    SideItem(id: itemId+7, icon: "",text: "官方筆記"),
    SideItem(id: itemId+8, icon: "chart.bar.doc.horizontal",text: "筆記排名"),
]

struct SideView: View
{
    //顯示SideView的狀態
    @Binding var showSide: Bool
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //GeometryReader的背景顏色
    var backColor: Color=Color.black.opacity(0.5)
    //sideBar的寬度
    var sideWidth: CGFloat=UIScreen.main.bounds.size.width*0.6
    //sideBar上的資訊
    var information: some View
    {
        VStack(alignment: .leading)
        {
            HStack(spacing: 10)
            {
                //MARK: 頭像
                if(self.user.account=="topicgood123@gmail.com")
                {
                    Image(.seal)
                        .resizable()
                        .scaledToFit()
                        .modifyHeadImageStyle(height: 50)
                        .aspectRatio(3/2, contentMode: .fill)
                        .shadow(color: .white, radius: 3)
                }
                //MARK: 男生
                else if(self.user.gender=="男生")
                {
                    Image(.male)
                        .resizable()
                        .scaledToFit()
                        .modifyHeadImageStyle(height: 50)
                        .aspectRatio(3/2, contentMode: .fill)
                        .shadow(color: .indigo, radius: 3)
                }
                //MARK: 女生
                else if(self.user.gender=="女生")
                {
                    Image(.female)
                        .resizable()
                        .scaledToFit()
                        .modifyHeadImageStyle(height: 50)
                        .aspectRatio(3/2, contentMode: .fill)
                        .shadow(color: .purple, radius: 3)
                }
                //MARK: ProgressView
                else
                {
                    ProgressView().frame(width: 50, height: 50)
                }
                
                NavigationLink(destination: ProfileView())
                {
                    VStack(alignment: .leading, spacing: 3)
                    {
                        //MARK: 名字
                        Text(self.user.name.isEmpty ? "Loading...":self.user.name)
                            .bold()
                            .font(.title3)
                        
                        //MARK: 個性簽名
                        if let bio=self.user.bio
                        {
                            Text(bio.isEmpty ? "啵啵啵...啵啵":bio)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                //避免行數太多擠壓到下面
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                        }
                        else
                        {
                            Text("啵啵啵...啵啵")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                //避免行數太多擠壓到下面
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .padding(.leading, 20)
        }
    }
    
    //MARK: 側邊欄
    var sideBar: some View
    {
        HStack(alignment: .top)
        {
            ZStack(alignment: .top)
            {
                //背景顏色
                sideColor
                
                VStack(alignment: .leading, spacing: 20)
                {
                    information
                    Divider().padding(.top, 10)
                    SideDisplay(item: Action)
                    Divider()
                    SideDisplay(item: System)
                }
                .padding(.top, 70)
            }
            .frame(width: sideWidth)
            //根據showSide決定是否顯示sideBar 顯示時會移動到x:0的座標位置
            .offset(x: showSide ? 0:-sideWidth)
            //以動畫方式呈現SideView
            .animation(.smooth, value: showSide)
            
            Spacer()
        }
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: sideBar顯示時的背景
            GeometryReader
            {_ in
                EmptyView()
            }
            .background(backColor)
            //根據showSide決定是否顯示GeometryReader
            .opacity(self.showSide ? 1:0)
            .animation(.smooth, value: self.showSide)
            //點擊GeometryReader也可以關閉sideBar
            .onTapGesture
            {
                self.showSide.toggle()
            }
            
            self.sideBar
        }
        .ignoresSafeArea(.keyboard)
        .ignoresSafeArea(.all)
    }
}
