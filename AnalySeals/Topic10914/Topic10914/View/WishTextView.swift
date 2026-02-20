//
//  WishTextView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/5/24.
//

import SwiftUI

struct WishTextView: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    @AppStorage("wish") private var wish: [String]=[]
    
    @Binding var selection: Int
    
    @State private var text: String=""
    
    var body: some View
    {
        NavigationStack
        {
            VStack(spacing: 10)
            {
                Text("我來達成你的願望吧😶‍🌫️\n「霹靂卡霹靂拉拉波波莉娜貝貝魯多」！")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .background(.ultraThickMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                
                //MARK: TextEditor
                TextEditor(text: self.$text)
                    .limitInput(text: self.$text, max: 1000)
                    .scrollContentBackground(.hidden)
                    .background(.ultraThickMaterial)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.backBar), lineWidth: 3))
                    .clipShape(.rect(cornerRadius: 20))
                
                //MARK: 按鈕
                HStack
                {
                    ForEach(0..<2, id: \.self)
                    {index in
                        Button
                        {
                            UIApplication.shared.dismissKeyboard()
                            self.wish.append(self.text)
                            self.text=""
                            
                            if(index==1)
                            {
                                withAnimation(.interactiveSpring(response: 0.5).delay(0.6))
                                {
                                    self.selection=1
                                }
                            }
                        }
                        label:
                        {
                            //願望是否重複 ? "你已經許過這個願望囉":"繼續許願":"許願並抽籤"
                            Text(self.wish.contains(self.text) ? (index==0 ? "你已經許過":"這個願望囉"):(index==0 ? "繼續許願":"許願並抽籤"))
                                .font(.headline)
                                .foregroundStyle(self.text.isEmpty ? .gray:(self.activateDark ? .black:.white))
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(self.text.isEmpty ? Color(.systemGray3):Color(.backBar))
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .disabled(self.text.isEmpty || self.wish.contains(self.text))
                        //動畫式切換按鈕顏色
                        .animation(.easeInOut, value: self.text)
                        .animation(.easeInOut, value: self.wish)
                    }
                }
            }
            .padding()
            .navigationTitle("我要許願")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThickMaterial, for: .navigationBar)
            //MARK: Toolbar
            .toolbar
            {
                ToolbarItem(placement: .keyboard)
                {
                    Button("確認")
                    {
                        UIApplication.shared.dismissKeyboard()
                    }
                    .font(.body)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}
