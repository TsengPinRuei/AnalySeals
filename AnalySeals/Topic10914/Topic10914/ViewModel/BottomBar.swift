//
//  BottomBar.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/24.
//

import SwiftUI

struct BottomBar: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    
    @Binding var selection: Int
    
    //matchedGeometryEffect用
    @Namespace private var animate
    
    let image: [String]=["note.text", "chart.xyaxis.line", "plus", "flowchart.fill", "doc.text.magnifyingglass"]
    let text: [String]=["筆記交流", "圖表偏好", "分享筆記", "落點分析", "人格測驗"]
    
    var body: some View
    {
        HStack
        {
            ForEach(self.image.indices, id: \.self)
            {index in
                Button
                {
                    withAnimation(.bouncy)
                    {
                        self.selection=index
                    }
                }
                label:
                {
                    VStack(spacing: 5)
                    {
                        //Spacer()
                        
                        if(index==self.selection)
                        {
                            Rectangle()
                                .frame(height: 5)
                                .foregroundStyle(.white)
                                .matchedGeometryEffect(id: "Selection", in: self.animate)
                        }
                        else
                        {
                            Rectangle()
                                .frame(height: 5)
                                .foregroundStyle(.clear)
                        }
                        
                        Image(systemName: self.image[index])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .symbolEffect(.bounce, value: self.selection==index)
                        
                        Text(self.text[index]).font(.caption)
                    }
                }
                .foregroundStyle(index==self.selection ? .white:(self.activateDark ? .gray:.black))
            }
        }
        //對應原本TabView高度
        .frame(height: 45)
        //.background(.black.opacity(0.2))
    }
}
