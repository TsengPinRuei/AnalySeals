//
//  SearchView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/15.
//

import SwiftUI

struct SearchView: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    //搜尋紀錄
    @AppStorage("history") private var history: [String]=[]
    
    //View返回的狀態
    @Environment(\.dismiss) private var dismiss
    
    //搜尋欄中的字串
    @State private var text: String=""
    //筆記陣列
    @State private var note: [Note]=[]
    
    private let tag: [String]=["學校資訊", "學業科目", "筆記攻略", "心情閒聊", "音樂", "繁星推薦", "個人申請", "考試分發", "特殊選才", "登記分發", "推薦甄試", "國外留學"]
    
    //MARK: Firestore
    private func searchNote()
    {
        //從標籤尋找符合關鍵字的筆記
        Firestorer().searchNote(column: "tag", text: self.text)
        {note in
            self.note.append(contentsOf: note)
        }
        //從標題尋找符合關鍵字的筆記
        Firestorer().searchNote(column: "title", text: self.text)
        {note in
            //self.note.append(contentsOf: note)
            for i in note
            {
                if(!self.note.contains(i))
                {
                    self.note.append(i)
                }
            }
        }
        //從內容尋找符合關鍵字的筆記
        Firestorer().searchNote(column: "text", text: self.text)
        {note in
            //self.note.append(contentsOf: note)
            for i in note
            {
                if(!self.note.contains(i))
                {
                    self.note.append(i)
                }
            }
        }
    }
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color(.background).ignoresSafeArea(.keyboard)
                
                //尚未搜尋 或 無搜尋結果
                if(self.note.isEmpty)
                {
                    //MARK: 無結果圖片
                    Image(.nothing)
                        .resizable()
                        .scaledToFit()
                        .transition(.opacity.animation(.easeInOut))
                }
                //搜尋之後 或 有搜尋結果
                else
                {
                    //MARK: 筆記列
                    List
                    {
                        ForEach(self.note, id: \.self)
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
                                note: index,
                                refresh: .constant(false)
                            )
                        }
                        .listRowBackground(Color(.background))
                        .transition(.opacity.animation(.easeInOut))
                    }
                    .listStyle(.plain)
                }
            }
            //不能用all是因為搜尋結果會被其他View覆蓋
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("筆記搜尋")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.capsule), for: .navigationBar)
            //MARK: Toolbar
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
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                }
            }
        }
        //利用Github的套件讓SwiftUI更方便使用UIKit的功能
        .introspect(.textField, on: .iOS(.v15, .v16, .v17))
        {field in
            //更改搜尋列背景顏色
            field.backgroundColor = self.activateDark ? UIColor.gray:UIColor.white
        }
        //MARK: 搜尋列
        .searchable(text: self.$text, placement: .navigationBarDrawer(displayMode: .always), prompt: "今天 你想找點 什麼筆記")
        {
            //還沒搜尋時顯示
            if(self.text.isEmpty)
            {
                HStack
                {
                    Text("最近搜尋").bold()
                    
                    Spacer()
                    
                    Button("清除")
                    {
                        self.history.removeAll()
                    }
                    .foregroundStyle(.red)
                    //history有資料才跑出來
                    .offset(x: self.history.isEmpty ? 60:0)
                    .animation(.easeInOut, value: self.history.isEmpty)
                }
                
                //MARK: 最近搜尋
                ForEach(self.history.indices, id: \.self)
                {index in
                    Text(self.history[index])
                        .foregroundStyle(Color(.backBar))
                        .padding(.horizontal)
                        .searchCompletion(self.history[index])
                }
                .onDelete
                {index in
                    self.history.remove(atOffsets: index)
                }
                
                Text("筆記標籤").bold()
                
                //MARK: 標籤搜尋
                ForEach(self.tag, id: \.self)
                {index in
                    Text("# \(index)")
                        .foregroundStyle(Color(.toolbar))
                        .padding(.horizontal)
                        .searchCompletion(index)
                }
            }
        }
        //加入到最近搜尋
        .onSubmit(of: .search)
        {
            //不重複加入最近搜尋 && 不加入空字串
            if(!self.history.contains(self.text) && !self.text.isEmpty)
            {
                self.history.insert(self.text, at: 0)
            }
            else if(self.history.contains(self.text))
            {
                self.history.remove(at: self.history.firstIndex(of: self.text)!)
                self.history.insert(self.text, at: 0)
            }
            
            self.note.removeAll()
            //有搜尋
            if(!self.text.isEmpty)
            {
                self.searchNote()
            }
        }
    }
}
