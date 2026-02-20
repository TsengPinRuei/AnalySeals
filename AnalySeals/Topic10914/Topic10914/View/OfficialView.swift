//
//  OfficialView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/1.
//

import SwiftUI

struct OfficialView: View
{
    @Environment(\.dismiss) private var dismiss
    
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
                
                if(self.note.isEmpty)
                {
                    Image(.nothing)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity, alignment: .center)
                }
                else
                {
                    //MARK: 官方筆記
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
                                activeSize: 30,
                                note: self.note[index],
                                refresh: .constant(false)
                            )
                        }
                        .listRowBackground(Color(.capsule))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                }
            }
            //MARK: Firestore抓取筆記
            .onAppear
            {
                //從Firestore抓取官方筆記存到note
                Firestorer().getUserNote(user: "topicgood123@gmail.com")
                {note in
                    self.note=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
        }
        .modifyNavigationBarStyle(title: "官方筆記", display: .inline)
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
        .onChange(of: self.current)
        {(_, new) in
            self.note.removeAll()
            if(new=="顯示全部")
            {
                //從Firestore抓取官方筆記存到note
                Firestorer().getUserNote(user: "topicgood123@gmail.com")
                {note in
                    self.note=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
            else
            {
                //MARK: Firestore過濾筆記
                //從Firestore抓取過濾標籤後的官方筆記存到note
                Firestorer().filterUserNote(user: "topicgood123@gmail.com", tag: new)
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
