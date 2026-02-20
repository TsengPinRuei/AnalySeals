//
//  PostImageView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/10.
//

import SwiftUI

struct PostImageView: View
{
    //筆記圖片
    @Binding var image: [UIImage?]
    //圖片選擇功能用
    @Binding var showOption: [Bool]
    //圖片來源
    @Binding var source: [PhotoSource?]
    
    var body: some View
    {
        List
        {
            ForEach(self.image.indices, id: \.self)
            {index in
                //MARK: 圖片編號
                Section("\(index+1)")
                {
                    Button
                    {
                        self.showOption[index].toggle()
                    }
                    label:
                    {
                        //MARK: 選取圖片
                        if let image=self.image[index]
                        {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        //MARK: 未選取圖片
                        else
                        {
                            Image(.photo)
                                .resizable()
                                .scaledToFill()
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                    //MARK: 圖片來源
                    .confirmationDialog("", isPresented: self.$showOption[index])
                    {
                        Button("相機")
                        {
                            self.source[index] = .camera
                        }
                        
                        Button("相簿")
                        {
                            self.source[index] = .photoLibrary
                        }
                        
                        if let _=self.image[index]
                        {
                            //MARK: 刪除圖片按鈕
                            Button("刪除", role: .destructive)
                            {
                                withAnimation(.easeInOut)
                                {
                                    //最多只能儲存十張 只要不是第十張都直接刪除
                                    if(index<9)
                                    {
                                        self.showOption.remove(at: index)
                                        self.source.remove(at: index)
                                        self.image.remove(at: index)
                                    }
                                    //第十張不刪除而是還原
                                    else
                                    {
                                        self.showOption[index]=false
                                        self.source[index]=nil
                                        self.image[index]=nil
                                    }
                                }
                            }
                        }
                    }
                    //MARK: 開啟相機或相簿
                    .fullScreenCover(item: $source[index])
                    {source in
                        switch(source)
                        {
                            case .photoLibrary:
                                ImagePicker(selectedImage: self.$image[index], sourceType: .photoLibrary).ignoresSafeArea()
                            case .camera:
                                ImagePicker(selectedImage: self.$image[index], sourceType: .camera).ignoresSafeArea()
                        }
                    }
                }
                .headerProminence(.increased)
                //設定Section字體樣式
                .bold()
                .font(.largeTitle)
                .foregroundStyle(Color(.toolbar))
            }
            .listRowBackground(Color.clear)
            //圖片佔滿ListRow
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.sidebar)
        //隱藏預設List背景
        .scrollContentBackground(.hidden)
        .background(Color(.background).gradient)
        .onChange(of: self.image)
        {(_, new) in
            //圖片列表是空的 || 圖片列表<10張 && 頭尾都不是空值(空值可以直接增加圖片 就不需要再新增空值)
            if(new.isEmpty || (new.count<10 && new[0] != nil && new[new.count-1] != nil))
            {
                withAnimation(.easeInOut)
                {
                    self.showOption.append(false)
                    self.source.append(nil)
                    self.image.append(nil)
                }
            }
        }
    }
}
