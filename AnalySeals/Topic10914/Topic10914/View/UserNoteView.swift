//
//  UserNoteView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/29.
//

import SwiftUI

struct UserNoteView: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    
    @Binding var note: Note
    
    @Environment(\.dismiss) private var dismiss
    
    //matchedGeometryEffect用
    @Namespace private var animation
    
    @State private var showUser: Bool=false
    @State private var name: String?
    //現在所在標籤
    @State private var current: String="顯示全部"
    //筆記陣列
    @State private var currentNote: [Note]=[]
    
    var body: some View
    {
        NavigationStack
        {
            ZStack(alignment: .top)
            {
                Color(.capsule).ignoresSafeArea(.all)
                
                VStack
                {
                    //MARK: 標籤
                    TagTab(current: self.$current)
                    
                    if(self.currentNote.isEmpty)
                    {
                        Image(.nothing)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                    else
                    {
                        //MARK: 筆記列表
                        List
                        {
                            ForEach(self.currentNote.indices, id: \.self)
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
                                    note: self.currentNote[index],
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
                //MARK: Firestore
                .onAppear
                {
                    //從Firestore抓取指定使用者的筆記存到note
                    Firestorer().getUserNote(user: self.note.user)
                    {note in
                        self.currentNote=note.sorted
                        {(note1, note2) in
                            note1.date>note2.date
                        }
                    }
                }
            }
            .modifyNavigationBarStyle(title: (self.name ?? "").appending("的筆記"), display: .inline)
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
                            .foregroundStyle(self.activateDark ? .white:.black)
                    }
                }
            }
            //MARK: Firestore
            .onAppear
            {
                //取得作者名字
                Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Name")
                {data in
                    self.name=data
                }
            }
        }
        //MARK: 標籤過濾
        .onChange(of: self.current)
        {(_, new) in
            self.currentNote.removeAll()
            if(new=="顯示全部")
            {
                //從Firestore抓取指定使用者的筆記存到note
                Firestorer().getUserNote(user: self.note.user)
                {note in
                    self.currentNote=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
            else
            {
                //從Firestore抓取過濾標籤後的指定使用者的筆記存到note
                Firestorer().filterUserNote(user: self.note.user, tag: new)
                {note in
                    self.currentNote=note.sorted
                    {(note1, note2) in
                        note1.date>note2.date
                    }
                }
            }
        }
    }
}
