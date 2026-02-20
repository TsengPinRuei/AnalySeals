//
//  TestView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI
import SwiftUIIntrospect
import Introspect

struct TestView: View
{
    //當前使用者的MBTI結果
    @AppStorage("currentMBTI") private var currentMBTI: [MBTIJSON]?
    //MBTI作答
    @AppStorage("mbtiAnswer") private var mbtiAnswer: [Double]=Array(repeating: 3, count: 60)
    //MBTI歷史作答
    @AppStorage("mbtiHistory") private var mbtiHistory: [[Double]]=[]
    
    @Binding var selection: Int
    
    //MBTIHistoryView中DisclosureGroup的展開狀態
    @State private var expand: [Bool]=[]
    //顯示所有答案的狀態
    @State private var showAnswer: Bool=false
    //是否顯示LoadingView的狀態
    @State private var showLoading: Bool=false
    @State private var progress: Double=0
    //當前題目
    @State private var index: Int=0
    @State private var alert: Alerter=Alerter(message: "", show: false)
    //網路爬蟲MBTI的結果檔案
    @State private var mbti: MBTIJSON?
    @State private var timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let option: [String]=["非常不同意", "很不同意", "不同意", "還好", "同意", "很同意", "非常同意"]
    private let question: [String] =
    {
        var array: [String]=[]
        
        for i in 1...60
        {
            array.append("mbti\(i)")
        }
        
        return array
    }()
    
