//
//  PreferView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/14.
//

import SwiftUI

struct PreferView: View
{
    //偏好學校
    @AppStorage("preferSchool") private var preferSchool: [String]=[]
    
    @Binding var selection: Int
    
    //顯示校徽還是文字
    @State private var showLogo: Bool=true
    //點選的推薦學校 名稱
    @State private var schoolName: String=""
    @State private var preferHeight: CGFloat=200
    //點選的推薦學校 甄試入學落點
    @State private var score5000: [ChartScore]?
    //點選的推薦學校 登記分發落點
    @State private var score8000: [ChartScore]?
    
    //MARK: Logo
    private func getLogo(name: String) -> String
    {
        if(name.hasPrefix("國立臺灣藝"))
        {
            return "NTUA"
        }
        else if(name.hasPrefix("國立臺南藝"))
        {
            return "TNNUA"
        }
        else if(name.hasPrefix("國立體"))
        {
            return "NTSU"
        }
        else if(name.hasPrefix("國立臺灣體"))
        {
            return "NTUS"
        }
        else if(name.hasPrefix("國立清"))
        {
            return "NTHU"
        }
        else if(name.hasPrefix("國立陽明交通"))
        {
            return "NYCU"
        }
        else if(name.hasPrefix("國立成"))
        {
            return "NCKU"
        }
        else if(name.hasPrefix("國立中央"))
        {
            return "NCU"
        }
        else if(name.hasPrefix("國立中山"))
        {
            return "NSYSU"
        }
        else if(name.hasPrefix("國立臺北大"))
        {
            return "NTPU"
        }
        else if(name.hasPrefix("國立臺灣師"))
        {
            return "NTNU"
        }
        else if(name.hasPrefix("國立中興"))
        {
            return "NCHU"
        }
        else if(name.hasPrefix("國立中正"))
        {
            return "CCU"
        }
        else if(name.hasPrefix("國立臺灣海洋"))
        {
            return "NTOU"
        }
        else if(name.hasPrefix("國立彰化師"))
        {
            return "NCUE"
        }
        else if(name.hasPrefix("國立臺中教"))
        {
            return "NTCU"
        }
        else if(name.hasPrefix("國立高雄大"))
        {
            return "NUK"
        }
        else if(name.hasPrefix("國立東華"))
        {
            return "NDHU"
        }
        else if(name.hasPrefix("國立嘉義"))
        {
            return "NCYU"
        }
        else if(name.hasPrefix("國立暨南"))
        {
            return "NCNU"
        }
        else if(name.hasPrefix("國立臺南"))
        {
            return "NUTN"
        }
        else if(name.hasPrefix("國立高雄師"))
        {
            return "NKNU"
        }
        else if(name.hasPrefix("國立屏東大"))
        {
            return "NPYU"
        }
        else if(name.hasPrefix("國立宜"))
        {
            return "NIU"
        }
        else if(name.hasPrefix("國立臺東大"))
        {
            return "NTTU"
        }
        else if(name.hasPrefix("國立金門"))
        {
            return "NQU"
        }
        else if(name.hasPrefix("國立聯"))
        {
            return "NUU"
        }
        else if(name.hasPrefix("中國醫"))
        {
            return "CMU"
        }
        else if(name.hasPrefix("高雄醫"))
        {
            return "KMU"
        }
        else if(name.hasPrefix("中山醫"))
        {
            return "CSMU"
        }
        else if(name.hasPrefix("臺灣警察"))
        {
            return "TPA"
        }
        else if(name.hasPrefix("輔仁"))
        {
            return "FJU"
        }
        else if(name.hasPrefix("淡江"))
        {
            return "TKU"
        }
        else if(name.hasPrefix("元智"))
        {
            return "YCU"
        }
        else if(name.hasPrefix("長庚大"))
        {
            return "CGU"
        }
        else if(name.hasPrefix("中原"))
        {
            return "CYCU"
        }
        else if(name.hasPrefix("逢甲"))
        {
            return "FCU"
        }
        else if(name.hasPrefix("東海"))
        {
            return "THU"
        }
        else if(name.hasPrefix("嘉南"))
        {
            return "CNU"
        }
        else if(name.hasPrefix("文藻"))
        {
            return "WZUC"
        }
        else if(name.hasPrefix("馬偕醫學"))
        {
            return "MMC"
        }
        else if(name.hasPrefix("義守"))
        {
            return "ISU"
        }
        else if(name.hasPrefix("實踐"))
        {
            return "SCU"
        }
        else if(name.hasPrefix("慈濟大"))
        {
            return "TCU"
        }
        else if(name.hasPrefix("亞洲"))
        {
            return "AU"
        }
        else if(name.hasPrefix("靜宜"))
        {
            return "PU"
        }
        else if(name.hasPrefix("真理"))
        {
            return "AU"
        }
        else if(name.hasPrefix("長榮"))
        {
            return "CJCU"
        }
        else if(name.hasPrefix("大葉"))
        {
            return "DYU"
        }
        else if(name.hasPrefix("大同"))
        {
            return "TTC"
        }
        else if(name.hasPrefix("中華大"))
        {
            return "CHU"
        }
        else if(name.hasPrefix("開南"))
        {
            return "KNU"
        }
        else if(name.hasPrefix("華梵"))
        {
            return "HFU"
        }
        else if(name.hasPrefix("南華"))
        {
            return "NHU"
        }
        else if(name.hasPrefix("玄奘"))
        {
            return "HCU"
        }
        else if(name.hasPrefix("佛光"))
        {
            return "FGU"
        }
        else if(name.hasPrefix("明道"))
        {
            return "MDU"
        }
        else if(name.hasPrefix("臺灣首府"))
        {
            return "TSU"
        }
        else if(name.hasPrefix("國立臺灣科"))
        {
            return "NTUST"
        }
        else if(name.hasPrefix("國立臺北科"))
        {
            return "NTUT"
        }
        else if(name.hasPrefix("國立臺北商"))
        {
            return "NTUB"
        }
        else if(name.hasPrefix("國立雲林"))
        {
            return "YUNTECH"
        }
        else if(name.hasPrefix("國立高雄科"))
        {
            return "NKUST"
        }
        else if(name.hasPrefix("國立虎尾"))
        {
            return "NFU"
        }
        else if(name.hasPrefix("國立臺中科"))
        {
            return "NUTC"
        }
        else if(name.hasPrefix("國立勤益"))
        {
            return "NCUT"
        }
        else if(name.hasPrefix("國立高雄餐"))
        {
            return "NKUHT"
        }
        else if(name.hasPrefix("國立臺北護"))
        {
            return "NTUNHS"
        }
        else if(name.hasPrefix("國立屏東科"))
        {
            return "NPUST"
        }
        else if(name.hasPrefix("國立澎"))
        {
            return "NPU"
        }
        else if(name.hasPrefix("朝陽"))
        {
            return "CYUT"
        }
        else if(name.hasPrefix("明志"))
        {
            return "MCUT"
        }
        else if(name.hasPrefix("南臺"))
        {
            return "STUST"
        }
        else if(name.hasPrefix("致理"))
        {
            return "CLUT"
        }
        else if(name.hasPrefix("長庚科"))
        {
            return "CGUST"
        }
        else if(name.hasPrefix("元培"))
        {
            return "YPU"
        }
        else if(name.hasPrefix("中華醫"))
        {
            return "HWAI"
        }
        else if(name.hasPrefix("德明"))
        {
            return "TAKMING"
        }
        else if(name.hasPrefix("龍華"))
        {
            return "LHU"
        }
        else if(name.hasPrefix("臺南應"))
        {
            return "TUT"
        }
        else if(name.hasPrefix("大仁"))
        {
            return "TAJEN"
        }
        else if(name.hasPrefix("弘光"))
        {
            return "HKU"
        }
        else if(name.hasPrefix("明新"))
        {
            return "MUST"
        }
        else if(name.hasPrefix("嶺東"))
        {
            return "LTU"
        }
        else if(name.hasPrefix("醒吾"))
        {
            return "HWU"
        }
        else if(name.hasPrefix("慈濟科"))
        {
            return "TCUST"
        }
        else if(name.hasPrefix("中臺"))
        {
            return "CTUST"
        }
        else if(name.hasPrefix("修平"))
        {
            return "HUST"
        }
        else if(name.hasPrefix("崑山"))
        {
            return "KSU"
        }
        else if(name.hasPrefix("輔英"))
        {
            return "FYU"
        }
        else if(name.hasPrefix("臺北海"))
        {
            return "TUMT"
        }
        else if(name.hasPrefix("中華科"))
        {
            return "CUST"
        }
        else if(name.hasPrefix("南亞"))
        {
            return "NANTA"
        }
        else if(name.hasPrefix("亞東"))
        {
            return "AEUST"
        }
        else if(name.hasPrefix("正修"))
        {
            return "CSU"
        }
        else if(name.hasPrefix("高苑"))
        {
            return "KYU"
        }
        else if(name.hasPrefix("僑光"))
        {
            return "OCU"
        }
        else if(name.hasPrefix("東方"))
        {
            return "TF"
        }
        else if(name.hasPrefix("美和"))
        {
            return "MEIHO"
        }
        else if(name.hasPrefix("崇右"))
        {
            return "CUFA"
        }
        else if(name.hasPrefix("東南"))
        {
            return "TNU"
        }
        else if(name.hasPrefix("景文"))
        {
            return "JUST"
        }
        else if(name.hasPrefix("遠東"))
        {
            return "FEU"
        }
        else if(name.hasPrefix("育達"))
        {
            return "YDU"
        }
        else if(name.hasPrefix("敏實"))
        {
            return "MITUST"
        }
        else if(name.hasPrefix("臺北城"))
        {
            return "UCTP"
        }
        else if(name.hasPrefix("樹德"))
        {
            return "STU"
        }
        else if(name.hasPrefix("萬能"))
        {
            return "VNU"
        }
        else if(name.hasPrefix("健行"))
        {
            return "UCH"
        }
        else if(name.hasPrefix("建國"))
        {
            return "CTU"
        }
        else if(name.hasPrefix("宏國"))
        {
            return "HDUT"
        }
        else if(name.hasPrefix("華夏"))
        {
            return "HWH"
        }
        else if(name.hasPrefix("南開"))
        {
            return "NKUT"
        }
        else if(name.hasPrefix("中國科"))
        {
            return "CUTE"
        }
        else if(name.hasPrefix("中州"))
        {
            return "CCUT"
        }
        else if(name.hasPrefix("吳鳳"))
        {
            return "WFU"
        }
        else if(name.hasPrefix("聖約翰"))
        {
            return "SJU"
        }
        else if(name.hasPrefix("環球"))
        {
            return "TWU"
        }
        else if(name.hasPrefix("黎明"))
        {
            return "LIT"
        }
        else if(name.hasPrefix("和春"))
        {
            return "FOTECH"
        }
        else if(name.hasPrefix("大漢"))
        {
            return "DAHAN"
        }
        else if(name.hasPrefix("國立臺東專"))
        {
            return "NTC"
        }
        else if(name.hasPrefix("國立臺南護"))
        {
            return "NTIN"
        }
        else if(name.hasPrefix("耕莘"))
        {
            return "CTCN"
        }
        else if(name.hasPrefix("新生"))
        {
            return "HSC"
        }
        else if(name.hasPrefix("崇仁"))
        {
            return "CJC"
        }
        else if(name.hasPrefix("樹人"))
        {
            return "SZMC"
        }
        else if(name.hasPrefix("育英"))
        {
            return "YUHING"
        }
        else if(name.hasPrefix("仁德"))
        {
            return "SZMC"
        }
        else if(name.hasPrefix("慈惠"))
        {
            return "TZUHUI"
        }
        else if(name.hasPrefix("聖母"))
        {
            return "SMC"
        }
        else if(name.hasPrefix("敏惠"))
        {
            return "MHCHCM"
        }
        else if(name.hasPrefix("經國"))
        {
            return "SKU"
        }
        else if(name.hasPrefix("馬偕醫護"))
        {
            return "MKC"
        }
        else if(name.hasPrefix("中信"))
        {
            return "CTBC"
        }
        else
        {
            return "AppIcon"
        }
    }
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            Color(.prefer).ignoresSafeArea(.all)
            
