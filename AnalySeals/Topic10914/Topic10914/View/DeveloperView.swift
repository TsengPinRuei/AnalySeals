//
//  DeveloperView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/8.
//

import SwiftUI

struct DeveloperView: View
{
    //顯示開發者資訊的狀態
    @State private var showDetail: Bool=false
    //人物動畫的狀態
    @State private var showHero: Bool=true
    //動畫所需的Slider
    @State private var progress: CGFloat=0
    //當前選擇的開發者
    @State private var current: Developer?
    
    //開發者列表
    let developer: [Developer]=Topic10914.developer
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color(.background).ignoresSafeArea(.all)
                
                List(self.developer)
                {index in
                    HStack
                    {
                        //MARK: 開發者頭像
                        Image(index.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect)
                            .overlay(Rectangle().stroke(Color(.toolbar)))
                            .opacity(self.current?.id==index.id ? 0:1)
                            .anchorPreference(key: DeveloperAnchorKey.self, value: .bounds)
                            {anchor in
                                return [index.id:anchor]
                            }
                        
                        //MARK: 開發者名字及學號
                        VStack(alignment: .leading)
                        {
                            Text(index.name).font(.headline)
                            
                            Text(index.id)
                                .font(.body)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        //MARK: 開發者工作
                        VStack
                        {
                            ForEach(index.job, id: \.self)
                            {index in
                                Text(index)
                                    .font(.headline)
                                    .foregroundStyle(Color(.toolbar))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color(.backBar))
                    .contentShape(.rect)
                    //MARK: 選擇開發者
                    .onTapGesture
                    {
                        self.current=index
                        self.showDetail=true
                        
                        withAnimation(.snappy(duration: 0.5, extraBounce: 0), completionCriteria: .logicallyComplete)
                        {
                            self.progress=1
                        }
                        completion:
                        {
                            SwiftUI.Task
                            {
                                try? await SwiftUI.Task.sleep(for: .seconds(0.1))
                                self.showHero=false
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("關於我們")
            .toolbarTitleDisplayMode(.inline)
        }
        //MARK: DeveloperDetailView
        .overlay
        {
            if(self.showDetail)
            {
                DeveloperDetailView(
                    showDetail: self.$showDetail,
                    showHero: self.$showHero,
                    progress: self.$progress,
                    developer: self.$current
                )
                .transition(.identity)
            }
        }
        .overlayPreferenceValue(DeveloperAnchorKey.self)
        {value in
            GeometryReader
            {reader in
                if let current=self.current,
                   let source=value[current.id],
                   let destination=value["DESTINATION"]
                {
                    let sourceRectangle=reader[source]
                    let destinationRectangle=reader[destination]
                    
                    let differenceOrigin=CGPoint(
                        x: destinationRectangle.minX-sourceRectangle.minX,
                        y: destinationRectangle.minY-sourceRectangle.minY
                    )
                    let differenceSize: CGSize=CGSize(
                        width: destinationRectangle.width-sourceRectangle.width,
                        height: destinationRectangle.height-sourceRectangle.height
                    )
                    
                    Image(current.image)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: sourceRectangle.width+(differenceSize.width*self.progress),
                            height: sourceRectangle.height+(differenceSize.height*self.progress)
                        )
                        .clipShape(.rect)
                        .offset(
                            x: sourceRectangle.minX+(differenceOrigin.x*self.progress),
                            y: sourceRectangle.minY+(differenceOrigin.y*self.progress)
                        )
                        .opacity(self.showHero ? 1:0)
                }
            }
        }
    }
}
