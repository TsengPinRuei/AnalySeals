//
//  MyPrayView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/5/24.
//

import SwiftUI

struct MyPrayView: View
{
    @Binding var array: [String]
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showText: Bool=false
    //LazyVGrid顯示方式
    @State private var count: Int=3
    @State private var current: Int?
    @State private var text: String=""
    @State private var getItem: String?
    
    let title: String
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                if(self.array.isEmpty)
                {
                    Image(.nothing)
                        .resizable()
                        .scaledToFit()
                }
                else
                {
                    ScrollView(.vertical)
                    {
                        let column: [GridItem]=Array(repeating: GridItem(spacing: 10), count: self.count)
                        
                        LazyVGrid(columns: column, spacing: 10)
                        {
                            ForEach(self.array, id: \.self)
                            {index in
                                GeometryReader
                                {
                                    let size=$0.size
                                    
                                    //MARK: RoundedRectangle
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill((self.title=="我的願望" ? .white:Color(red: 245/255, green: 230/255, blue: 220/255)).gradient)
                                        //背景陰影
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.backBar).shadow(.drop(radius: 5))))
                                        .overlay
                                        {
                                            //點選當前RoundedRectangle
                                            if(self.text==index)
                                            {
                                                RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1)
                                            }
                                        }
                                        .overlay(alignment: .center)
                                        {
                                            Text(index)
                                                .foregroundStyle(self.title=="我的願望" ? Color(.fieldText):.black)
                                                .padding()
                                        }
                                        //MARK: 點選當前RoundedRectangle
                                        .onTapGesture
                                        {
                                            //紀錄或取消點選的內容
                                            self.text=self.text==index ? "":index
                                            //紀錄或取消點選的索引值
                                            self.current=self.current==self.array.firstIndex(of: index) ? nil:self.array.firstIndex(of: index)
                                        }
                                        //MARK: 拖曳
                                        .draggable(index)
                                        {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill((self.title=="我的願望" ? .white:Color(red: 245/255, green: 230/255, blue: 220/255)).gradient)
                                                .frame(width: size.width, height: size.height)
                                                .onAppear
                                                {
                                                    self.getItem=index
                                                }
                                        }
                                        //MARK: 拖曳到指定索引值
                                        .dropDestination(for: String.self)
                                        {(item, location) in
                                            self.getItem=nil
                                            return false
                                        }
                                        isTargeted:
                                        {status in
                                            if let getItem, status, getItem != index
                                            {
                                                //拖曳完之後的索引值更新進array
                                                if let start=self.array.firstIndex(of: getItem),
                                                   let end=self.array.firstIndex(of: index)
                                                {
                                                    //改成.bouncy
                                                    withAnimation(.easeInOut)
                                                    {
                                                        let remove=self.array.remove(at: start)
                                                        self.array.insert(remove, at: end)
                                                    }
                                                }
                                            }
                                        }
                                }
                                .frame(height: 100)
                            }
                        }
                        .padding(10)
                        //動畫式切換顯示方式
                        .animation(.easeInOut, value: self.count)
                    }
                }
                
                //MARK: 顯示字串
                if(self.showText)
                {
                    ZStack
                    {
                        Color.black.opacity(0.5)
                        
                        Text(self.text)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .onTapGesture
                    {
                        withAnimation(.easeInOut)
                        {
                            self.showText.toggle()
                        }
                    }
                    .transition(.opacity.animation(.easeInOut))
                    .ignoresSafeArea(.all)
                }
            }
            .navigationTitle(self.title)
            .toolbarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.background), for: .navigationBar)
            //MARK: Toolbar
            .toolbar
            {
                //MARK: 切換顯示方式
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        //這裡不用動畫 是因為不要讓圖片動畫式切換
                        self.count=self.count==3 ? 2:3
                    }
                    label:
                    {
                        Image(systemName: self.count==3 ? "square.grid.3x2":"square.grid.2x2").foregroundStyle(.blue)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing)
                {
                    Menu
                    {
                        //MARK: 查看完整內容
                        Button("查看")
                        {
                            withAnimation(.easeInOut)
                            {
                                self.showText.toggle()
                            }
                        }
                        .disabled(self.text.isEmpty)
                        
                        //MARK: 刪除指定索引值的內容
                        Button("刪除", role: .destructive)
                        {
                            if let current=self.current
                            {
                                self.text=""
                                //相當於清空array
                                if(self.array.count==1)
                                {
                                    self.dismiss()
                                    
                                    //等sheet收回之後再刪除
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
                                    {
                                        self.array.remove(at: current)
                                    }
                                }
                                else
                                {
                                    self.array.remove(at: current)
                                }
                            }
                        }
                        .disabled(self.text.isEmpty)
                        
                        //MARK: 清空array所有內容
                        Button("清空", role: .destructive)
                        {
                            self.dismiss()
                            
                            //等sheet收回之後再刪除
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
                            {
                                self.array.removeAll()
                            }
                        }
                    }
                    label:
                    {
                        HStack(spacing: 5)
                        {
                            Text("操作")
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 12, height: 8)
                        }
                        .foregroundStyle((self.array.isEmpty || self.showText) ? .gray:.blue)
                    }
                    .disabled(self.array.isEmpty || self.showText)
                    //動畫式淡入淡出
                    .animation(.easeInOut, value: self.array)
                }
            }
        }
    }
}
