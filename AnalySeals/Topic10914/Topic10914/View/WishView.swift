//
//  WishView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/5/23.
//

import SwiftUI

struct WishView: View
{
    @Binding var selection: Int
    
    //許願畫面的狀態
    @State private var showWishText: Bool=false
    @State private var tap: Bool=false
    @State private var opacity: CGFloat=0
    @State private var x: CGFloat=0
    @State private var y: CGFloat=0
    
    var body: some View
    {
        ZStack
        {
            //MARK: 湖面
            Image(.godSeal)
                .resizable()
                .scaledToFit()
                .overlay(Rectangle().fill(.ultraThinMaterial).opacity(self.opacity))
                //金幣落下動畫
                .onTapGesture
                {location in
                    withAnimation(.easeInOut.speed(2))
                    {
                        self.opacity=0.8
                    }
                    
                    //對準點擊座標位置
                    self.x=location.x-200
                    self.y=location.y-275
                    
                    withAnimation(.easeInOut)
                    {
                        self.tap=true
                        self.y-=100
                    }
                    withAnimation(.easeInOut.delay(0.25))
                    {
                        self.y+=100
                    }
                    withAnimation(.easeInOut.delay(0.5))
                    {
                        self.tap=false
                    }
                    
                    //切換到抽籤頁面
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6)
                    {
                        withAnimation(.easeInOut.speed(2))
                        {
                            self.opacity=0
                        }
                        self.showWishText.toggle()
                    }
                }
            
            //MARK: 金幣
            Image(.coin)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .offset(x: self.x, y: self.y)
                .opacity(self.tap ? 1:0)
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)
        //MARK: WishTextView
        .sheet(isPresented: self.$showWishText)
        {
            WishTextView(selection: self.$selection)
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
                .presentationDetents([.large])
                .presentationBackground(.ultraThinMaterial)
        }
    }
}
