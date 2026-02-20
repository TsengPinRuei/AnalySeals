//
//  MarkView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/19.
//

import SwiftUI

struct MarkView: View
{
    //紀錄登入狀態
    @AppStorage("signIn") private var signIn: Bool=false
    
    @Binding var note: Note
    @Binding var showMark: Bool
    @Binding var showFullImage: Bool
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    var body: some View
    {
        Image(.mark)
            .resizable()
            .frame(width: UIScreen.main.bounds.width+50, height: 150)
            .onTapGesture
            {
                self.showMark.toggle()
            }
            //MARK: 喜歡 不喜歡 收藏 標籤
            .overlay(alignment: .center)
            {
                HStack(spacing: 30)
                {
                    //MARK: 標籤
                    Text(self.note.tag.count==2 ? self.note.tag:"\(self.note.tag[0...1])\n\(self.note.tag[2...3])")
                        .bold()
                        .font(self.note.tag.count==2 ? .title:.title2)
                        .foregroundStyle(.indigo)
                    
                    Button
                    {
                        //MARK: 取消喜歡
                        if(self.note.like.contains(self.user.account))
                        {
                            //從like陣列中移除該帳號
                            Firestorer().deleteNoteColumn(note: self.note.userId, column: "like", user: self.user.account)
                            self.note.like.remove(at: self.note.like.firstIndex(of: self.user.account) ?? -1)
                            //從likeCount-1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "likeCount", number: -1)
                        }
                        //MARK: 喜歡
                        else
                        {
                            //從like陣列中新增該帳號
                            Firestorer().updateNoteColumn(note: self.note.userId, column: "like", user: self.user.account)
                            self.note.like.append(self.user.account)
                            //從likeCount+1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "likeCount", number: 1)
                        }
                    }
                    label:
                    {
                        Image(self.note.like.contains(self.user.account) ? "likeR":"likeW")
                            .resizable()
                            .scaledToFit()
                    }
                    //沒有登入不可以使用
                    .disabled(!self.signIn)
                    
                    Button
                    {
                        //MARK: 取消不喜歡
                        if(self.note.dislike.contains(self.user.account))
                        {
                            //從dislike陣列中移除該帳號
                            Firestorer().deleteNoteColumn(note: self.note.userId, column: "dislike", user: self.user.account)
                            self.note.dislike.remove(at: self.note.dislike.firstIndex(of: self.user.account) ?? -1)
                            //從dislikeCount-1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "dislikeCount", number: -1)
                        }
                        //MARK: 不喜歡
                        else
                        {
                            //從dislike陣列中新增該帳號
                            Firestorer().updateNoteColumn(note: self.note.userId, column: "dislike", user: self.user.account)
                            self.note.dislike.append(self.user.account)
                            //從dislikeCount+1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "dislikeCount", number: 1)
                        }
                    }
                    label:
                    {
                        Image(self.note.dislike.contains(self.user.account) ? "dislikeG":"dislikeW")
                            .resizable()
                            .scaledToFit()
                    }
                    //沒有登入不可以使用
                    .disabled(!self.signIn)
                    
                    Button
                    {
                        //MARK: 取消收藏
                        if(self.note.collect.contains(self.user.account))
                        {
                            //從collect陣列中移除該帳號
                            Firestorer().deleteNoteColumn(note: self.note.userId, column: "collect", user: self.user.account)
                            self.note.collect.remove(at: self.note.collect.firstIndex(of: self.user.account) ?? -1)
                            //從collectCount-1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "collectCount", number: -1)
                        }
                        //MARK: 收藏
                        else
                        {
                            //從collect陣列中新增該帳號
                            Firestorer().updateNoteColumn(note: self.note.userId, column: "collect", user: self.user.account)
                            self.note.collect.append(self.user.account)
                            //從collectCount+1
                            Firestorer().updateNoteCountColumn(note: self.note.userId, column: "collectCount", number: 1)
                        }
                    }
                    label:
                    {
                        Image(systemName: self.note.collect.contains(self.user.account) ? "bookmark.fill":"bookmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blue)
                    }
                    .animation(.bouncy(duration: 0.9), value: self.note.collect)
                    //沒有登入不可以使用
                    .disabled(!self.signIn)
                }
                .frame(height: 60)
                .padding(.horizontal)
            }
            .opacity(self.showFullImage ? 0:(self.showMark ? 1:0.5))
            //20是讓書籤展開時不會超出螢幕 -40是讓書籤收起可以顯示出頭部
            .offset(x: self.showMark ? 20:UIScreen.main.bounds.size.width-40)
            .animation(.bouncy(duration: 0.9), value: self.showMark)
            .padding(.bottom, 30)
    }
}
