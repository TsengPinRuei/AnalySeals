//
//  CollectionView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/1.
//

import SwiftUI

struct CollectionView: View
{
    //關閉畫面的狀態
    @Environment(\.dismiss) private var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //matchedGeometryEffect用
    @Namespace private var animation
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    //現在所在標籤
    @State private var current: String="顯示全部"
    //筆記陣列
    @State private var note: [Note]=[]
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Color(.capsule).ignoresSafeArea(.all)
            
            VStack
            {
                //MARK: 標籤
                TagTab(current: self.$current)
                
                //MARK: 筆記
                HStack(alignment: .top, spacing: 0)
                {
                    if(self.note.isEmpty)
                    {
                        Image(.nothing)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                    else
                    {
                        //MARK: 左側筆記
                        List
                        {
                            ForEach(self.note.count/2..<self.note.count, id: \.self)
                            {index in
                                NoteView(
                                    width: .infinity,
                                    height: UIScreen.main.bounds.size.height/5,
                                    headSize: 35,
                                    titleSize: .subheadline,
                                    textSize: .subheadline,
                                    tagSize: .system(size: 0.01),
                                    active: false,
                                    activeSize: 20,
                                    note: self.note[index],
                                    refresh: .constant(false)
                                )
                            }
                            .padding(5)
                            //隱藏ListRow背景
                            .listRowBackground(Color.clear)
                            //讓筆記填滿整個ListRow
                            .listRowInsets(EdgeInsets())
                            //隱藏ListRow分隔線
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.inset)
                        .scrollContentBackground(.hidden)
                        
                        //MARK: 右側筆記
                        List
                        {
                            ForEach(0..<self.note.count/2, id: \.self)
                            {index in
                                NoteView(
                                    width: .infinity,
                                    height: UIScreen.main.bounds.size.height/5,
                                    headSize: 35,
                                    titleSize: .body,
                                    textSize: .subheadline,
                                    tagSize: .system(size: 0.01),
                                    active: false,
                                    activeSize: 20,
                                    note: self.note[index],
                                    refresh: .constant(false)
                                )
                            }
                            .padding(5)
                            //隱藏ListRow背景
                            .listRowBackground(Color.clear)
                            //讓筆記填滿整個ListRow
                            .listRowInsets(EdgeInsets())
                            //隱藏ListRow分隔線
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.inset)
                        //隱藏List預設背景
                        .scrollContentBackground(.hidden)
                    }
                }
                //MARK: 取得Firestore資料
                .onAppear
                {
                    //從Firestore抓取指定使用者的筆記存到note
                    Firestorer().getCollectionNote(user: self.user.account)
                    {note in
                        self.note=note.sorted
                        {(note1, note2) in
                            note1.date>note2.date
                        }
                    }
                }
            }
        }
        .modifyNavigationBarStyle(title: "我的收藏", display: .large)
        //MARK: 返回主頁
        .toolbar
        {
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
        //MARK: 標籤過濾
        //根據改變的標籤執行過濾
        .onChange(of: self.current)
        {(_, new) in
            self.note=[]
            if(new=="顯示全部")
            {
                //從Firestore抓取收藏的筆記存到note
                Firestorer().getCollectionNote(user: self.user.account)
                {note in
                    self.note=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
            else
            {
                //從Firestore抓取過濾標籤後的收藏的筆記存到note
                Firestorer().filterCollectionNote(user: self.user.account, tag: new)
                {note in
                    self.note=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
        }
    }
}
