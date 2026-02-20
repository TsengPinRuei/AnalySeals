//
//  TechnologyRankView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/19.
//

import SwiftUI

struct TechnologyRankView: View
{
    @Binding var rank: String
    
    //取得世界大學排名
    private let worldRank: WorldRank=WorldRank()
    
    //MARK: 獎牌
    private func setMedal(rank: Int) -> ImageResource
    {
        switch(rank)
        {
            case 0:
                return .gold
            case 1:
                return .silver
            case 2:
                return .bronze
            default:
                return .gold
        }
    }
    //MARK: 排名
    private func setRank() -> String
    {
        switch(self.rank)
        {
            case "Academic":
                return "Academic Ranking of"
            case "QS":
                return "Quacquarelli Symonds"
            case "THE":
                return "Times Higher Education"
            case "USNews":
                return "U.S. News & World Report"
            case "Center":
                return "Center for"
            default:
                return ""
        }
    }
    //MARK: 學校
    private func setSchool() -> [(String, String)]
    {
        switch(self.rank)
        {
            case "Academic":
                return self.worldRank.AcademicTechnology
            case "QS":
                return self.worldRank.QSTechnology
            case "THE":
                return self.worldRank.THETechnology
            case "USNews":
                return self.worldRank.USTechnology
            case "Center":
                return self.worldRank.CenterTechnology
            default:
                return []
        }
    }
    
    var body: some View
    {
        ZStack
        {
            //解決背景影響到BottomBar背景顏色的問題
            Color(red: 200/255, green: 200/255, blue: 200/255).ignoresSafeArea(.all)
            
            VStack
            {
                //MARK: 學校列表
                List
                {
                    ForEach(self.setSchool().indices, id: \.self)
                    {index in
                        HStack(spacing: 10)
                        {
                            Image(self.setMedal(rank: index))
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                //再放大圖片
                                .scaleEffect(1.2)
                                .shadow(color: .black, radius: 2)
                                //前三名才有獎牌
                                .opacity(index<3 ? 1:0)
                            
                            Text(self.setSchool()[index].1)
                            
                            Spacer()
                            
                            Text(self.setSchool()[index].0)
                                .fontWeight(.semibold)
                                .padding(8)
                                .background(.white.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray))
                        }
                    }
                    .listRowBackground(Color(red: 205/225, green: 227/255, blue: 229/255))
                    .listRowSeparatorTint(.black)
                }
                .listStyle(.plain)
                .foregroundStyle(.black)
                
                //MARK: 世界排名名稱
                VStack
                {
                    Text(self.setRank())
                    
                    Text(self.rank=="Academic" ? "World Universities":"World University Rankings")
                }
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .animation(.easeInOut, value: self.rank)
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(.all)
    }
}
