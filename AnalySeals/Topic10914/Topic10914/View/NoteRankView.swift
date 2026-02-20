//
//  NoteRankView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/31.
//

import SwiftUI

struct NoteRankView: View
{
    @Environment(\.dismiss) private var dismiss
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    @State private var order: String="like"
    @State private var note: [Note]=[]
    
    //為了讓toolbar格式好看
    private let orderOption: [String]=["喜歡", "不喜歡", "收藏"]
    private let orderTag: [String]=["like", "dislike", "collect"]
    
    init()
    {
        let attribute: [NSAttributedString.Key:Any]=[.foregroundColor: UIColor(named: "SideColor") ?? .white]
        
        UISegmentedControl.appearance().selectedSegmentTintColor=UIColor(named: "SideTextColor")
        UISegmentedControl.appearance().setTitleTextAttributes(attribute,for: .selected)
    }
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Color(.background).ignoresSafeArea(.all)
            
            VStack
            {
                Picker("", selection: self.$order)
                {
                    ForEach(self.orderOption.indices, id: \.self)
                    {index in
                        Text(self.orderOption[index]).tag(self.orderTag[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color(.systemGray3))
                
                if(self.note.isEmpty)
                {
                    Image(.nothing)
                        .resizable()
                        .scaledToFit()
                }
                else
                {
                    //MARK: 所有筆記
                    List
                    {
                        ForEach(self.note.indices, id: \.self)
                        {index in
                            VStack(spacing: 5)
                            {
                                HStack(alignment: .bottom, spacing: 0)
                                {
                                    Text("第")
                                    
                                    Text(" \(index+1) ")
                                        .bold()
                                        .font(.title)
                                    
                                    Text("名")
                                }
                                .font(.headline)
                                .foregroundStyle(Color(.toolbar))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
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
                                    refresh: .constant(false)
                                )
                            }
                        }
                        .listRowBackground(Color(.backBar).opacity(0.2))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear
            {
                Firestorer().getNote(order: self.order.appending("Count"))
                {note in
                    self.note=note
                }
            }
            //MARK: 排序
            //根據改變的選項重新排序
            .onChange(of: self.order)
            {(_, new) in
                self.note.removeAll()
                Firestorer().getNote(order: new.appending("Count"))
                {note in
                    self.note=note
                }
            }
        }
        .modifyNavigationBarStyle(title: "筆記排名", display: .large)
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
    }
}
