//
//  PointView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct PointView: View
{
    //是否顯示推薦落點分析：極具優勢 安全穩固 保守選填 最適落點 嘗試進攻 夢幻校系 其他參考
    @AppStorage("prefer") private var prefer: [Bool]=[false, true, true, true, true, false, false]
    //當前使用者的MBTI結果推薦科系
    @AppStorage("MBTIDepartment") private var mbtiDepartment: [String]=[]
    
    @Binding var selection: Int
    
    //輸入狀態
    @FocusState private var focus: Focus?
    
    //網路爬蟲狀態
    @State private var crawling: Bool=false
    //顯示學校細節sheet的狀態
    @State private var showSchoolScore: Bool=false
    //進度
    @State private var progress: Double=0
    //網路口
    @State private var port: Int?
    //當前選擇的學校名稱
    @State private var currentName: String?
    //學校細節
    @State private var detail: String?
    @State private var group: String="我的類群"
    //搜尋
    @State private var text: String=""
    //警戒訊息用
    @State private var alert: Alerter=Alerter(message: "", show: false)
    @State private var school: SchoolJSON?
    //國文 英文 數學 專業科目一 專業科目二
    @State private var score: [String]=Array(repeating: "", count: 5)
    @State private var timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let subject: [String]=["我的類群", "機械群", "動力機械群", "電機與電子群電機類", "電機與電子群資電類", "化工群", "土木與建築群", "設計群", "工程與管理類", "商業與管理群", "衛生與護理類", "食品群", "家政群幼保類", "家政群生活應用類", "農業群", "外語群英語類", "外語群日語類", "餐旅群", "海事群", "水產群", "藝術群影視類", "資管類"]
    //輸入格的Focus
    private let field: [Focus]=[.chinese, .english, .math, .professional1, .professional2]
    
    //MARK: 輸入的狀態
    enum Focus
    {
        case chinese
        case english
        case math
        case professional1
        case professional2
    }
    
    //MARK: 取得完整學校資訊
    private func getDetail(index: [String:String], completion: @escaping (String, String) -> Void)
    {
        if let key=index.keys.first,
           let value=index.values.first
        {
            //格式化處理完整學校科系名稱
            let departmentName: String=String(key[key.index(after: key.firstIndex(of: "_")!)..<(key.contains("校區") ? key.lastIndex(of: "（")!:key.endIndex)])
                .replacingOccurrences(of: " ", with: "\n")
            let schoolName: String=String(key[key.startIndex...(key.contains("學院") ? key.firstIndex(of: "院")!:key.firstIndex(of: "學")!)])
                //學校校區
                .appending(key.contains("（") ? (key[key.lastIndex(of: "（")!..<key.lastIndex(of: "）")!]):"")
                .replacingOccurrences(of: "（", with: " ")
                .replacingOccurrences(of: "台", with: "臺")
            
            completion(schoolName.appending("\n".appending(departmentName)), value)
        }
    }
    //MARK: JSON
    private func getJSONData(port: String) async
    {
        //網頁伺服器的IP位址
        //Ruei的網路 GIGABYTE IP位址: 172.20.10.5
        //Ruei的網路 MacBook Pro IP位址: 172.20.10.3
        var urlHead: String="http://172.20.10.3:".appending(port).appending("/crawler?type=").appending(self.group)
        
        //將超過頂標分數改成頂標分數
        let top: [String]=self.getTopScore()
        for i in 0..<top.count
        {
            urlHead.append("&score_\(i+1)=".appending(top[i]))
        }
        
        if let urlHead=urlHead.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url=URL(string: urlHead)
        {
            SwiftUI.Task
            {
                do
                {
                    let sessionConfiguration=URLSessionConfiguration.default
                    //設定timeout限制時間為120秒
                    sessionConfiguration.timeoutIntervalForRequest=120
                    //設定timeout限制時間為120秒
                    sessionConfiguration.timeoutIntervalForResource=120
                    //進入URL伺服器執行爬蟲
                    let (data, _)=try await URLSession(configuration: sessionConfiguration).data(from: url)
                    //將爬蟲結果解碼成SchoolJSON模型
                    self.school=try JSONDecoder().decode(SchoolJSON.self, from: data)
                    //根據port判斷為登記分發還是甄試入學
                    self.port=Int(port)
                }
                catch
                {
                    //爬蟲失敗
                    print("PointView GetJSONData(\(port)) Error: \(error)")
                    
                    //退出爬蟲載入畫面
                    withAnimation(.easeInOut(duration: 0.5))
                    {
                        self.crawling=false
                        //進度歸零
                        self.progress=0
                        //重新計數
                        self.timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                    
                    self.alert.showAlert(title: "蟲蟲爬不動了😵‍💫", message: "蟲蟲需要你這麼做\n1. 檢查網路連線\n2. 檢查版本\n3. 詢問小海豹")
                }
            }
        }
        
        //開始執行網路爬蟲
        withAnimation(.easeInOut(duration: 0.8))
        {
            self.crawling.toggle()
        }
    }
    //MARK: 成績上限
    private func getTopScore() -> [String]
    {
        let top1: [Int]=[100, 100, 100, 100, 94, 94, 92, 100, 96, 95, 92, 100, 94, 100, 100, 100, 96, 95, 100, 86, 84]
        let top2: [Int]=[92, 90, 90, 100, 89, 86, 87, 85, 88, 92, 84, 92, 92, 88, 94, 74, 84, 90, 93, 100, 90]
        
        var professional1: Int=Int(self.score[3])!
        var professional2: Int=Int(self.score[4])!
        
        for i in 1..<self.subject.count
        {
            if(self.group==self.subject[i])
            {
                professional1=min(professional1, top1[i-1])
                professional2=min(professional2, top2[i-1])
                break
            }
        }
        
        return [self.score[0], self.score[1], self.score[2], String(professional1), String(professional2)]
    }
    //MARK: 判斷當前科系是否為MBTI推薦科系之一
    private func isMBTIDepartment(department: String) -> Bool
    {
        //科系名稱 EX: 資訊管理學系 取 資訊管理
        let subject: String=String(department[department.startIndex..<department.lastIndex(of: department.contains("學") ? "學":"系")!])
        
        for i in self.mbtiDepartment
        {
            //不論什麼系 相關科系都判斷為有
            if(i.hasPrefix(subject))
            {
                return true
            }
        }
        return false
    }
    //MARK: 按鈕位置
    private func setButtonOffset() -> CGFloat
    {
        if(self.group=="我的類群")
        {
            return UIScreen.main.bounds.height
        }
        else
        {
            for i in 0..<self.score.count
            {
                if(self.score[i].isEmpty)
                {
                    return UIScreen.main.bounds.height
                }
            }
            
            return 283
        }
    }
    //MARK: 輸入格長度
    private func setHeight(index: Int) -> CGFloat
    {
        switch(index)
        {
            case 0:
                return 78
            case 1:
                return 79
            case 2:
                return 78
            case 3:
                return 78
            case 4:
                return 75
            default:
                return 0
        }
    }
    //MARK: 志願分類
    private func setSchoolList(school: SchoolJSON, name: String) -> [[String:String]]
    {
        var result: [[String:String]]=[]
        
        switch(name)
        {
            case "極具優勢":
                result=school.levelHigh.values.flatMap({ $0 })
            case "安全穩固":
                result=school.levelSafe.values.flatMap({ $0 })
            case "保守選填":
                result=school.levelCareful.values.flatMap({ $0 })
            case "最適落點":
                result=school.levelFit.values.flatMap({ $0 })
            case "嘗試進攻":
                result=school.levelTry.values.flatMap({ $0 })
            case "夢幻校系":
                result=school.levelDream.values.flatMap({ $0 })
            case "其他參考":
                result=school.levelOther.values.flatMap({ $0 })
            default:
                result=[["":""]]
        }
        
        //沒有搜尋
        if(self.text.isEmpty)
        {
            return result
        }
        else
        {
            //篩選包含搜尋字串的學校
            return result.filter
            {data in
                for i in data.keys
                {
                    if(i.contains(self.text))
                    {
                        return true
                    }
                }
                return false
            }
        }
    }
    //MARK: 預覽分數
    private func setPreview() -> String
    {
        switch(self.focus)
        {
            case .chinese:
                return self.score[0]
            case .english:
                return self.score[1]
            case .math:
                return self.score[2]
            case .professional1:
                return self.score[3]
            case .professional2:
                return self.score[4]
            default:
                return ""
        }
    }
    //MARK: 是否顯示推薦落點分析結果
    private func showPrefer(name: String) -> Bool
    {
        //極具優勢 安全穩固 保守選填 最適落點 嘗試進攻 夢幻校系 其他參考
        switch(name)
        {
            case "極具優勢":
                return self.prefer[0]
            case "安全穩固":
                return self.prefer[1]
            case "保守選填":
                return self.prefer[2]
            case "最適落點":
                return self.prefer[3]
            case "嘗試進攻":
                return self.prefer[4]
            case "夢幻校系":
                return self.prefer[5]
            case "其他參考":
                return self.prefer[6]
            default:
                return false
        }
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.background).ignoresSafeArea(.all)
            
            //開始進行網路爬蟲
            if(self.crawling)
            {
                //MARK: 網路爬蟲出結果
                if let school=self.school
                {
                    VStack(spacing: 0)
                    {
                        VStack
                        {
                            Text("可以到「設定」自定義顯示落點分析結果")
                                .bold()
                                .font(.body)
                            
                            //MARK: 搜尋列
                            TextField("想找什麼學校？", text: self.$text)
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(alignment: .trailing)
                                {
                                    if(!self.text.isEmpty)
                                    {
                                        Button
                                        {
                                            withAnimation(.easeInOut)
                                            {
                                                self.text=""
                                            }
                                        }
                                        label:
                                        {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.gray)
                                                .padding(10)
                                        }
                                        .transition(.opacity.animation(.easeInOut))
                                    }
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar)))
                                .submitLabel(.done)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        List
                        {
                            //MARK: 重新作答按鈕
                            Button("重新作答")
                            {
                                withAnimation(.easeInOut(duration: 0.5))
                                {
                                    self.score=Array(repeating: "", count: 5)
                                    //進度歸零
                                    self.progress=0
                                    //重新計數
                                    self.timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                    //重置JSON檔案
                                    self.school=nil
                                    self.text=""
                                    self.crawling=false
                                }
                            }
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color(red: 183/255, green: 74/255, blue: 97/255))
                            
                            //MARK: 學校列表
                            //key -> "機會渺茫", "夢幻校系", "嘗試進攻", "最適落點", "保守選填", "安全穩固", "極具優勢", "其他參考"
                            //value -> 學校數量
                            ForEach(
                                school.result.sorted(
                                    by: { (Int($1.value[1..<$1.value.count-1]) ?? 0)<(Int($0.value[1..<$0.value.count-1]) ?? 0) }
                                ),
                                id: \.key
                            )
                            {(key, value) in
                                //有學校再顯示列表
                                if(self.showPrefer(name: key))
                                {
                                    Section("\(key)：\(value[1..<value.count-1])")
                                    {
                                        //避免沒有學校而出錯
                                        if("\(value)" != "(0)")
                                        {
                                            //MARK: 學校列表
                                            ForEach(self.setSchoolList(school: school, name: key), id: \.self)
                                            {index in
                                                Button
                                                {
                                                    DispatchQueue.main.async
                                                    {
                                                        //MARK: 取得學校名稱及資訊
                                                        self.getDetail(index: index)
                                                        {(name, detail) in
                                                            self.currentName=name
                                                            self.detail=detail
                                                        }
                                                        
                                                        self.showSchoolScore.toggle()
                                                    }
                                                }
                                                label:
                                                {
                                                    if let name=index.keys.first
                                                    {
                                                        //MARK: 科系名稱
                                                        let department: String=String(name[name.index(after: name.firstIndex(of: "_")!)..<(name.contains("校區") ? name.lastIndex(of: "（")!:name.endIndex)]).replacingOccurrences(of: " ", with: "\n")
                                                        //是否為MBTI推薦科系
                                                        let isMBTI: Bool=self.isMBTIDepartment(department: department)
                                                        HStack(spacing: 20)
                                                        {
                                                            //MARK: 縣市名稱
                                                            //注意"大學"及"學院"
                                                            Text(
                                                                String(name[name.index(after: (name.contains("大學") ? name.firstIndex(of: "學")!:name.firstIndex(of: "院")!))..<name.firstIndex(of: "_")!])
                                                                    .replacingOccurrences(of: "台", with: "臺")
                                                            )
                                                            .padding(10)
                                                            .background(Color(.systemGray5))
                                                            .clipShape(.rect(cornerRadius: 10))
                                                            
                                                            //MARK: 學校名稱及科系
                                                            VStack(alignment: .leading, spacing: 0)
                                                            {
                                                                //學校名稱 注意"大學"及"學院"
                                                                Text(
                                                                    String(name[name.startIndex...(name.contains("學院") ? name.firstIndex(of: "院")!:name.firstIndex(of: "學")!)])
                                                                        //學校校區
                                                                        .appending(name.contains("（") ? (name[name.lastIndex(of: "（")!..<name.lastIndex(of: "）")!]):"")
                                                                        .replacingOccurrences(of: "（", with: " ")
                                                                        .replacingOccurrences(of: "台", with: "臺")
                                                                )
                                                                
                                                                //科系名稱 注意有無校區
                                                                Text(department)
                                                            }
                                                        }
                                                        .bold(isMBTI)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .tint(Color(.backBar))
                                    .headerProminence(.increased)
                                }
                            }
                        }
                        .listStyle(.sidebar)
                        .scrollContentBackground(.hidden)
                    }
                    //MARK: PointView
                    //重新填寫答案而回到PointView的狀況 類群及分數都要重置
                    .onAppear
                    {
                        self.timer.upstream.connect().cancel()
                        self.group="我的類群"
                    }
                }
                //MARK: 進行網路爬蟲中
                else
                {
                    GeometryReader
                    {reader in
                        //退出爬蟲載入畫面
                        Button
                        {
                            withAnimation(.easeInOut(duration: 0.5))
                            {
                                self.crawling=false
                                //進度歸零
                                self.progress=0
                                //重新計數
                                self.timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            }
                        }
                        label:
                        {
                            Image(systemName: "arrow.turn.up.left")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        .padding([.top, .leading])
                        
                        //MARK: ProgressView
                        ProgressView(
                            value: self.progress,
                            total: 100,
                            label:
                                {
                                    if(self.progress<=30)
                                    {
                                        Text("預計剩餘時間：1分鐘30秒")
                                    }
                                    else if(self.progress<=60)
                                    {
                                        Text("預計剩餘時間：1分鐘")
                                    }
                                    else if(self.progress<=90)
                                    {
                                        Text("預計剩餘時間：30秒")
                                    }
                                    else
                                    {
                                        Text("將分數顯示出來中...")
                                    }
                                },
                            currentValueLabel: { Text("\(Int(round(self.progress)))%").animation(.easeInOut, value: self.progress) }
                        )
                        //自定義的ProgressView
                        .progressViewStyle(ProgressViewBar(distance: 1.1))
                        //根據progress顯示進度
                        .onReceive(self.timer)
                        {_ in
                            if(self.progress<100)
                            {
                                withAnimation(.easeInOut(duration: 1.5))
                                {
                                    if(self.progress+1.1<100)
                                    {
                                        self.progress+=1.1
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
            //MARK: 輸入成績
            else
            {
                Image(.answerCard)
                    .resizable()
                    //MARK: Picker
                    .overlay
                    {
                        GeometryReader
                        {_ in
                            Picker("", selection: self.$group)
                            {
                                ForEach(self.subject, id: \.self)
                                {index in
                                    Text(index)
                                        .font(.body)
                                        .foregroundStyle(.black)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                            //高度要對其圖片輸入作答框高度 -> iPhone 14 Pro格式
                            .frame(height: 85)
                            //.overlay(Rectangle().stroke(.black))
                            //將Pickerd調整到作答框位置 -> iPhone 14 Pro格式
                            .padding(.leading, 170)
                            .padding(.trailing, 28)
                            .padding(.top, 85)
                        }
                    }
                    //MARK: TextField Button
                    .overlay
                    {
                        GeometryReader
                        {reader in
                            //圖片中的間隔
                            VStack(spacing: 5)
                            {
                                ForEach(self.$score.indices, id: \.self)
                                {index in
                                    TextField("", text: self.$score[index])
                                        //輸入狀態
                                        .focused(self.$focus, equals: self.field[index])
                                        //最多輸入三個數字
                                        .limitInput(text: self.$score[index], max: 3)
                                        .keyboardType(.numberPad)
                                        .font(.largeTitle)
                                        .foregroundStyle(.black)
                                        //(為當前輸入狀態 || 輸入完成) ? 將輸入位置調整到中間 每輸入一個數字 往前拉間距10格 以確保分數置中
                                        .padding(.leading, (self.focus==self.field[index] || !self.score[index].isEmpty) ? 90-CGFloat(self.score[index].count)*10:0)
                                        //高度要對其圖片輸入作答框高度 -> iPhone 14 Pro格式
                                        .frame(height: self.setHeight(index: index))
                                        //檢查輸入格位置
                                        //.background(.gray.opacity(0.5))
                                        //分數範圍限制
                                        .onChange(of: self.score[index])
                                        {(_, new) in
                                            let score=Int(new) ?? 0
                                            
                                            if(score>100)
                                            {
                                                self.score[index]="100"
                                            }
                                            else if(score<0)
                                            {
                                                self.score[index]="0"
                                            }
                                        }
                                }
                            }
                            //將TextField調整到作答框位置 -> iPhone 14 Pro格式
                            .padding(.leading, 175)
                            .padding(.trailing, 30)
                            .padding(.top, 152)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: reader.size.height*0.9)
                            //.background(.red.opacity(0.3))
                        }
                        //避免鍵盤擠壓到畫面
                        .ignoresSafeArea(.keyboard)
                    }
                
                HStack(spacing: 20)
                {
                    //MARK: 登記分發
                    Button
                    {
                        SwiftUI.Task
                        {
                            await self.getJSONData(port: "8000")
                        }
                    }
                    label:
                    {
                        Text("登記分發")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 183/255, green: 74/255, blue: 97/255))
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    //登記分發沒有資管類
                    .opacity(self.group=="資管類" ? 0.5:1)
                    .disabled(self.group=="資管類")
                    .animation(.easeInOut, value: self.group)
                    
                    //MARK: 甄選入學
                    Button
                    {
                        SwiftUI.Task
                        {
                            await self.getJSONData(port: "5000")
                        }
                    }
                    label:
                    {
                        Text("甄選入學")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 183/255, green: 74/255, blue: 97/255))
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .frame(width: 325)
                //調整到對應圖片框的位置
                .padding(.leading, 20)
                .offset(y: self.setButtonOffset())
                //動畫式的移動位置
                .animation(.easeInOut, value: self.setButtonOffset())
            }
        }
        //解決BottomBarView背景顏色受到HomeView影響的問題
        .padding(.bottom, 0.5)
        //MARK: Alert
        .alert(isPresented: self.$alert.show)
        {
            Alert(
                title: Text(self.alert.title!),
                message: Text(self.alert.message),
                dismissButton: .default(Text("確認"))
            )
        }
        //MARK: SchoolScoreView
        .sheet(isPresented: self.$showSchoolScore)
        {
            if let port=self.port,
               let name=self.currentName,
               let detail=self.detail
            {
                SchoolScoreView(port: port, name: name, detail: detail, score: self.score)
                    .ignoresSafeArea(.all)
                    .presentationDetents([.large])
                    //允許sheet內容可以滑動
                    .presentationContentInteraction(.scrolls)
            }
            else
            {
                ZStack
                {
                    Color(.background).ignoresSafeArea(.all)
                    
                    VStack
                    {
                        Image(.nothing)
                            .resizable()
                            .scaledToFit()
                        
                        Text("本豹目前找不到這個科系的資料🔍\n請稍候再來看看～")
                            .bold()
                            .font(.title3)
                    }
                }
                .presentationDetents([.medium])
            }
        }
        //MARK: Toolbar
        .toolbar
        {
            if(!self.crawling)
            {
                ToolbarItem(placement: .keyboard)
                {
                    HStack
                    {
                        //預覽輸入的分數
                        Text(self.setPreview())
                            .foregroundStyle(.black)
                            .padding(5)
                            //有輸入分數再顯示
                            .overlay
                            {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                                    .opacity(self.setPreview().isEmpty ? 0:1)
                                    .animation(.easeInOut, value: self.setPreview())
                            }
                        
                        Spacer()
                        
                        Button("下一格")
                        {
                            //切換到下一個輸入狀態
                            switch(self.focus)
                            {
                                case .chinese:
                                    self.focus = .english
                                case .english:
                                    self.focus = .math
                                case .math:
                                    self.focus = .professional1
                                case .professional1:
                                    self.focus = .professional2
                                case .professional2:
                                    self.focus=nil
                                default:
                                    self.focus=nil
                            }
                        }
                        .disabled(self.focus == .professional2)
                        .foregroundStyle(self.focus == .professional2 ? .gray:.blue)
                        
                        Divider()
                        
                        Button("確認")
                        {
                            UIApplication.shared.dismissKeyboard()
                        }
                        .foregroundStyle(.blue)
                    }
                    .font(.body)
                }
            }
        }
    }
}
