//
//  ShimmerEffect.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/12.
//

import SwiftUI

struct ShimmerEffect: ViewModifier
{
    //動畫設定
    @State private var move: CGFloat = -0.5
    
    var configuration: ShimmerConfiguration
    
    func body(content: Content) -> some View
    {
        content
            //隱藏正常部分
            .hidden()
            //新增光學部分
            .overlay
            {
                Rectangle()
                    .fill(self.configuration.tint)
                    .mask
                    {
                        content
                    }
                    .overlay
                    {
                        //光學效果
                        GeometryReader
                        {
                            let size=$0.size
                            //動畫效果在比較小的物體上可能會比較快跑 而無法正常完成 所以增加起始位置
                            let extraSize=size.height/2.5
                            
                            Rectangle()
                                .fill(self.configuration.highlight)
                                .mask
                                {
                                    Rectangle()
                                        .fill(
                                            .linearGradient(
                                                //當它是覆蓋用的View時 顏色不會使用到
                                                colors: [
                                                    .white.opacity(0),
                                                    .white.opacity(0.5),
                                                    self.configuration.highlight.opacity(self.configuration.opacity),
                                                    .white.opacity(0.5),
                                                    .white.opacity(0)
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .frame(width: size.width*2, height: size.height/2)
                                        //模糊效果
                                        .blur(radius: self.configuration.blur)
                                        //旋轉角度
                                        .rotationEffect(Angle(degrees: 120))
                                        //移動到起始位置
                                        .offset(x: self.move>0 ? extraSize:-extraSize)
                                        .offset(x: size.width*self.move)
                                }
                        }
                        //覆蓋內容
                        .mask
                        {
                            content
                        }
                    }
                    //動畫移動效果
                    .onAppear
                    {
                        //在onAppear使用永久性動畫可能會導致動畫故障 放在DispatchQueue可以解決此問題
                        DispatchQueue.main.async
                        {
                            self.move=0.7
                        }
                    }
                    .animation(.linear(duration: self.configuration.speed).repeatForever(autoreverses: false), value: self.move)
            }
    }
}
