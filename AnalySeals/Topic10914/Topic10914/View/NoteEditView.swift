//
//  NoteEditView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/3.
//

import SwiftUI

struct NoteEditView: View
{
    @Binding var note: Note
    
    //關閉當前畫面的狀態
    @Environment(\.dismiss) private var dismiss
    
    @State private var setTag: Bool=false
    
    private let tag: [String]=["學校資訊", "學業科目", "筆記攻略", "心情閒聊", "音樂", "繁星推薦", "個人申請", "考試分發", "特殊選才", "登記分發", "推薦甄試", "國外留學"]
    
    //MARK: 更新筆記
    private func updateNote() async
    {
        //標籤有更新
        if(self.setTag)
        {
            Firestorer()
                .updateNoteColumn(
                    note: self.note.userId,
                    column: "Note",
                    title: self.note.title,
                    text: self.note.text,
                    tag: self.note.tag
                )
        }
        //標籤沒更新
        else
        {
            Firestorer()
                .updateNoteColumn(
                    note: self.note.userId,
                    column: "Note",
                    title: self.note.title,
                    text: self.note.text
                )
        }
    }
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Image(.notePaper).resizable()
            
            VStack(spacing: 0)
            {
                //MARK: 字數
                HStack(alignment: .bottom)
                {
                    Text("標題字數：\(self.note.title.count) / 20").foregroundStyle(self.note.title.count>10 ? .red:Color(.backBar))
                    
                    Spacer()
                    
                    Text("內容字數：\(self.note.text.count) / 600").foregroundStyle(self.note.text.count>550 ? .red:Color(.backBar))
                }
                .font(.headline)
                .padding(10)
                .background(Color(.background))
                
                //MARK: 標題
                TextField("", text: self.$note.title)
                    .placeholder(when: self.note.title.isEmpty)
                    {
                        Text("標題...")
                            .bold()
                            .font(.title)
                            .foregroundStyle(.gray)
                    }
                    //字數限制20字
                    .limitInput(text: self.$note.title, max: 20)
                    .bold()
                    .font(.title)
                    .foregroundStyle(.black)
                    .submitLabel(.done)
                    .padding(10)
                
                Capsule()
                    .fill(.black)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                
                //MARK: 內容
                ClearTextEditor(text: self.$note.text, textColor: .black, textSize: .title3, max: 600)
                    .placeholder(when: self.note.text.isEmpty)
                    {
                        GeometryReader
                        {reader in
                            Text("內容...")
                                .font(.title3)
                                .foregroundStyle(.gray)
                                //取得ClearTextEditor的最小座標
                                .offset(x: reader.frame(in: .local).minX, y: reader.frame(in: .local).minY)
                                //對應iPhone 14 Pro格式
                                .padding(.top, 8.3)
                                .padding(.leading, 5.4)
                        }
                    }
                    //.overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
            }
            .foregroundStyle(Color(.fieldText))
        }
        .ignoresSafeArea(edges: .bottom)
        .ignoresSafeArea(.keyboard)
        .navigationTitle("編輯筆記")
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.bottomBar), for: .navigationBar)
        .toolbar
        {
            //MARK: 標籤
            ToolbarItem(placement: .topBarTrailing)
            {
                Picker("", selection: self.$note.tag)
                {
                    ForEach(self.tag, id: \.self)
                    {index in
                        Text(index)
                    }
                }
                .onChange(of: self.note.tag)
                {(_, _) in
                    self.setTag=true
                }
            }
            
            //MARK: 完成按鈕
            ToolbarItem(placement: .topBarTrailing)
            {
                Button
                {
                    UIApplication.shared.dismissKeyboard()
                    if(!self.note.title.isEmpty && !self.note.text.isEmpty)
                    {
                        SwiftUI.Task
                        {
                            await self.updateNote()
                            self.dismiss()
                        }
                    }
                }
                label:
                {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
}
