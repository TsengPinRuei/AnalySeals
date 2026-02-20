//
//  FullImageView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/21.
//

import SwiftUI

struct FullImageView: View
{
    @Binding var detent: PresentationDetent
    //顯示完整圖片的狀態
    @Binding var showFullImage: Bool
    @Binding var image: UIImage?
    
    @State private var scale: CGFloat=0
    
    var body: some View
    {
        ZStack
        {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea(.all)
            
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                //放大或縮小圖片比例
                .scaleEffect(1+self.scale)
                .gesture(
                    MagnificationGesture()
                        //放大縮小
                        .onChanged
                        {value in
                            self.scale=value-1
                        }
                        //放大縮小結束之後
                        .onEnded
                        {value in
                            //回到正常大小
                            withAnimation(.bouncy)
                            {
                                self.scale=0
                            }
                        }
                )
        }
        .opacity(self.showFullImage ? 1:0)
        .onTapGesture
        {
            self.detent = .medium
            withAnimation(.easeInOut)
            {
                self.showFullImage.toggle()
            }
        }
    }
}
