//
//  MyNoteView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/28.
//

import SwiftUI

struct MyNoteView: View
{
    @Environment(\.dismiss) private var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //matchedGeometryEffect用
    @Namespace private var animation
    
    //重新整理筆記列表的狀態
    @State private var refresh: Bool=false
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    @State private var showUser: Bool=false
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
                
                if(self.note.isEmpty)
                {
                    Image(.nothing)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                //MARK: 筆記列表
                else
                {
                    List
                    {
                        ForEach(self.note.indices, id: \.self)
                        {index in
                            NoteView(
                                width: .infinity,
                                height: UIScreen.main.bounds.size.height/4,
                                headSize: 45,
                                titleSize: .title3,
                                textSize: .body,
                                tagSize: .subheadline,
                                active: true,
                                activeSize: 25,
                                note: self.note[index],
                                refresh: self.$refresh
                            )
                        }
                        .listRowBackground(Color(.capsule))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    //刪除筆記之後刷新筆記列表
                    .onChange(of: self.refresh)
                    {(_, _) in
                        //移除所有筆記
                        withAnimation(.easeInOut)
                        {
                            self.note.removeAll()
                        }
                        //等Firebase刪除筆記
                        DispatchQueue.main.asyncAfter(deadline: .now()+1)
                        {
                            //根據當前標籤抓筆記
                            if(self.current=="顯示全部")
                            {
                                //從Firestore抓取指定使用者的筆記筆記存到note
                                Firestorer().getUserNote(user: self.user.account)
                                {note in
                                    withAnimation(.easeInOut)
                                    {
                                        self.note=note.sorted
                                        {(note1, note2) in
                                            note1.date>note2.date
                                        }
                                    }
                                }
                            }
                            else
                            {
                                Firestorer().filterUserNote(user: self.user.account, tag: self.current)
                                {note in
                                    withAnimation(.easeInOut)
                                    {
                                        self.note=note.sorted
                                        {(note1, note2) in
                                            note1.date>note2.date
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //MARK: 筆記篩選
            .onAppear
            {
                //從Firestore抓取指定使用者的筆記存到note
                Firestorer().getUserNote(user: self.user.account)
                {note in
                    self.note=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
        }
        .modifyNavigationBarStyle(title: "我的筆記", display: .inline)
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
        //MARK: 標籤過濾筆記
        .onChange(of: self.current)
        {(_, new) in
            //移除所有筆記
            withAnimation(.easeInOut)
            {
                self.note.removeAll()
            }
            //根據當前標籤抓筆記
            if(new=="顯示全部")
            {
                //從Firestore抓取指定使用者的筆記筆記存到note
                Firestorer().getUserNote(user: self.user.account)
                {note in
                    withAnimation(.easeInOut)
                    {
                        self.note=note.sorted
                        {(note1, note2) in
                            note1.date>note2.date
                        }
                    }
                }
            }
            else
            {
                Firestorer().filterUserNote(user: self.user.account, tag: new)
                {note in
                    withAnimation(.easeInOut)
                    {
                        self.note=note.sorted
                        {(note1, note2) in
                            note1.date>note2.date
                        }
                    }
                }
            }
        }
    }
}
