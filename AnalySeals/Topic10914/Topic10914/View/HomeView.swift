//
//  HomeView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct HomeView: View
{
    //記錄深淺模式
    @AppStorage("activateDark") private var activeDark: Bool=false
    
    @Binding var selection: Int
    
    //重新整理筆記列表的狀態
    @State private var refresh: Bool=false
    //顯示ProgressView
    @State private var showLoading: Bool=true
    //顯示SearchView的狀態
    @State private var showSearch: Bool=false
    //筆記陣列
    @State private var note: [Note]=[]
    
    private func SearchViewButton() -> some View
    {
        Button
        {
            self.showSearch.toggle()
        }
        label:
        {
            RoundedRectangle(cornerRadius: 10)
                .fill(self.activeDark ? .gray:Color(.systemGray6))
                .frame(height: 40)
                .overlay(alignment: .leading)
                {
                    HStack
                    {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 11)
                            .padding(.leading, 10)
                        
                        Text("前往「搜尋筆記」畫面")
                    }
                    .foregroundStyle(Color(.backBar).opacity(0.5))
                }
                .padding(.horizontal)
        }
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: 背景
            //對應InView及UpView的位置
            BackgroundCapsule(y: -UIScreen.main.bounds.height/2.375)
            
            if(self.showLoading)
            {
                VStack(spacing: 5)
                {
                    self.SearchViewButton()
                    
                    //MARK: 載入動畫
                    List
                    {
                        ForEach(0..<5, id: \.self)
                        {index in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: UIScreen.main.bounds.size.height/3)
                                //載入動畫
                                .shimmer(
                                    ShimmerConfiguration(
                                        tint: Color(red: 225/255, green: 225/255, blue: 225/255),
                                        highlight: .black.opacity(0.5),
                                        blur: 5)
                                )
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 1))
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollDisabled(true)
                }
            }
            else if(self.note.isEmpty)
            {
                Image(.nothing)
                    .resizable()
                    .scaledToFit()
            }
            else
            {
                VStack(spacing: 5)
                {
                    self.SearchViewButton()
                    
                    //MARK: 筆記列表
                    List
                    {
                        //從資料庫讀取筆記
                        ForEach(self.note, id: \.self)
                        {index in
                            NoteView(
                                width: .infinity,
                                height: UIScreen.main.bounds.size.height/3,
                                headSize: 55,
                                titleSize: .title,
                                textSize: .title3,
                                tagSize: .body,
                                active: true,
                                activeSize: 30,
                                note: index,
                                refresh: self.$refresh
                            )
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    //刪除筆記之後刷新筆記列表
                    .onChange(of: self.refresh)
                    {(_, _) in
                        withAnimation(.smooth)
                        {
                            self.note.removeAll()
                        }
                        //等待Firebase刪除筆記
                        DispatchQueue.main.asyncAfter(deadline: .now()+1)
                        {
                            //從Firestore抓取筆記存到note
                            Firestorer().getNote(order: "date")
                            {note in
                                withAnimation(.smooth)
                                {
                                    self.note=note
                                }
                            }
                        }
                    }
                    //向下滑動重新整理
                    .refreshable
                    {
                        withAnimation(.smooth)
                        {
                            self.note.removeAll()
                        }
                        
                        //等待1秒
                        try? await SwiftUI.Task.sleep(nanoseconds: 1000000000)
                        
                        //從Firestore抓取筆記存到note
                        Firestorer().getNote(order: "date")
                        {note in
                            withAnimation(.smooth)
                            {
                                self.note=note
                            }
                        }
                    }
                }
            }
        }
        //解決BottomBarView背景顏色受到HomeView影響的問題
        .padding(.vertical, 0.5)
        //MARK: Firestore抓取筆記
        .onAppear
        {
            withAnimation(.easeInOut)
            {
                //從Firestore抓取筆記存到note
                Firestorer().getNote(order: "date")
                {note in
                    self.note=note
                    self.showLoading=false
                }
            }
        }
        //MARK: SearchView
        .fullScreenCover(isPresented: self.$showSearch)
        {
            SearchView()
        }
    }
}
