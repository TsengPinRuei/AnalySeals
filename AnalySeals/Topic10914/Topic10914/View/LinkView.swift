//
//  LinkView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/7.
//

import SwiftUI

struct LinkView: View
{
    @Environment(\.dismiss) private var dismiss
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    @State private var showFilter: Bool=false
    @State private var text: String=""
    //使用者選擇的Picker選項 地區 縣市
    @State private var option: [String]=["地區", "縣市"]
    @State private var result: [String]=[]
    @State private var school: [String]=[]
    
    private let region: [String]=["地區", "北", "中", "南", "東", "外島"]
    
    //MARK: 篩選
    func filtList()
    {
        switch(self.option[0])
        {
            case "北":
                switch(self.option[1])
                {
                    case "臺北市":
                        self.result=["中國科技大學", "國立臺北科技大學", "國立臺北商業大學", "國立臺北護理健康大學", "國立臺灣科技大學", "國立臺灣戲曲學院大學", "德明財經科技大學", "中華科技大學", "臺北城市科技大學", "國立臺北藝術大學","國立臺北教育大學", "國立政治大學", "國立臺灣大學", "國立臺灣師範大學", "臺北市立大學", "銘傳大學", "實踐大學", "大同大學", "臺北醫學大學", "康寧大學", "東吳大學", "中國文化大學", "世新大學"]
                    case "新北市":
                        self.result=["明志科技大學", "景文科技大學", "東南科技大學", "華夏科技大學", "致理科技大學", "宏國德霖科技大學", "臺北海洋科技大學", "明志科技大學", "亞東科技大學", "黎明技術學院", "國立臺北大學", "國立臺灣藝術大學", "輔仁大學", "淡江大學"]
                    case "基隆市":
                        self.result=["崇右影藝科技大學", "國立臺灣海洋大學", "華梵大學", "真理大學", "法鼓文理學院", "馬偕醫學院"]
                    case "桃園市":
                        self.result=["龍華科技大學", "健行科技大學", "萬能科技大學", "長庚科技大學", "國立中央大學", "國立體育大學", "中原大學", "長庚大學", "元智大學", "開南大學"]
                    case "新竹市":
                        self.result=["大華科技大學", "明新科技大學", "聖約翰科技大學", "元培醫事科技大學", "敏實科技大學", "醒吾科技大學", "國立清華大學", "國立陽明交通大學", "中華大學", "玄奘大學"]
                    case "縣市":
                        self.result=["中國科技大學", "國立臺北科技大學", "國立臺北商業大學", "國立臺北護理健康大學", "國立臺灣科技大學", "國立臺灣戲曲學院大學", "德明財經科技大學", "中華科技大學", "臺北城市科技大學", "明志科技大學", "景文科技大學", "東南科技大學", "華夏科技大學", "致理科技大學", "宏國德霖科技大學", "臺北海洋科技大學", "明志科技大學", "亞東科技大學", "黎明技術學院", "崇右影藝科技大學", "龍華科技大學", "健行科技大學", "萬能科技大學", "長庚科技大學", "大華科技大學", "明新科技大學", "聖約翰科技大學", "元培醫事科技大學", "敏實科技大學", "醒吾科技大學", "國立臺北藝術大學","國立臺北教育大學", "國立政治大學", "國立臺灣大學", "國立臺灣師範大學", "臺北市立大學", "銘傳大學", "實踐大學", "大同大學", "臺北醫學大學", "康寧大學", "東吳大學", "中國文化大學", "世新大學", "國立臺北大學", "國立臺灣藝術大學", "輔仁大學", "淡江大學", "國立臺灣海洋大學", "華梵大學", "真理大學", "法鼓文理學院", "馬偕醫學院", "國立中央大學", "國立體育大學", "中原大學", "長庚大學", "元智大學", "開南大學", "國立清華大學", "國立陽明交通大學", "中華大學", "玄奘大學"]
                    default:
                        self.result=[]
                }
            case "中":
                switch(self.option[1])
                {
                    case "苗栗縣":
                        self.result=["育達科技大學", "國立聯合大學"]
                    case "臺中市":
                        self.result=["國立勤益科技大學", "國立臺中科技大學", "朝陽科技大學", "弘光科技大學", "嶺東科技大學", "中臺科技大學", "僑光科技大學", "修平科技大學", "國立中興大學", "國立臺中教育大學", "國立臺灣體育運動大學", "東海大學", "逢甲大學", "靜宜大學", "中山醫學大學", "中國醫藥大學", "亞洲大學"]
                    case "彰化縣":
                        self.result=["建國科技大學", "中州科技大學", "國立彰化師範大學", "大葉大學", "明道大學"]
                    case "南投縣":
                        self.result=["南開科技大學", "國立暨南國際大學"]
                    case "雲林縣":
                        self.result=["國立雲林科技大學", "國立虎尾科技大學", "環球科技大學"]
                    case "縣市":
                        self.result=["育達科技大學", "國立勤益科技大學", "國立臺中科技大學", "朝陽科技大學", "弘光科技大學", "嶺東科技大學", "中臺科技大學", "僑光科技大學", "修平科技大學", "建國科技大學", "中州科技大學", "南開科技大學", "國立雲林科技大學", "國立虎尾科技大學", "環球科技大學", "國立聯合大學", "國立中興大學", "國立臺中教育大學", "國立臺灣體育運動大學", "東海大學", "逢甲大學", "靜宜大學", "中山醫學大學", "中國醫藥大學", "亞洲大學", "國立彰化師範大學", "大葉大學", "明道大學", "國立暨南國際大學"]
                    default:
                        self.result=[]
                }
            case "南":
                switch(self.option[1])
                {
                    case "嘉義市":
                        self.result=["國立嘉義大學"]
                    case "嘉義縣":
                        self.result=["吳鳳科技大學", "國立中正大學", "南華大學"]
                    case "臺南市":
                        self.result=["南臺科技大學", "崑山科技大學", "嘉南藥理大學", "臺南應用科技大學", "遠東科技大學", "國立成功大學", "國立臺南藝術大學", "國立臺南大學", "臺灣首府大學", "中信金融管理學院", "長榮大學"]
                    case "高雄市":
                        self.result=["國立高雄科技大學", "國立高雄餐旅大學", "樹德科技大學", "輔英科技大學", "正修科技大學", "高苑科技大學", "文藻外語大學", "東方設計大學", "國立中山大學", "國立高雄大學", "國立高雄師範大學", "義守大學", "高雄醫學大學"]
                    case "屏東縣":
                        self.result=["國立屏東科技大學", "大仁科技大學", "美和科技大學", "國立屏東大學"]
                    case "縣市":
                        self.result=["吳鳳科技大學", "南臺科技大學", "崑山科技大學", "嘉南藥理大學", "臺南應用科技大學", "遠東科技大學", "國立高雄科技大學", "國立高雄餐旅大學", "樹德科技大學", "輔英科技大學", "正修科技大學", "高苑科技大學", "文藻外語大學", "東方設計大學", "國立屏東科技大學", "大仁科技大學", "美和科技大學", "國立嘉義大學", "國立中正大學", "南華大學", "國立成功大學", "國立臺南藝術大學", "國立臺南大學", "臺灣首府大學", "中信金融管理學院", "長榮大學", "國立中山大學", "國立高雄大學", "國立高雄師範大學", "義守大學", "高雄醫學大學", "國立屏東大學"]
                    default:
                        self.result=[]
                }
            case "東":
                switch(self.option[1])
                {
                    case "宜蘭縣":
                        self.result=["國立宜蘭大學", "佛光大學"]
                    case "花蓮縣":
                        self.result=["慈濟科技大學", "國立東華大學", "慈濟大學"]
                    case "臺東縣":
                        self.result=["國立臺東大學"]
                    case "縣市":
                        self.result=["慈濟科技大學", "國立宜蘭大學", "佛光大學", "國立東華大學", "慈濟大學", "國立臺東大學"]
                    default:
                        self.result=[]
                }
            case "外島":
                switch(self.option[1])
                {
                    case "金門縣":
                        self.result=["國立金門大學"]
                    case "澎湖縣":
                        self.result=["國立澎湖科技大學"]
                    case "縣市":
                        self.result=["國立澎湖科技大學", "國立金門大學"]
                    default:
                        self.result=[]
                }
            default:
                self.result=School(degree: "", city: "").normalUniversity()
                self.result.append(contentsOf: School(degree: "", city: "").technologyUniversity())
        }
        
        self.school=self.result.sorted()
    }
    //MARK: 搜尋
    private func setSchoolLink(name: String) -> String
    {
        if(name.contains("科技") || name.contains("商業") || name.contains("藥理") || name.contains("戲曲") || name.contains("護理") || name.contains("餐旅"))
        {
            return School(degree: "", city: "").setTechnologyUniversityLink(school: name)
        }
        else
        {
            return School(degree: "", city: "").setNormalUniversityLink(school: name)
        }
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: 學校列表
            List
            {
                Section("上滑以重新整理至「篩選結果」")
                {
                    ForEach(self.school, id: \.self)
                    {index in
                        Link(destination: URL(string: self.setSchoolLink(name: index))!)
                        {
                            HStack
                            {
                                Text(index)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    .listRowBackground(Color(.systemGray5))
                }
            }
            .foregroundStyle(Color(.backBar))
            .listStyle(.grouped)
            .searchable(text: self.$text, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜尋訊息")
            .onSubmit(of: .search)
            {
                //從篩選結果過濾
                self.school=self.result.filter
                {
                    $0.contains(text)
                }
                .sorted()
            }
            .refreshable
            {
                self.text=""
                self.school=self.result.sorted()
            }
            
            //MARK: 篩選畫面
            if(self.showFilter)
            {
                Group
                {
                    Rectangle()
                        .fill(.black.opacity(0.8))
                        .ignoresSafeArea()
                        .onTapGesture
                        {
                            withAnimation(.easeOut)
                            {
                                self.showFilter.toggle()
                            }
                        }
                    
                    //MARK: 地區 縣市 學校 向下按鈕
                    VStack(spacing: 30)
                    {
                        Picker(selection: self.$option[0], label: Text(""))
                        {
                            ForEach(self.region.indices, id: \.self)
                            {index in
                                Text((index>0 && index<5) ? "\(self.region[index])部":self.region[index]).tag(self.region[index])
                            }
                        }
                        .foregroundStyle(.black)
                        .frame(width: 300, height: 110)
                        .background(Color(.systemGray5))
                        .clipShape(.rect(cornerRadius: 20))
                        .pickerStyle(InlinePickerStyle())
                        //地區重置時 縣市也要重置
                        .onChange(of: self.option[0])
                        {(_, new) in
                            if(new=="地區")
                            {
                                self.option[1]="縣市"
                            }
                        }
                        
                        Picker(selection: self.$option[1], label: Text(""))
                        {
                            ForEach(City(region: self.option[0]).setCity(), id:\.self)
                            {index in
                                Text(index).tag(index)
                            }
                        }
                        .foregroundStyle(.black)
                        .frame(width: 300, height: 110)
                        .background(Color(.systemGray5))
                        .clipShape(.rect(cornerRadius: 20))
                        .pickerStyle(InlinePickerStyle())
                        
                        Button
                        {
                            //篩選顯示的列表
                            self.filtList()
                            withAnimation(.easeOut)
                            {
                                self.showFilter.toggle()
                            }
                        }
                        label:
                        {
                            Text("篩選完畢")
                                .font(.headline)
                                .foregroundStyle(Color(.backBar))
                                .padding()
                                .frame(width: 300)
                                .background(Color(.systemGray5))
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.top, 50)
                    }
                }
                .transition(.opacity.animation(.easeInOut))
            }
        }
        .modifyNavigationBarStyle(title: "學校連結", display: .inline)
        .toolbar
        {
            //MARK: 返回主頁
            ToolbarItem(placement: .cancellationAction)
            {
                Button
                {
                    self.dismiss()
                }
                label:
                {
                    HStack(spacing: 3)
                    {
                        Image(systemName: "chevron.left").bold()
                        
                        Text("返回主頁")
                    }
                }
                .opacity(self.showBackButton ? 1:0)
            }
            
            //MARK: 篩選
            ToolbarItem(placement: .topBarTrailing)
            {
                Button
                {
                    withAnimation(.easeOut)
                    {
                        self.showFilter.toggle()
                    }
                }
                label:
                {
                    Text("篩選")
                        .bold()
                        .foregroundStyle(Color(.toolbar))
                }
            }
        }
        //MARK: 所有學校連結
        .onAppear
        {
            self.result.append(contentsOf: School(degree: "", city: "").normalUniversity())
            self.result.append(contentsOf: School(degree: "", city: "").technologyUniversity())
            self.school.append(contentsOf: School(degree: "", city: "").normalUniversity())
            self.school.append(contentsOf: School(degree: "", city: "").technologyUniversity())
            self.school.sort()
            
            //0.5秒之後再顯示返回主頁 比較順暢好看
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
            {
                withAnimation(.easeInOut)
                {
                    self.showBackButton=true
                }
            }
        }
    }
}
