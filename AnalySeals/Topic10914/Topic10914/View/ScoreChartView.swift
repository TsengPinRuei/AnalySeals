//
//  ScoreChartView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/13.
//

import SwiftUI
import SwiftUICharts

struct ScoreChartView: View
{
    @State private var showHistory5000: Bool=false
    @State private var showHistory8000: Bool=false
    
    let name: String
    let score5000: [ChartScore]?
    let score8000: [ChartScore]?
    
    private let chartStyle: ChartStyle =
    ChartStyle(
        backgroundColor: Color(.rectangle),
        accentColor: .clear,
        secondGradientColor: .clear,
        textColor: .black,
        legendTextColor: .black,
        dropShadowColor: .gray
    )
    
    private func getScore(chart: [ChartScore], port: Int) -> [Double]
    {
        var number: [Double]=[]
        
        number.append(0)
        //放進歷年分數
        for i in chart
        {
            number.append(i.score)
        }
        
        //還沒有分數資料 就亂數填分數
        if(number.count==1)
        {
            for _ in 107...112
            {
                //根據登記分發或是甄試入學 填入對應分數或級分
                number.append(Double.random(in: port==5000 ? 10...70:100...1000))
            }
        }
        
        return number
    }
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            //MARK: 學校名稱
            VStack(spacing: 5)
            {
                //將學校名稱固定在最上面
                Text(self.name.replacingOccurrences(of: "\n", with: " "))
                    .bold()
                    .font(.title3)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.prefer))
                
                Rectangle()
                    .fill(Color(.backBar))
                    .frame(height: 1)
            }
            
            ScrollView(.vertical, showsIndicators: false)
            {
                VStack(alignment: .center)
                {
                    //MARK: 登記分發落點圖表
                    if let score8000=self.score8000
                    {
                        let score=self.getScore(chart: score8000, port: 8000)
                        
                        if(!score.isEmpty)
                        {
                            LineChartView(
                                data: score,
                                title: "登記分發",
                                legend: "107年～112年之最高加權分",
                                style: self.chartStyle,
                                form: ChartForm.extraLarge,
                                rateValue: Int((score[score.count-1]-score[1])/score[1]*100)
                            )
                            .foregroundStyle(.red)
                            .padding(10)
                            .onTapGesture
                            {
                                self.showHistory8000.toggle()
                            }
                            .animation(.smooth, value: score)
                        }
                    }
                    else
                    {
                        LineChartView(
                            data: [],
                            title: "登記分發 暫無資料",
                            style: self.chartStyle,
                            form: ChartForm.extraLarge,
                            rateValue: nil
                        )
                        .padding(10)
                        //沒有資料 不開放點選以避免發生錯誤
                        .disabled(true)
                    }
                    
                    Divider()
                    
                    //MARK: 甄試入學落點圖表
                    if let score5000=self.score5000
                    {
                        let score=self.getScore(chart: score5000, port: 5000)
                        
                        if(!score.isEmpty)
                        {
                            LineChartView(
                                data: score,
                                title: "甄試入學",
                                legend: "107年～112年之最高級分",
                                style: self.chartStyle,
                                form: ChartForm.extraLarge,
                                rateValue: Int((score[score.count-1]-score[1])/score[1]*100)
                            )
                            .foregroundStyle(.red)
                            .padding(10)
                            .onTapGesture
                            {
                                self.showHistory5000.toggle()
                            }
                            .animation(.smooth, value: score)
                        }
                    }
                    else
                    {
                        LineChartView(
                            data: [],
                            title: "甄試入學 暫無資料",
                            style: self.chartStyle,
                            form: ChartForm.extraLarge,
                            rateValue: nil
                        )
                        .padding(10)
                        //沒有資料 不開放點選以避免發生錯誤
                        .disabled(true)
                    }
                }
            }
        }
        .foregroundStyle(Color(.backBar))
        .background(Color(.prefer))
        .sheet(isPresented: self.$showHistory5000)
        {
            ScoreHistoryView(name: self.name, score: self.score5000!)
        }
        .sheet(isPresented: self.$showHistory8000)
        {
            ScoreHistoryView(name: self.name, score: self.score8000!)
        }
    }
}
