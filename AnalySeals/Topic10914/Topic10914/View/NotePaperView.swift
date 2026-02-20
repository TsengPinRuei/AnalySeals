//
//  NotePaperView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/11.
//

import SwiftUI

struct NotePaperView: View
{
    //不能放AppStorage SideView端會卡死
    
    @Binding var note: Note
    
    //實體手機的解析度
    @Environment(\.displayScale) private var scale
    
    //顯示完整圖片的狀態
    @State private var showFullImage: Bool=false
    //顯示圖片列表的狀態
    @State private var showImage: Bool=true
    //顯示LoadingView的狀態
    @State private var showLoading: Bool=false
    @State private var showMark: Bool=false
    //名字
    @State private var name: String=""
    //當前圖片
    @State private var current: UIImage?
    //sheet的高度
    @State private var detent: PresentationDetent = .height(50)
    //儲存筆記用的圖片
    @State private var renderImage: Image=Image(systemName: "photo")
    @State private var alert: Alerter=Alerter(message: "", show: false)
    
    //MARK: 儲存到相簿
    //將筆記儲存到相簿
    @MainActor
    private func saveNote()
    {
        let count=self.note.text.count
        
        //MARK: 一張
        if(count<=250)
        {
            let render=ImageRenderer(content: NoteToImageView(note: self.note, text: "", textSize: 75, page: "1／1"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        //MARK: 兩張
        else if(count<=500)
        {
            var render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringTo(to: 251), textSize: 75, page: "1／2"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringFrom(from: 251), textSize: 75, page: "2／2"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        //MARK: 三張
        else
        {
            var render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringTo(to: 201), textSize: 85, page: "1／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringWith(with: 201..<401), textSize: 85, page: "2／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringFrom(from: 401), textSize: 85, page: "3／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            if let image=render.uiImage
            {
                //存進相簿
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    //MARK: 分享筆記
    @MainActor
    private func shareNote() -> [UIImage]
    {
        let count=self.note.text.count
        var image: [UIImage]=[]
        
        //MARK: 一張
        if(count<=250)
        {
            let render=ImageRenderer(content: NoteToImageView(note: self.note, text: "", textSize: 75, page: "1／1"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
        }
        //MARK: 兩張
        else if(count<=500)
        {
            var render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringTo(to: 251), textSize: 75, page: "1／2"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringFrom(from: 251), textSize: 75, page: "2／2"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
        }
        //MARK: 三張
        else
        {
            var render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringTo(to: 201), textSize: 85, page: "1／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringWith(with: 201..<401), textSize: 85, page: "2／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
            
            render=ImageRenderer(content: NoteToImageView(note: self.note, text: self.note.text.substringFrom(from: 401), textSize: 85, page: "3／3"))
            //設定圖片解析度 對應實體手機解析度
            render.scale=self.scale
            //將圖片放進圖片陣列
            if let uiImage=render.uiImage
            {
                image.append(uiImage)
            }
        }
        
        return image
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: 背景圖片
            Image(.notePaper)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(spacing: 10)
            {
                //MARK: 標題
                Text(self.note.title)
                    .bold()
                    .font(.title)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //MARK: 內容
                //當文字過多 可以滑動
                ScrollView(.vertical, showsIndicators: false)
                {
                    //讓最後一行文字可以清楚閱讀
                    Text(self.note.text.appending("\n\n\n"))
                        .font(.title3)
                        .foregroundStyle(Color(.fieldText))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            //避免影響到NavigationTitle
            .padding(.top, 10)
            .padding(.horizontal)
            
            //MARK: 陰影
            //Sheet出來時要有黑色陰影
            Color.black
                .opacity(self.detent == .medium ? 0.3:0)
                .ignoresSafeArea(.all)
                .animation(.easeInOut, value: self.detent)
                //讓此區塊不可以互動
                .allowsHitTesting(false)
            
            //MARK: LoadingView
            if(self.showLoading)
            {
                LoadingView(type: "").transition(.opacity)
            }
            
            //MARK: FullImageView
            //避免current還沒讀取到圖片而出錯
            if(self.showFullImage)
            {
                FullImageView(detent: self.$detent, showFullImage: self.$showFullImage, image: self.$current)
                    .onAppear
                    {
                        self.showImage=false
                    }
                    .onDisappear
                    {
                        self.showImage=true
                    }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        //MARK: MarkView
        .overlay(alignment: .bottom)
        {
            //顯示MarkView之後依然靠在螢幕邊邊
            MarkView(note: self.$note, showMark: self.$showMark, showFullImage: self.$showFullImage).padding(.trailing, -5)
        }
        //MARK: NavigationTitle
        .navigationTitle(self.name)
        .toolbarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(self.detent == .medium)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.capsule) ,for: .navigationBar)
        .toolbar
        {
            //MARK: 儲存
            ToolbarItem(placement: .topBarTrailing)
            {
                Button
                {
                    withAnimation(.easeInOut)
                    {
                        self.showLoading=true
                    }
                    self.showImage=false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1)
                    {
                        self.saveNote()
                        DispatchQueue.main.async
                        {
                            withAnimation(.easeInOut)
                            {
                                self.showLoading=false
                            }
                            self.alert.showAlert(message: "筆記儲存成功\n去相簿看看吧🤩")
                        }
                    }
                }
                label:
                {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                }
                //顯示完整圖片時不可啟用
                .disabled(self.showFullImage)
            }
            
            //MARK: NoteShareView
            ToolbarItem(placement: .topBarTrailing)
            {
                NavigationLink(destination: NoteShareView(image: self.shareNote()))
                {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                }
                .disabled(self.showFullImage)
            }
        }
        //MARK: 作者名字
        .onAppear
        {
            Realtimer()
                .getUserData(
                    userID: String(self.note.userId[self.note.userId.startIndex..<self.note.userId.firstIndex(of: " ")!]),
                    column: "Name"
                )
                {data in
                    withAnimation(.easeInOut)
                    {
                        self.name=data ?? ""
                    }
                }
            
            self.showImage=true
        }
        .onDisappear
        {
            self.showImage=false
        }
        .alert(isPresented: self.$alert.show)
        {
            return Alert(title: Text(self.alert.message), dismissButton: .cancel(Text("關閉")) { self.showImage=true })
        }
        //MARK: NoteImageView
        .sheet(isPresented: self.$showImage)
        {
            NoteImageView(
                detent: self.$detent,
                current: self.$current,
                showFullImage: self.$showFullImage,
                id: self.note.userId
            )
            .interactiveDismissDisabled()
            .presentationDetents([.height(50), .medium], selection: self.$detent)
            .presentationBackground(.ultraThickMaterial.opacity(0.25))
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .presentationDragIndicator(.hidden)
        }
    }
}
