//
//  SchoolScoreView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/11.
//

import SwiftUI

struct SchoolScoreView: View
{
    //偏好學校
    @AppStorage("preferSchool") private var preferSchool: [String]=[]
    
    //二階段甄試日期
    @State private var date: String=""
    //甄試入學 -> 去年最低錄取級分
    //登記分發 -> 去年最低錄取分數
    @State private var least: String=""
    //招生名額
    @State private var number: String=""
    //去年我的級分
    @State private var myScore: [String]=Array(repeating: "", count: 6)
    //甄試入學 -> 級分倍率：國文 英文 數學 專業科目一 專業科目二 總級分
    //登記分發 -> 分數權重：國文 英文 數學 專業科目一 專業科目二
    @State private var weight: [String]=Array(repeating: "", count: 6)
    
    let port: Int
    let name: String
    //學校資訊
    let detail: String
    //國文 英文 數學 專業科目一 專業科目二
    let score: [String]
    
    //MARK: 顯示的標題內容
    private func SectionContent(title: String, text: String) -> some View
    {
        Section(title)
        {
            Text(text)
        }
        .headerProminence(.increased)
    }
    //MARK: 顯示的標題內容
    private func SectionContent(title: String, text: [String], range: (Int, Int)=(0, 0)) -> some View
    {
        Section(title)
        {
            ForEach(range.0..<(range.1==0 ? text.count:range.1), id: \.self)
            {index in
                Text(text[index])
            }
        }
        .headerProminence(.increased)
    }
    //MARK: 甄試入學分數格式化
    //都用firstIndex 因為用其他方式大機率會出錯
    private func formatScore5000()
    {
        //國文
        self.weight[0]=String(self.detail[self.detail.firstIndex(of: "國")!..<self.detail.firstIndex(of: "英")!])[0...6]
        //英文
        self.weight[1]=String(self.detail[self.detail.firstIndex(of: "英")!..<self.detail.firstIndex(of: "數")!])[0...6]
        //數學
        self.weight[2]=String(self.detail[self.detail.firstIndex(of: "數")!..<self.detail.firstIndex(of: "一")!])[0...6]
        //專業科目一
        self.weight[3]="專業科目".appending(String(self.detail[self.detail.firstIndex(of: "一")!..<self.detail.firstIndex(of: "二")!])[0...5])
        //專業科目二
        self.weight[4]="專業科目".appending(String(self.detail[self.detail.firstIndex(of: "二")!..<self.detail.firstIndex(of: "總")!])[0...5])
        //總級分
        self.weight[5]=String(self.detail[self.detail.firstIndex(of: "總")!..<self.detail.firstIndex(of: "去")!])[0...7]
        for i in 0..<self.weight.count
        {
            self.weight[i]=self.weight[i].replacingOccurrences(of: "(", with: "：")
        }
        
        //去年最低級分
        self.least=String(self.detail[self.detail.firstIndex(of: "低")!..<self.detail.firstIndex(of: "估")!])
        self.least=self.least[4...self.least.count-3]
            .replacingOccurrences(of: ",(", with: "\n")
            .replacingOccurrences(of: "()", with: "：")
            .replacingOccurrences(of: "(", with: "：")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: ",", with: "\n")
        if(self.least.starts(with: "："))
        {
            self.least=self.least[1..<self.least.count]
        }
        
        let last: String=String(self.detail[self.detail.firstIndex(of: "估")!...self.detail.lastIndex(of: "二")!])
        //國文
        self.myScore[0]=String(last[last.firstIndex(of: "國")!..<last.firstIndex(of: "英")!])[0...4]
        //英文
        self.myScore[1]=String(last[last.firstIndex(of: "英")!..<last.firstIndex(of: "數")!])[0...4]
        //數學
        self.myScore[2]=String(last[last.firstIndex(of: "數")!..<last.firstIndex(of: "一")!])[0...4]
        //專業科目一
        self.myScore[3]="專業科目".appending(String(last[last.firstIndex(of: "一")!..<last.firstIndex(of: "二")!])[0...3])
        //專業科目二
        self.myScore[4]="專業科目".appending(String(last[last.firstIndex(of: "二")!..<last.firstIndex(of: "總")!])[0...3])
        //總級分
        self.myScore[5]=String(last[last.firstIndex(of: "總")!..<last.lastIndex(of: ")")!])
        for i in 0..<self.myScore.count
        {
            self.myScore[i]=self.myScore[i].replacingOccurrences(of: "(", with: "：").replacingOccurrences(of: ")", with: "")
        }
        
