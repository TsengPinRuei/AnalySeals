//
//  MBTIView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/25.
//

import SwiftUI

struct MBTIView: View
{
    //當前使用者的MBTI結果
    @AppStorage("currentMBTI") private var currentMBTI: [MBTIJSON]?
    //當前使用者的MBTI結果推薦科系
    @AppStorage("MBTIDepartment") private var mbtiDepartment: [String]=[]
    
    //爬蟲MBTI的資料
    let mbti: MBTIJSON
    
    //MARK: Section內容
    private func SectionText(title: String, text: String) -> some View
    {
        VStack(alignment: .leading)
        {
            Text(title)
                .bold()
                .font(.title2)
            
            Text(text).font(.title3)
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, -20)
        }
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: 背景顏色
            //對應InView及UpView的位置
            BackgroundCapsule(y: -UIScreen.main.bounds.height/2.13)
            
            VStack
            {
                //MARK: 重新作答
                Button
                {
                    self.currentMBTI=nil
                    self.mbtiDepartment=[]
                }
                label:
                {
                    HStack(spacing: 10)
                    {
                        Image(systemName: "person.fill.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .bold()
                        
                        Text("重新測驗").font(.title3)
                    }
                    .foregroundStyle(.blue)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray3))
                }
                //MARK: 分隔線
                .overlay(alignment: .bottom)
                {
                    Rectangle().frame(height: 1)
                }
                
                HStack(spacing: 20)
                {
                    //MARK: MBTI圖片
                    Image(self.mbti.type_code[0...3])
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 3))
                    
                    //MARK: 人格 編號
                    VStack(alignment: .leading)
                    {
                        Text(self.mbti.chinesePersonality()).font(.title)
                        
                        Text(self.mbti.personality_type).font(.title)
                        
                        Text(self.mbti.type_code).font(.title3)
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                List
                {
                    //MARK: 性格類型
                    Section("性格類型")
                    {
                        Text(self.mbti.analysis).font(.title3)
                    }
                    .mbtiSectionStyle()
                    
                    //MARK: 性格分析
                    Section("性格分析")
                    {
                        Text(self.mbti.setAnalysisE()).font(.title3)
                    }
                    .mbtiSectionStyle()
                    
                    //MARK: 性格組成
                    Section("性格組成")
                    {
                        self.SectionText(title: self.mbti.mind_type, text: self.mbti.mind_content)
                        
                        self.SectionText(title: self.mbti.energy_type, text: self.mbti.energy_content)
                        
                        self.SectionText(title: self.mbti.nature_type, text: self.mbti.nature_content)
                        
                        self.SectionText(title: self.mbti.tactics_type, text: self.mbti.tactics_content)
                        
                        self.SectionText(title: self.mbti.identity_type, text: self.mbti.identity_content)
                    }
                    .mbtiSectionStyle()
                    
                    //MARK: 職業推薦
                    Section("職業推薦")
                    {
                        Text(self.mbti.setCareer()).font(.title3)
                    }
                    .mbtiSectionStyle()
                    
                    //MARK: 科系推薦
                    Section("科系推薦")
                    {
                        let career: [String]=self.mbti.setCareer().components(separatedBy: "\n")
                        
                        VStack(alignment: .leading, spacing: 0)
                        {
                            ForEach(career, id: \.self)
                            {index in
                                var department: String
                                {
                                    let get: String=self.mbti.getDepartment(career: index)
                                    
                                    for i in get.components(separatedBy: "\n")
                                    {
                                        if(!self.mbtiDepartment.contains(i))
                                        {
                                            self.mbtiDepartment.append(i)
                                        }
                                    }
                                    
                                    return get
                                }
                                
                                self.SectionText(title: index, text: department)
                            }
                        }
                    }
                    .mbtiSectionStyle()
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .listStyle(.inset)
            }
            .background(Color(.rectangle).opacity(0.8))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.backBar), lineWidth: 3))
            .clipShape(.rect(cornerRadius: 20))
            .padding()
        }
    }
}
