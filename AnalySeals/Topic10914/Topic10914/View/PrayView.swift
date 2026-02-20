//
//  PrayView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/24.
//

import SwiftUI

struct PrayView: View
{
    @AppStorage("lottery") private var lottery: [String]=[]
    @AppStorage("wish") private var wish: [String]=[]
    
    @Environment(\.dismiss) private var dismiss
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    @State private var showLottery: Bool=false
    @State private var showWish: Bool=false
    @State private var selection: Int=0
    
    let option: [String]=["文昌豹君", "抽籤"]
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Color(.capsule).ignoresSafeArea(.all)
            
            VStack(spacing: 0)
            {
                //MARK: 選擇器
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.toolbar))
                    .foregroundStyle(Color(.sideText))
                    //因為SegmentedPicker的height是50
                    .frame(height: 70)
                    .overlay
                    {
                        SegmentedPicker(
                            selection: self.$selection,
                            option: self.option,
                            unselectColor: Color(.systemGray6),
                            selectColor: Color(.side)
                        )
                        .padding(.horizontal, 10)
                    }
                    .padding(.horizontal)
                
                if(self.selection==0)
                {
                    WishView(selection: self.$selection).padding(.top)
                }
                else
                {
                    LotteryView(selection: self.$selection).padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .ignoresSafeArea(edges: .bottom)
        .modifyNavigationBarStyle(title: "心誠則靈", display: .inline)
        .toolbar
        {
            //MARK: 返回主頁
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
            
            //MARK: 查看物件
            ToolbarItem(placement: .topBarTrailing)
            {
                HStack
                {
                    Button("願望")
                    {
                        self.showWish.toggle()
                    }
                    
                    Divider()
                    
                    Button("籤")
                    {
                        self.showLottery.toggle()
                    }
                }
                .foregroundStyle(Color(.toolbar))
            }
        }
        //MARK: 籤表
        .sheet(isPresented: self.$showLottery)
        {
            MyPrayView(array: self.$lottery, title: "我的籤")
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
                .presentationDetents(self.lottery.isEmpty ? [.medium]:[.large])
                .presentationBackground(Color(.capsule))
        }
        //MARK: 願望表
        .sheet(isPresented: self.$showWish)
        {
            MyPrayView(array: self.$wish, title: "我的願望")
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
                .presentationDetents(self.wish.isEmpty ? [.medium]:[.large])
                .presentationBackground(Color(.capsule))
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
