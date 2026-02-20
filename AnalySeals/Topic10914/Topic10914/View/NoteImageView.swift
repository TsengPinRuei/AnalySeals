//
//  NoteImageView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/7.
//

import SwiftUI

//MARK: NoteImage
//LoopScrollView要求要Identifiable的ID 所以自定義結構取代UIImage
fileprivate struct NoteImage: Identifiable
{
    var id: UUID=UUID()
    var image: UIImage
}

struct NoteImageView: View
{
    //sheet的高度
    @Binding var detent: PresentationDetent
    //當前圖片
    @Binding var current: UIImage?
    //顯示完整圖片的狀態
    @Binding var showFullImage: Bool
    
    //讀取圖片的狀態
    @State private var read: Bool=false
    //Storage中該筆記的所有圖片
    @State private var image: [UIImage?]=[]
    
    let id: String
    
    //MARK: 取得動畫所需角度
    private func getAngle(proxy: GeometryProxy) -> Angle
    {
        let progress=proxy.frame(in: .global).minX/proxy.size.width
        let rotation: CGFloat=45
        return Angle(degrees: rotation*progress)
    }
    
    var body: some View
    {
        VStack
        {
            //MARK: 切換箭頭
            //切換Sheet高度
            Image(systemName: self.detent == .height(50) ? "chevron.up":"chevron.down")
                .resizable()
                .foregroundStyle(.black.opacity(0.5))
                .frame(width: 60, height: 20)
                .onTapGesture
                {
                    self.detent=self.detent == .medium ? .height(50):.medium
                }
                .disabled(self.showFullImage)
                .padding(.top, self.detent == .medium ? 20:0)
            
            //高度為螢幕一半才需要顯示
            if(self.detent == .medium)
            {
                ZStack
                {
                    //還沒讀取完畢
                    if(!self.read)
                    {
                        //MARK: 讀取中
                        Rectangle()
                            .fill(.black)
                            //載入動畫
                            .shimmer(ShimmerConfiguration(tint: .clear, highlight: .black.opacity(0.5), blur: 5))
                            .onAppear
                            {
                                self.image=[]
                                //從Firebase取得圖片
                                Storager().downloadImage(noteID: self.id)
                                {data in
                                    //依照名稱排序
                                    let sort: [(UIImage, String)]=data.sorted(by: { $0.1<$1.1 })
                                    
                                    //將圖片放盡image
                                    for i in sort
                                    {
                                        self.image.append(i.0)
                                    }
                                    
                                    //讀取完畢
                                    self.read=true
                                }
                            }
                    }
                    else
                    {
                        if(!self.image.isEmpty)
                        {
                            //MARK: 圖片背景
                            Rectangle()
                                .fill(.ultraThinMaterial.opacity(0.25))
                                .ignoresSafeArea(.all)
                            
                            //MARK: 圖片列表
                            GeometryReader
                            {
                                let size=$0.size
                                
                                //LoopScrollView要求要Identifiable的ID 所以自定義結構取代UIImage
                                var noteImage: [NoteImage] =
                                {
                                    var image: [NoteImage]=[]
                                    
                                    for i in self.image
                                    {
                                        image.append(NoteImage(image: i ?? UIImage()))
                                    }
                                    
                                    return image
                                }()
                                
                                //MARK: LoopScrollView
                                //無限輪迴顯示圖片
                                LoopScrollView(width: size.width, spacing: 0, item: noteImage)
                                {item in
                                    GeometryReader
                                    {reader in
                                        Rectangle()
                                            .fill(.black)
                                            //MARK: 圖片
                                            .overlay
                                            {
                                                //UIImage轉Image
                                                Image(uiImage: item.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    //全螢幕顯示圖片
                                                    .onTapGesture
                                                    {
                                                        self.current=item.image
                                                        //Sheet高度縮小
                                                        self.detent = .height(50)
                                                        //顯示全螢幕
                                                        withAnimation(.easeInOut)
                                                        {
                                                            self.showFullImage.toggle()
                                                        }
                                                    }
                                            }
                                            //3D動畫切換圖片
                                            .rotation3DEffect(
                                                self.getAngle(proxy: reader),
                                                axis: (x: 0, y: 1, z: 0),
                                                anchor: reader.frame(in: .global).minX>0 ? .leading:.trailing,
                                                perspective: 2.5
                                            )
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .scrollTargetBehavior(.paging)
                            }
                        }
                        //MARK: 沒有圖片
                        else
                        {
                            Image(.nothing)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .transition(.opacity.animation(.easeInOut))
            }
        }
    }
}
