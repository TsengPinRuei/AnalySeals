//
//  ScoreHistoryView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/3.
//

import SwiftUI

struct ScoreHistoryView: View
{
    let name: String
    let score: [ChartScore]
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                //MARK: 背景顏色
                Rectangle()
                    .fill(Color(.prefer).gradient)
                    .ignoresSafeArea(.all)
                
                List
                {
                    Section(self.name.replacingOccurrences(of: "\n", with: " "))
                    {
                        //MARK: 分數列表
                        ForEach(self.score.reversed(), id: \.self)
                        {index in
                            HStack
                            {
                                if(index.title=="總級分")
                                {
                                    Text("\(index.title)：\(index.score, specifier: "%.3f")")
                                }
                                else if(index.title.count==2)
                                {
                                    Text("\(index.title)類群：\(index.score, specifier: "%.3f")")
                                }
                                else
                                {
                                    Text("\(index.title.replacingOccurrences(of: "：", with: "類群：").replacingOccurrences(of: " ", with: "\n"))")
                                }
                                
                                Spacer()
                                
                                Text("\(index.year)年")
                            }
                            .bold()
                        }
                        .listRowBackground(Color(.backBar).colorInvert().opacity(0.5))
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.inset)
                //將List預設背景顏色隱藏
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("歷屆分數")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
    }
}
