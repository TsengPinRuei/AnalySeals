//
//  NoteShareView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/10/15.
//

import SwiftUI

struct NoteShareView: View
{
    //關閉當前畫面的狀態
    @Environment(\.dismiss) private var dismiss
    
    //顯示BackButton
    @State private var showBackButton: Bool=false
    //顯示BottomBar
    @State private var showShare: Bool=false
    @State private var current: UIImage=UIImage(named: "NotePaper")!
    
    //筆記圖片
    let image: [UIImage]
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Color(.background).ignoresSafeArea(.all)
            
            //MARK: 筆記頁面
            TabView
            {
                ForEach(self.image, id: \.self)
                {index in
                    Image(uiImage: index)
                        .resizable()
                        .scaledToFit()
                        //筆記背景陰影
                        .background(Rectangle().fill(Color(.backBar).shadow(.drop(radius: 5))))
                        //對應陰影
                        .padding(.horizontal, 5)
                        .onAppear
                        {
                            self.current=index
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("筆記分享預覽")
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.capsule), for: .navigationBar)
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
                        
                        Text("完整筆記")
                    }
                }
                .opacity(self.showBackButton ? 1:0)
            }
            
            //MARK: 說明
            ToolbarItem(placement: .topBarTrailing)
            {
                Menu("說明")
                {
                    Button("內容過多時會分成多頁，\n一次只能分享一頁內容。") {}
                    
                    Button("左右滑動可以查看其他頁面內容。") {}
                }
            }
            
            //MARK: 分享
            ToolbarItem(placement: .bottomBar)
            {
                ShareLink(
                    item: Image(uiImage: self.current),
                    preview: SharePreview("難怪多吃魚會變聰明...", image: Image("AppIcon"))
                )
                {
                    HStack(spacing: 20)
                    {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                        
                        Text("當下頁面")
                    }
                    .bold()
                    .font(.title)
                    .foregroundStyle(Color(.toolbar))
                }
                .opacity(self.showShare ? 1:0)
            }
        }
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
            {
                withAnimation(.easeInOut)
                {
                    self.showBackButton=true
                }
            }
            
            //等Sheet消失再顯示
            DispatchQueue.main.asyncAfter(deadline: .now()+0.8)
            {
                withAnimation(.easeInOut)
                {
                    self.showShare=true
                }
            }
        }
    }
}