        //二階段甄試日期
        self.date=String(self.detail[self.detail.index(after: self.detail.lastIndex(of: "：")!)..<self.detail.endIndex])
    }
    //MARK: 登記分發分數格式化
    //都用firstIndex 因為用其他方式大機率會出錯
    private func formatScore8000()
    {
        //國文
        self.weight[0]=String(self.detail[self.detail.firstIndex(of: "國")!..<self.detail.firstIndex(of: "英")!])[0...6]
        //英文
        self.weight[1]=String(self.detail[self.detail.firstIndex(of: "英")!..<self.detail.firstIndex(of: "數")!])[0...6]
        //數學
        self.weight[2]=String(self.detail[self.detail.firstIndex(of: "數")!..<self.detail.firstIndex(of: "專")!])[0...6]
        //專業科目一
        self.weight[3]="專業科目".appending(String(self.detail[self.detail.firstIndex(of: "一")!..<self.detail.firstIndex(of: "二")!])[0...5])
        //專業科目二
        self.weight[4]="專業科目".appending(String(self.detail[self.detail.firstIndex(of: "二")!..<self.detail.firstIndex(of: "招")!])[0...5])
        for i in 0..<self.weight.count-1
        {
            self.weight[i]=self.weight[i].replacingOccurrences(of: "(", with: "：")
        }
        
        //去年最低分數
        self.number=String(self.detail[self.detail.firstIndex(of: "今")!..<self.detail.lastIndex(of: "去")!])
        self.number=self.number[0...self.number.count-2]
            .replacingOccurrences(of: "(", with: "：")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "、", with: "\n")
        
        //去年最低分數
        self.least=String(self.detail[self.detail.index(after: self.detail.lastIndex(of: "：")!)..<self.detail.endIndex])
    }
    //MARK: 取得總分
    private func getSum() -> Int
    {
        var sum: Int=0
        
        for i in self.score
        {
            sum+=Int(i)!
        }
        
        return sum
    }
    //MARK: 取得加權總分數
    private func getWeightSum() -> Double
    {
        var sum: Double=0
        var weightNumber: String
        
        for i in 0..<self.score.count
        {
            //在資料載入完成之前都會是空值 所以要先放條件式避免出錯
            if(!self.weight[i].isEmpty)
            {
                weightNumber=self.weight[i][self.weight[i].count-4...self.weight[i].count-1]
                sum+=Double(self.score[i])!*Double(weightNumber)!
            }
        }
        
        return round(sum*100)/100.0
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.background).ignoresSafeArea()
            
            VStack(spacing: 1)
            {
                //MARK: 學校名稱
                Text(self.name)
                    .bold()
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.backBar)))
                    .padding([.horizontal, .top])
                
                List
                {
                    //MARK: 加入偏好按鈕
                    Button
                    {
                        if(!self.preferSchool.contains(self.name))
                        {
                            self.preferSchool.append(self.name)
                        }
                    }
                    label:
                    {
                        Text("加入偏好")
                            .bold()
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity)
                    }
                    
                    //MARK: 甄試入學
                    if(self.port==5000)
                    {
                        self.SectionContent(title: "級分倍率", text: self.weight)
                        
                        self.SectionContent(title: "去年我的級分", text: self.myScore)
                        
                        self.SectionContent(title: "去年最低錄取級分", text: self.least)
                        
                        self.SectionContent(title: "第二階段甄試日期", text: self.date)
                    }
                    //MARK: 登記分發
                    else
                    {
                        self.SectionContent(title: "校系權重", text: self.weight, range: (0, self.weight.count-1))
                        
                        self.SectionContent(title: "我的原始分數", text: "\(self.getSum())")
                        
                        self.SectionContent(title: "我的加權分數", text: "\(self.getWeightSum())")
                        
                        self.SectionContent(title: "去年最低錄取分數", text: self.least)
                        
                        self.SectionContent(title: "招生名額", text: self.number)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                //MARK: 網路口
                .onAppear
                {
                    //甄試入學
                    if(self.port==5000)
                    {
                        self.formatScore5000()
                    }
                    //登記分發
                    else
                    {
                        self.formatScore8000()
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
