//
//  MBTIHistoryView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/28.
//

import SwiftUI

struct MBTIHistoryView: View
{
    //MBTI作答
    @AppStorage("mbtiAnswer") private var mbtiAnswer: [Double]=Array(repeating: 3, count: 60)
    //MBTI歷史作答
    @AppStorage("mbtiHistory") private var mbtiHistory: [[Double]]=[]
    
    //當前作答題號
    @Binding var index: Int
    //DisclosureGroup的展開狀態
    @Binding var expand: [Bool]
    
    //顯示歷史紀錄的狀態
    @State private var showHistory: Bool=false
    
    let option: [String]
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                //MARK: 背景顏色
                Color(.background).ignoresSafeArea(.all)
                
                if(self.showHistory)
                {
                    if(!self.mbtiHistory.isEmpty)
                    {
                        //MARK: 歷史紀錄
                        List
                        {
                            ForEach(self.mbtiHistory.indices, id: \.self)
                            {iIndex in
                                DisclosureGroup("\(iIndex+1)", isExpanded: self.$expand[iIndex])
                                {
                                    ForEach(self.mbtiHistory[iIndex].indices, id: \.self)
                                    {jIndex in
                                        HStack
                                        {
                                            Text("\(jIndex+1).")
                                            
                                            Text(MBTIQuestion().question[jIndex])
                                            
                                            Spacer()
                                            
                                            Text(self.option[Int(self.mbtiHistory[iIndex][jIndex])])
                                                .bold()
                                                .foregroundStyle(Color(.welcomeTitle))
                                        }
                                    }
                                }
                            }
                            .listRowBackground(Color.clear.overlay(.ultraThinMaterial))
                            .listRowSeparatorTint(Color(.welcomeTitle))
                        }
                        .listStyle(.inset)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                        //進場動畫
                        .transition(.move(edge: .bottom))
                    }
                    else
                    {
                        Image(.nothing)
                            .resizable()
                            .scaledToFit()
                            //進場動畫
                            .transition(.opacity)
                    }
                }
                else
                {
                    //MARK: 所有作答
                    List
                    {
                        ForEach(self.$mbtiAnswer.indices, id: \.self)
                        {index in
                            HStack
                            {
                                Text("\(index+1).")
                                
                                Text(MBTIQuestion().question[index])
                                
                                Spacer()
                                
                                Text(self.option[Int(self.mbtiAnswer[index])])
                                    .bold()
                                    .foregroundStyle(Color(.welcomeTitle))
                            }
                        }
                        .listRowBackground(Color.clear.overlay(.ultraThinMaterial))
                        .listRowSeparatorTint(Color(.welcomeTitle))
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                    //進場動畫
                    .transition(.move(edge: .bottom))
                }
            }
            .navigationTitle(self.showHistory ? "歷史紀錄":"我的作答")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.capsule), for: .navigationBar)
            .toolbar
            {
                //MARK: 歷史紀錄按鈕
                ToolbarItem(placement: .topBarLeading)
                {
                    Button("\(self.showHistory ? "關閉":"查看")歷史紀錄")
                    {
                        withAnimation(.easeInOut)
                        {
                            self.showHistory = !self.showHistory
                        }
                    }
                    .animation(.none, value: self.showHistory)
                }
                
                //MARK: 恢復預設按鈕
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        withAnimation(.easeInOut)
                        {
                            self.index=0
                        }
                        
                        self.mbtiAnswer=Array(repeating: 3, count: 60)
                    }
                    label:
                    {
                        Text("恢復預設")
                            .foregroundStyle(self.showHistory ? .gray:.red)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    .disabled(self.showHistory)
                }
            }
        }
    }
}
