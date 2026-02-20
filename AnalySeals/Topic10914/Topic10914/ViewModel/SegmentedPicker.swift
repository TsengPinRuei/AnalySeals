//
//  SegmentedPicker.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/24.
//

import SwiftUI

struct SegmentedPicker: View
{
    @Binding var selection: Int
    
    //matchedGeometryEffect用
    @Namespace private var animation
    
    var option: [String]
    
    let unselectColor: Color
    let selectColor: Color
    
    var body: some View
    {
        HStack
        {
            ForEach(self.option.indices, id: \.self)
            {index in
                ZStack
                {
                    if(index==self.selection)
                    {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(self.selectColor)
                            .matchedGeometryEffect(id: "ActiveOption", in: self.animation)
                            .onTapGesture
                            {
                                withAnimation(.interactiveSpring())
                                {
                                    self.selection=index
                                }
                            }
                    }
                    else
                    {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(self.unselectColor.opacity(0.001))
                            .padding(5)
                            .onTapGesture
                            {
                                withAnimation(.interactiveSpring(response: 0.5))
                                {
                                    self.selection=index
                                }
                            }
                    }
                }
                .overlay
                {
                    Text(self.option[index])
                        .bold()
                        .font(self.selection==index ? .title2:.headline)
                        .foregroundColor(self.selection==index ? .none:.gray)
                }
            }
        }
        .frame(height: 50)
        .clipShape(.rect(cornerRadius: 30))
    }
}
