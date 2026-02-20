//
//  TopBarView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct TopBarView: View
{
    //紀錄登入狀態
    @AppStorage("signIn") var signIn: Bool=false
    //進度表形式
    @AppStorage("toDoStyle") private var toDoStyle: Int=0
    
    //從ContentView綁定showSide
    @Binding var showSide: Bool
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    @State private var chineseName: Bool=false
    @State private var englishName: Bool=true
    //顯示MailView的狀態
    @State private var showToDo: Bool=false
    
    private func TitleName(name: String) -> some View
    {
        Text(name)
            .bold()
            .font(.largeTitle)
            .foregroundStyle(Color(.toolbar))
            .onTapGesture
            {
                if(self.englishName)
                {
                    withAnimation(.bouncy)
                    {
                        self.englishName.toggle()
                    }
                    withAnimation(.bouncy.delay(0.5))
                    {
                        self.chineseName.toggle()
                    }
                }
                else if(self.chineseName)
                {
                    withAnimation(.bouncy)
                    {
                        self.chineseName.toggle()
                    }
                    withAnimation(.bouncy.delay(0.5))
                    {
                        self.englishName.toggle()
                    }
                }
            }
    }
    
    var body: some View
    {
        HStack(spacing: 20)
        {
            //顯示英文名字
            if(self.englishName)
            {
                TitleName(name: "AnalySeals").transition(.asymmetric(insertion: .push(from: .leading), removal: .opacity))
            }
            //顯示中文名字
            else if(self.chineseName)
            {
                TitleName(name: "豹讀詩書").transition(.asymmetric(insertion: .push(from: .leading), removal: .opacity))
            }
            
            Spacer()
            
            //MARK: ToDoCalendarView || ToDoWeekView
            Button
            {
                self.showToDo.toggle()
            }
            label:
            {
                Image(systemName: "calendar.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
            }
            .fullScreenCover(isPresented: $showToDo)
            {
                if(self.toDoStyle==0)
                {
                    ToDoCalendarView()
                }
                else if(self.toDoStyle==1)
                {
                    ToDoWeekView()
                }
                else
                {
                    GeometryReader
                    {
                        ToDoMonthView(safeArea: $0.safeAreaInsets).ignoresSafeArea(.container, edges: .top)
                    }
                }
            }
            
            //MARK: SideView
            if(self.signIn)
            {
                Button
                {
                    withAnimation(.smooth)
                    {
                        self.showSide.toggle()
                    }
                }
                label:
                {
                    //MARK: 官方頭像
                    if(self.user.account=="topicgood123@gmail.com")
                    {
                        Image(.seal)
                            .resizable()
                            .scaledToFit()
                            .modifyHeadImageStyle(height: 50)
                    }
                    //MARK: 男生頭像
                    else if(self.user.gender=="男生")
                    {
                        Image(.male)
                            .resizable()
                            .scaledToFit()
                            .modifyHeadImageStyle(height: 50)
                    }
                    //MARK: 女生頭像
                    else if(self.user.gender=="女生")
                    {
                        Image(.female)
                            .resizable()
                            .scaledToFit()
                            .modifyHeadImageStyle(height: 50)
                    }
                    //MARK: ProgressView
                    else
                    {
                        ProgressView().frame(width: 50, height: 50)
                    }
                }
            }
            //MARK: InView
            else
            {
                NavigationLink(destination: InView())
                {
                    Image(.guest)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .clipShape(Circle())
                }
            }
        }
        .font(.title)
        .padding(.horizontal, 10)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color(.bottomBar))
    }
}
