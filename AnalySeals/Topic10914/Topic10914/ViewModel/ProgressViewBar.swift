//
//  ProgressViewBar.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/10.
//

import SwiftUI

struct ProgressViewBar: ProgressViewStyle
{
    //進度
    @State private var progress: Double=0
    @State private var timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let color: Color=Color(.backBar)
    let distance: Double
    let height: Double=40
    let font: Font = .title3
    
    private func setHead() -> ImageResource
    {
        if(self.progress<=25)
        {
            return ._0To25
        }
        else if(self.progress<=50)
        {
            return ._26To50
        }
        else if(self.progress<=75)
        {
            return ._51To75
        }
        else
        {
            return ._76To100
        }
    }
    
    func makeBody(configuration: Configuration) -> some View
    {
        let progress=configuration.fractionCompleted ?? 0
        
        GeometryReader
        {reader in
            VStack(alignment: .leading, spacing: 30)
            {
                //顯示字串
                configuration.label
                    .font(self.font)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                //進度條
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .frame(width: reader.size.width, height: self.height)
                    .overlay(alignment: .leading)
                    {
                        //進度
                        RoundedRectangle(cornerRadius: 10)
                            .fill(self.color)
                            .frame(width: reader.size.width*progress)
                            .overlay(alignment: .trailing)
                            {
                                Image(self.setHead())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .padding(.trailing, -10)
                            }
                    }
                
                HStack(spacing: 20)
                {
                    //進度數字
                    if let current=configuration.currentValueLabel
                    {
                        current.foregroundStyle(Color(.backBar))
                    }
                    
                    ProgressView().tint(self.color)
                }
                .font(self.font)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onReceive(self.timer)
            {_ in
                if(self.progress<100)
                {
                    if(self.progress+self.distance<=100)
                    {
                        self.progress+=self.distance
                    }
                    else
                    {
                        self.progress=100
                    }
                }
                else
                {
                    self.timer.upstream.connect().cancel()
                }
            }
        }
    }
}
