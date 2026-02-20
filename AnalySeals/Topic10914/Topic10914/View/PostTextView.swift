//
//  PostTextView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/11.
//

import SwiftUI

struct PostTextView: View
{
    //紀錄登入狀態
    @AppStorage("signIn") var signIn: Bool=false
    
    //標題
    @Binding var noteTitle: String
    //內容
    @Binding var noteText: String
    //標籤
    @Binding var noteTag: String
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //ClearTextEditor的輸入狀態
    @FocusState private var focusEditor: Bool
    
    //MARK: 顯示頭像圖片
    private func setHead(gender: String) -> ImageResource
    {
        //官方帳號
        if(self.user.account=="topicgood123@gmail.com")
        {
            return .seal
        }
        //非官方帳號
        else
        {
            switch(gender)
            {
                case "男生":
                    return .male
                case "女生":
                    return .female
                default:
                    return .load
            }
        }
    }
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            //MARK: 背景筆記紙
            Image(.notePaper).resizable()
            
            VStack(spacing: 0)
            {
                HStack
                {
                    //MARK: 標題 內容
                    VStack(alignment: .leading)
                    {
                        Text("標題：\(self.noteTitle.count) / 20")
                            .foregroundStyle(self.noteTitle.count>10 ? .red:.black)
                            .contentTransition(.numericText())
                        
                        Text("內容：\(self.noteText.count) / 600")
                            .foregroundStyle(self.noteText.count>550 ? .red:.black)
                            .contentTransition(.numericText())
                    }
                    .bold()
                    
                    Spacer()
                    
                    VStack(alignment: .trailing)
                    {
                        //MARK: 清除標題按鈕
                        Button("清除標題")
                        {
                            withAnimation(.easeInOut)
                            {
                                self.noteTitle=""
                            }
                        }
                        .disabled(self.noteTitle.isEmpty)
                        .animation(.easeInOut, value: self.noteTitle)
                        
                        //MARK: 清除內容按鈕
                        Button("清除內容")
                        {
                            withAnimation(.easeInOut)
                            {
                                self.noteText=""
                            }
                        }
                        .disabled(self.noteText.isEmpty)
                        .animation(.easeInOut, value: self.noteText)
                    }
                    //設定按鈕主要顏色
                    .tint(.black)
                    
                    //MARK: 分隔線
                    Capsule()
                        .fill(.black)
                        .frame(width: 3, height: 40)
                        .padding(.horizontal, 5)
                    
                    //MARK: 完成按鈕
                    Button("完成")
                    {
                        //收回鍵盤
                        UIApplication.shared.dismissKeyboard()
                    }
                    .font(.headline)
                    //設定按鈕主要顏色
                    .tint(.black)
                }
                .font(.subheadline)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Rectangle().fill(Color(.rectangle).opacity(0.5)))
                //製造spacing
                .padding(.bottom, 5)
                
                HStack(spacing: 10)
                {
                    //MARK: 頭像
                    Image(self.signIn ? self.setHead(gender: self.user.gender):.guest)
                        .resizable()
                        .scaledToFit()
                        .modifyHeadImageStyle(height: 50)
                    
                    //MARK: 標題
                    TextField("", text: self.$noteTitle)
                        .placeholder(when: self.noteTitle.isEmpty)
                        {
                            Text("就決定是你了！小魚！")
                                .bold()
                                .font(.title)
                                .foregroundStyle(.gray)
                        }
                        .limitInput(text: self.$noteTitle, max: 20)
                        .bold()
                        .font(self.noteTitle.count<=15 ? .title:.title2)
                        .foregroundStyle(.black)
                        .submitLabel(.done)
                }
                .padding(.horizontal, 10)
                //製造spacing
                .padding(.vertical, 5)
                
                //MARK: 分隔線
                Capsule()
                    .fill(.black)
                    .frame(height: 1)
                    .padding(.horizontal)
                    //製造spacing
                    .padding(.vertical, 5)
                
                //MARK: TextEditor
                ClearTextEditor(text: self.$noteText, textColor: .black, textSize: .title3, max: 600)
                    .placeholder(when: self.noteText.isEmpty)
                    {
                        GeometryReader
                        {reader in
                            Text("小魚！使用泡沫水槍！\n噗嚕嚕嚕嚕嚕～")
                                .font(.title3)
                                .foregroundStyle(.gray)
                                //取得ClearTextEditor的最小座標
                                .offset(x: reader.frame(in: .local).minX, y: reader.frame(in: .local).minY)
                                //對應iPhone 14 Pro螢幕長寬
                                .padding(.top, 8.3)
                                .padding(.leading, 5.4)
                        }
                    }
                    //關注輸入狀態 以確定鍵盤狀態
                    .focused(self.$focusEditor)
                    //鍵盤出現時 長度縮小以看見最後輸入的文字 長度對應iPhone 14 Pro螢幕長寬
                    .frame(maxHeight: self.focusEditor ? 200:.infinity)
                    //.overlay(RoundedRectangle(cornerRadius: 10).stroke(.indigo, lineWidth: 1))
            }
        }
    }
}