            VStack(spacing: 0)
            {
                //MARK: ScoreChartView
                ScoreChartView(name: self.schoolName, score5000: self.score5000, score8000: self.score8000).padding(.top)
                
                Rectangle()
                    .fill(Color(.backBar))
                    .frame(height: 1)
                
                VStack(alignment: .center, spacing: 10)
                {
                    //MARK: 調整高度按鈕
                    Button(self.preferHeight==200 ? "最小化":"展開")
                    {
                        withAnimation(.smooth)
                        {
                            self.preferHeight=self.preferHeight==200 ? 50:200
                        }
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(.bottom, self.preferSchool.isEmpty && self.preferHeight==200 ? 10:0)
                    
                    if(self.preferHeight==200)
                    {
                        HStack
                        {
                            //MARK: 標題
                            Text("\(self.preferSchool.isEmpty ? "本豹還不瞭解你呢...":"喜歡的 \(self.preferSchool.count) 所大學")")
                                .bold()
                                .font(.title3)
                            
                            Spacer()
                            
                            //MARK: 學校操作按鈕
                            if(!self.preferSchool.isEmpty)
                            {
                                Button(self.showLogo ? "顯示校徽":"顯示校名")
                                {
                                    withAnimation(.easeInOut)
                                    {
                                        self.showLogo = !self.showLogo
                                    }
                                }
                                .font(.headline)
                                .foregroundStyle(.blue)
                                
                                Capsule()
                                    .fill(.gray)
                                    .frame(width: 1, height: 20)
                                
                                Button("清空")
                                {
                                    withAnimation(.easeInOut)
                                    {
                                        self.schoolName=""
                                        self.score5000=nil
                                        self.score8000=nil
                                        self.preferSchool=[]
                                    }
                                }
                                .font(.headline)
                                .foregroundStyle(.red)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, self.preferSchool.isEmpty ? 10:0)
                        
                        //MARK: 沒有推薦學校
                        if(self.preferSchool.isEmpty)
                        {
                            VStack(spacing: 20)
                            {
                                //MARK: PointView
                                Button
                                {
                                    withAnimation(.bouncy)
                                    {
                                        self.selection=3
                                    }
                                }
                                label:
                                {
                                    HStack(spacing: 50)
                                    {
                                        Text("我適合什麼學校？")
                                        
                                        Image(systemName: "arrow.right")
                                    }
                                    .foregroundStyle(.blue)
                                }
                                
                                //MARK: TestView
                                Button
                                {
                                    withAnimation(.bouncy)
                                    {
                                        self.selection=4
                                    }
                                }
                                label:
                                {
                                    HStack(spacing: 50)
                                    {
                                        Text("我適合什麼科系？")
                                        
                                        Image(systemName: "arrow.right")
                                    }
                                    .foregroundStyle(.blue)
                                }
                            }
                            .font(.title3)
                        }
                        //MARK: 有推薦學校
                        else
                        {
                            ScrollView(.horizontal, showsIndicators: false)
                            {
                                LazyHStack(alignment: .top)
                                {
                                    //依照興趣測驗及落點分析 顯示推薦學校的圖示
                                    ForEach(self.preferSchool.indices, id: \.self)
                                    {index in
                                        //選擇學校
                                        Button
                                        {
                                            //取得學校資訊
                                            let school=SchoolInformation(name: self.preferSchool[index], logo: self.preferSchool[index])
                                            //取得學校名字
                                            self.schoolName=school.name
                                            //取得學校甄試入學落點
                                            self.score5000=school.getScore5000()
                                            //取得學校登記分發落點
                                            self.score8000=school.getScore8000()
                                        }
                                        label:
                                        {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray.opacity(0.5))
                                                .scaledToFit()
                                                .frame(height: 120)
                                                //學校
                                                .overlay
                                                {
                                                    SchoolView(
                                                        showLogo: self.$showLogo,
                                                        school:
                                                            SchoolInformation(
                                                                name: self.preferSchool[index],
                                                                logo: self.getLogo(name: self.preferSchool[index])
                                                            )
                                                    )
                                                    .padding(5)
                                                }
                                                .overlay(.ultraThinMaterial.opacity(self.schoolName==self.preferSchool[index] ? 0.8:0))
                                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                                        }
                                        .disabled(self.schoolName==self.preferSchool[index])
                                    }
                                }
                                //讓學校邊框可以完整顯示
                                .padding(1)
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                }
                .frame(height: self.preferHeight)
                .padding(.vertical, self.preferHeight==200 ? 5:0)
            }
        }
    }
}
