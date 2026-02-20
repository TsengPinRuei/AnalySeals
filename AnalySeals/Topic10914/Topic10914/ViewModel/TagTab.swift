//
//  TagTab.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/5/3.
//

import SwiftUI

struct TagTab: View
{
    //現在所在標籤
    @Binding var current: String
    
    //matchedGeometryEffect用
    @Namespace private var animation
    
    private let tag: [String]=["顯示全部", "學校資訊", "學業科目", "筆記攻略", "心情閒聊", "音樂", "繁星推薦", "個人申請", "考試分發", "特殊選才", "登記分發", "推薦甄試", "國外留學"]
    
    var body: some View
    {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 10)
            {
                ForEach(self.tag.indices, id: \.self)
                {index in
                    Text(index==0 ? self.tag[index]:"# \(self.tag[index])")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundStyle(self.current==self.tag[index] ? .white:Color(.fieldText))
                        .background
                        {
                            //現在所在標籤
                            if(self.current==self.tag[index])
                            {
                                Capsule()
                                    .fill(Color(red: 50/255, green: 50/255, blue: 50/255))
                                    .frame(height: 40)
                                    .overlay(Capsule().stroke(.primary, lineWidth: 0.5))
                                    .matchedGeometryEffect(id: "ActiveTab", in: self.animation)
                            }
                            //其他標籤
                            else
                            {
                                Capsule()
                                    .fill(Color.white.opacity(0.8))
                                    .frame(height: 40)
                            }
                        }
                        .onTapGesture
                        {
                            //動畫式切換標籤
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7))
                            {
                                self.current=self.tag[index]
                            }
                        }
                }
            }
            //讓標籤列感覺置中以及不要被擠壓到
            .padding([.top, .horizontal], 8)
            .padding(.bottom, 1)
        }
    }
}