    //MARK: JSON
    private func getJSONData(random: Bool=false) async
    {
        //欄位編號
        let letter: [String]=["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        //網址內容
        var body: [String:String]=[:]
        var temporaryBody: String=""
        
        //顯示載入
        withAnimation(.easeInOut)
        {
            self.showLoading=true
        }
        
        //對應欄位輸入對應答案
        for i in 0..<self.mbtiAnswer.count
        {
            //POST body
            body["\(letter[i/6])\(i%6+1)"]="\(Int(self.mbtiAnswer[i]+1))"
            //網址後面的body
            temporaryBody.append("\(letter[i/6])\(i%6+1)=\(Int(self.mbtiAnswer[i]+1))&")
        }
        //刪除最後的&
        temporaryBody.removeLast()
        
        //MARK: 轉換為JSON Data
        if let data=try? JSONSerialization.data(withJSONObject: body, options: .sortedKeys),
           //Ruei的網路 GIGABYTE IP位址: 172.20.10.5
           //Ruei的網路 MacBook Pro IP位址: 172.20.10.3
           //random表示隨機作答
           let url=URL(string: "http://172.20.10.3:8080/mbti?".appending(random ? "":temporaryBody))
        {
            var request: URLRequest=URLRequest(url: url)
            
            //設定POST模式
            request.httpMethod="POST"
            //設定內容
            request.httpBody=data
            //設定參數
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //MARK: 進行POST爬蟲
            URLSession.shared.dataTask(with: request)
            {(data, response, error) in
                //載入完成
                withAnimation(.easeInOut)
                {
                    self.showLoading=false
                }
                
                //爬蟲成功
                if let data=data
                {
                    //MARK: 轉換成MBTIJSON
                    SwiftUI.Task
                    {
                        do
                        {
                            //將JSON檔案轉為MBTIJSON
                            self.mbti=try JSONDecoder().decode(MBTIJSON.self, from: data)
                            //儲存使用者當前MBTI
                            if let mbti=self.mbti
                            {
                                self.currentMBTI=[mbti]
                            }
                            
                            //初始化
                            withAnimation(.easeInOut)
                            {
                                self.index=0
                                //不是隨機作答 && 歷史紀錄沒有存取過該作答組合
                                if(!random && !self.mbtiHistory.contains(self.mbtiAnswer))
                                {
                                    self.mbtiHistory.append(self.mbtiAnswer)
                                }
                                self.mbtiAnswer=Array(repeating: 3, count: 60)
                            }
                        }
                        catch
                        {
                            print("TestView getJSONData() JSONDecoder Error: \(error.localizedDescription)")
                            self.alert.showAlert(title: "發生錯誤！", message: "請稍候再試一次😵‍💫")
                        }
                    }
                }
                //爬蟲失敗
                else if let error=error
                {
                    print("TestView getJSONData() Error: \(error.localizedDescription)")
                    self.alert.showAlert(title: "發生錯誤！", message: "請檢查：\n1. 網路連線是否穩定\n2. IP位址是否正確")
                }
            }
            .resume()
        }
    }
    //MARK: Slider圖片
    private func setImage(answer: Double) -> String
    {
        switch(answer)
        {
            case 0:
                return "bigDisagree"
            case 1:
                return "disagree"
            case 2:
                return "smallDisagree"
            case 3:
                return "normal"
            case 4:
                return "smallAgree"
            case 5:
                return "agree"
            case 6:
                return "bigAgree"
            default:
                return "AppIcon"
        }
    }
    
    var body: some View
    {
        //MARK: MBTIView
        if(self.currentMBTI != nil)
        {
            if let mbti=self.currentMBTI
            {
                MBTIView(mbti: mbti[0])
                    .onAppear
                    {
                        self.progress=0
                    }
                    .transition(.opacity.animation(.easeInOut))
            }
        }
        else
        {
            //MARK: 作答頁面
            ZStack(alignment: .top)
            {
                Color(.background).ignoresSafeArea(.all)
                
                VStack
                {
                    HStack
                    {
                        Button
                        {
                            //MARK: 上一題按鈕
                            withAnimation(.easeInOut)
                            {
                                self.index=self.index>0 ? self.index-1:self.question.count-1
                            }
                        }
                        label:
                        {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        
                        Spacer()
                        
                        //MARK: 題目號碼
                        HStack(spacing: 0)
                        {
                            Picker("", selection: self.$index)
                            {
                                ForEach(0..<self.question.count, id: \.self)
                                {index in
                                    Text("\(index+1)").tag(index)
                                }
                            }
                            .tint(Color(.backBar))
                            .scaleEffect(1.2)
                            
                            Text("/  \(self.question.count)")
                        }
                        
                        Spacer()
                        
                        //MARK: 下一題按鈕
                        Button
                        {
                            withAnimation(.easeInOut)
                            {
                                self.index=(self.index+1)%self.question.count
                            }
                        }
                        label:
                        {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                    }
                    .bold()
                    .font(.title3)
                    .foregroundStyle(Color(.backBar))
                    .colorMultiply(.gray)
                    .padding()
                    
                    //MARK: TabView
                    TabView(selection: self.$index)
                    {
                        ForEach(self.question.indices, id: \.self)
                        {index in
                            Image(self.question[index])
                                .resizable()
                                .scaledToFit()
                                //點擊查看所有作答
                                .onTapGesture
                                {
                                    self.expand=Array(repeating: false, count: self.mbtiHistory.count)
                                    self.showAnswer.toggle()
                                }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 250)
                    .overlay(Rectangle().stroke(lineWidth: 5).padding(.horizontal, -5))
                    
                    //MARK: 作答提示 隨機作答
                    HStack
                    {
                        Text("點擊題目可以查看作答狀況")
                        
                        Spacer()
                        
                        Button("隨機作答")
                        {
                            SwiftUI.Task
                            {
                                await self.getJSONData(random: true)
                            }
                        }
                        .tint(Color(.background))
                    }
                    .font(.body)
                    
                    VStack
                    {
                        //MARK: 作答
                        //根據使用者作答顯示對應答案
                        Text(self.option[Int(self.mbtiAnswer[self.index])])
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        //MARK: Slider
                        //使用者作答
                        Slider(value: self.$mbtiAnswer[self.index], in: 0...6, step: 1)
                            //利用Github的套件讓SwiftUI更方便使用UIKit的功能
                            .introspect(.slider, on: .iOS(.v13, .v14, .v15, .v16, .v17))
                            {slider in
                                //修改Slider圖片
                                slider
                                    .setThumbImage(UIImage(named: self.setImage(answer: self.mbtiAnswer[self.index]))?
                                    .setSize(CGSize(width: 70, height: 70)), for: .normal)
                            }
                            .tint(Color(.toolbar))
                            .frame(height: 60)
                            .padding(.vertical)
                            .animation(.smooth, value: self.index)
                    }
                    .padding(.vertical)
                    
                    //MARK: 提交按鈕
                    Button
                    {
                        SwiftUI.Task
                        {
                            await self.getJSONData()
                        }
                    }
                    label:
                    {
                        Text("提交答案")
                            .font(.title3)
                            .foregroundStyle(Color(.backBar))
                            .colorInvert()
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color(.toolbar))
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
                
                if(self.showLoading)
                {
                    ZStack
                    {
                        Color(.background).ignoresSafeArea(.all)
                        
                        //MARK: ProgressView
                        GeometryReader
                        {reader in
                            ProgressView(
                                value: self.progress,
                                total: 100,
                                label:
                                    {
                                        let image: [ImageResource]=[._0To25, ._26To50, ._51To75, ._76To100]
                                        
                                        HStack(spacing: 20)
                                        {
                                            ForEach(image.indices, id: \.self)
                                            {index in
                                                Image(image[index])
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: self.progress>=25*(1+Double(index)) ? 80:60)
                                                    .animation(.easeInOut, value: self.progress)
                                            }
                                        }
                                        .frame(height: 80)
                                    },
                                currentValueLabel:
                                    {
                                        Text("\(Int(round(self.progress)))%").animation(.easeInOut, value: self.progress)
                                    }
                            )
                            //自定義的ProgressView
                            .progressViewStyle(ProgressViewBar(distance: 6.6))
                            //根據progress顯示進度
                            .onReceive(self.timer)
                            {_ in
                                if(self.progress<100)
                                {
                                    withAnimation(.easeInOut(duration: 1.5))
                                    {
                                        if(self.progress+6.6<100)
                                        {
                                            self.progress+=6.6
                                        }
                                        else
                                        {
                                            self.progress=100
                                        }
                                    }
                                }
                                //進度跑完停止計時
                                else
                                {
                                    self.timer.upstream.connect().cancel()
                                }
                            }
                            .offset(y: reader.frame(in: .local).midY-50)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .transition(.opacity.animation(.easeInOut))
            .alert(self.alert.title ?? "", isPresented: self.$alert.show)
            {
                Button("我知道了", role: .cancel) {}
            }
            message:
            {
                Text(self.alert.message)
            }
            //MARK: MBTIHistoryView
            .sheet(isPresented: self.$showAnswer)
            {
                MBTIHistoryView(index: self.$index, expand: self.$expand, option: self.option)
                    .presentationContentInteraction(.scrolls)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
