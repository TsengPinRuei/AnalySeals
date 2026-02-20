//
//  SchoolData.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/20.
//

import Foundation

class School: ObservableObject
{
    @Published var degree: String
    @Published var city: String
    
    init(degree: String, city: String)
    {
        self.degree=degree
        self.city=city
    }
    
    //MARK: 一般大學
    func normalUniversity() -> [String]
    {
        return ["國立臺灣海洋大學", "國立臺北藝術大學", "國立臺北教育大學", "國立政治大學", "國立臺灣大學", "國立臺灣師範大學", "臺北市立大學", "銘傳大學", "實踐大學", "大同大學", "臺北醫學大學", "康寧大學", "東吳大學", "中國文化大學", "世新大學", "國立臺北大學", "國立臺灣藝術大學", "輔仁大學", "淡江大學", "華梵大學", "真理大學", "法鼓文理學院", "馬偕醫學院", "國立中央大學", "國立體育大學", "中原大學", "長庚大學", "元智大學", "開南大學", "國立清華大學", "國立陽明交通大學", "中華大學", "玄奘大學", "國立聯合大學", "國立中興大學", "國立臺中教育大學", "國立臺灣體育運動大學", "東海大學", "逢甲大學", "靜宜大學", "中山醫學大學", "中國醫藥大學", "亞洲大學", "國立暨南國際大學", "國立彰化師範大學", "大葉大學", "明道大學", "國立嘉義大學", "國立中正大學", "南華大學", "國立成功大學", "國立臺南藝術大學", "國立臺南大學", "臺灣首府大學", "中信金融管理學院", "長榮大學", "國立中山大學", "國立高雄師範大學", "國立高雄大學", "義守大學", "高雄醫學大學", "國立屏東大學", "國立宜蘭大學", "佛光大學", "國立東華大學", "慈濟大學", "國立臺東大學", "國立金門大學"]
    }
    //MARK: 科技大學
    func technologyUniversity() -> [String]
    {
        return ["中國科技大學", "國立臺北科技大學", "國立臺北商業大學", "國立臺北護理健康大學", "國立臺灣科技大學", "國立臺灣戲曲學院", "德明財經科技大學", "中華科技大學", "臺北城市科技大學", "景文科技大學", "東南科技大學", "華夏科技大學", "致理科技大學", "宏國德霖科技大學", "臺北海洋科技大學", "明志科技大學", "亞東科技大學", "黎明技術學院", "崇右影藝科技大學", "龍華科技大學", "健行科技大學", "萬能科技大學", "長庚科技大學", "明新科技大學", "聖約翰科技大學", "元培醫事科技大學", "敏實科技大學", "醒吾科技大學", "育達科技大學", "國立勤益科技大學", "國立臺中科技大學", "朝陽科技大學", "弘光科技大學", "嶺東科技大學", "中臺科技大學", "僑光科技大學", "修平科技大學", "建國科技大學", "中州科技大學", "南開科技大學", "國立雲林科技大學", "國立虎尾科技大學", "環球科技大學", "吳鳳科技大學", "南臺科技大學", "崑山科技大學", "嘉南藥理大學", "臺南應用科技大學", "遠東科技大學", "國立高雄科技大學", "國立高雄餐旅大學", "樹德科技大學", "輔英科技大學", "正修科技大學", "高苑科技大學", "文藻外語大學", "東方設計大學", "國立屏東科技大學", "大仁科技大學", "美和科技大學", "慈濟科技大學", "國立澎湖科技大學"]
    }
    //MARK: 選擇學校
    func setSchool() -> [String]
    {
        switch(self.degree)
        {
            case "高中":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "市立大同高中", "市立大直高中", "市立大理高中", "市立中山女中", "市立中正中學", "市立中崙高中", "市立內湖高中", "市立北一女中", "市立永春高中", "市立成功中學", "市立西松高中", "市立成淵高中", "市立百齡高中", "市立育成高中", "市立松山高中", "市立和平高中", "市立明倫高中", "市立建國中學", "市立南港高中", "市立南湖高中", "市立華江高中", "市立陽明高中", "市立景美女中", "市立復興高中", "市立萬芳高中", "市立麗山高中", "私立十信高中", "私立大同高中", "私立大誠高中", "私立文德女中", "私立中興中學", "私立方濟中學", "私立立人高中", "私立再興中學", "私立東山中學", "私立延平中學", "私立金甌女中", "私立泰北中學", "私立祐德中學", "私立強恕中學", "私立景文高中", "私立開平高中", "私立華興中學", "私立達人女中", "私立滬江中學", "私立衛理女中", "私立靜修女中", "私立薇閣高中", "國立師大附中"]
                    case "新北市":
                        return ["學校名稱", "私立及人高中", "私立中華高中", "私立光仁高中", "私立竹林高中", "私立東海高中", "私立金陵女中", "私立南山高中", "私立恆毅高中", "私立格致高中", "私立徐匯高中", "私立崇光高中", "私立淡江高中", "私立崇義高中", "私立聖心女中", "私立醒吾高中", "私立辭修高中", "國立三重高中", "國立中和高中", "國立林口高中", "國立板橋高中", "國立泰山高中", "國立華僑中學", "國立新店高中", "國立新莊高中", "縣立三民中學", "縣立三重中學", "縣立永平中學", "縣立石碇中學", "縣立安康中學", "縣立秀峰中學", "縣立金山中學", "縣立明德中學", "縣立海山中學", "縣立清水中學", "縣立樹林中學", "縣立錦和中學", "縣立雙溪中學", "樟樹實中"]
                    case "基隆市":
                        return ["學校名稱", "市立中山中學", "市立安樂高中", "市立暖暖高中", "私立二信高中", "私立聖心高中", "國立基隆女中", "國立基隆高中"]
                    case "桃園市":
                        return ["學校名稱", "私立大華高中", "私立大興高中", "私立六和高中", "私立光啟高中", "私立至善高中", "私立育達高中", "私立治平高中", "私立泉僑高中", "市立振聲高中", "市立啟英高中", "市立復旦高中", "市立新興高中", "國立中壢高中", "國立內壢高中", "國立武陵高中", "國立桃園高中", "國立陽明高中", "國立楊梅高中", "國立永豐高中", "國立平鎮高中", "縣立南崁中學"]
                    case "新竹市":
                        return ["學校名稱", "市立成德中學", "市立香山中學", "市立建功高中", "私立世界高中", "私立光復高中", "私立磐石高中", "私立曙光高中", "國立科學工業園區高中", "國立新竹女中", "國立新竹高中"]
                    case "新竹縣":
                        return ["學校名稱", "私立仰德高中", "私立忠信高中", "私立東泰高中", "私立義民高中", "國立竹北高中", "國立竹東高中", "縣立湖口中學"]
                    case "苗栗縣":
                        return ["學校名稱", "私立大成高中", "私立君毅高中", "私立建台高中", "國立竹南高中", "國立卓蘭實驗高中", "國立苗栗高中", "國立苑裡高中", "縣立苑裡高中", "縣立興華高中"]
                    case "臺中市":
                        return ["學校名稱", "大甲高中", "大明高中", "中科實中", "中港高中", "文華高中", "市立大里高中", "弘文高中", "玉山高中", "立人高中", "后綜高中", "西苑高中", "宜寧高中", "忠明高中", "明台高中", "明道中學", "明德女中", "東大附中", "東山高中", "長億高中", "青年高中", "致用高中", "國立大里高中", "常春藤高中", "清水高中", "國立興大附中", "惠文高中", "華盛頓中學", "慈明高中", "新民高中", "新社高中", "葳格高中", "僑泰高中", "嘉陽高中", "臺中一中", "臺中二中", "臺中女中", "衛道高中", "曉明女中", "嶺東中學", "豐原高中"]
                    case "彰化縣":
                        return ["學校名稱", "私立文興高中", "私立正德高中", "私立精誠高中", "國立員林高中", "國立鹿港高中", "國立溪湖高中", "國立彰化女中", "國立彰化高中", "縣立二林高中"]
                    case "南投縣":
                        return ["學校名稱", "私立五育高中", "國立中興高中", "國立竹山高中", "國立南投高中", "國立暨大附中", "縣立旭光高中"]
                    case "雲林縣":
                        return ["學校名稱", "私立文生高中", "私立正心高中", "私立永年高中", "私立宗聖高中", "私立崇先高中", "私立揚子高中", "私立義峰高中", "國立斗六高中", "國立北港高中", "國立虎尾高中", "縣立斗南高中", "縣立麥寮高中"]
                    case "嘉義市":
                        return ["學校名稱", "私立仁義高中", "私立宏仁女中", "私立輔仁高中", "私立嘉華高中", "私立興華高中", "國立嘉義女中", "國立嘉義高中"]
                    case "嘉義縣":
                        return ["學校名稱", "私立同濟高中", "私立協同高中", "私立協志高中", "私立明華高中", "國立東石高中"]
                    case "臺南市":
                        return ["學校名稱", "大灣中學", "私立六信高中", "私立光華女中", "私立明達高中", "私立長榮女中", "私立長榮高中", "私立建業高中", "私立南光高中", "私立崑山高中", "私立港明高中", "私立聖功女中", "私立德光女中", "私立瀛海高中", "國立臺南一中", "國立臺南二中", "國立臺南女中", "國立家齊女中", "私立華濟永安高中", "私立新榮高中", "私立鳳和高中", "私立黎明高中", "私立興國高中", "國立北門高中", "國立後壁高中", "國立善化高中", "國立新化高中", "國立新營高中", "國立新豐高中"]
                    case "高雄市":
                        return ["學校名稱", "市立三民高中", "市立小港高中", "市立中山高中", "市立中正高中", "市立左營高中", "市立前鎮高中", "市立高雄女中", "市立高雄中學", "市立鼓山中學", "市立新莊高中", "市立瑞祥高中", "市立新興高中", "私立大榮高中", "私立立志高中", "私立明誠中學", "私立國光高中", "私立復華高中", "私立道明中學", "國立高師附中", "中正國防幹部預備學校", "私立正義高中", "私立普門高中", "私立樂育高中", "國立岡山高中", "國立鳳山高中", "國立旗美高中", "國立鳳新高中", "縣立文山高中", "縣立仁武中學", "縣立六龜高中", "縣立林園中學", "縣立路竹中學", "縣立福誠中學"]
                    case "屏東縣":
                        return ["學校名稱", "私立美和高中", "私立陸興高中", "私立新基高中", "國立屏東女中", "國立屏東高中", "國立潮州高中", "縣立大同中學", "縣立來義高中", "縣立枋寮中學"]
                    case "宜蘭縣":
                        return ["學校名稱", "私立中道高中", "私立慧燈高中", "國立宜蘭高中", "國立羅東高中", "國立蘭陽女中"]
                    case "花蓮縣":
                        return ["學校名稱", "私立四維高中", "私立海星高中", "縣立體育實驗高中", "國立玉里高中", "國立花蓮女中", "國立花蓮高中", "慈大附中"]
                    case "臺東縣":
                        return ["學校名稱", "私立育仁高中", "國立臺東女中", "國立臺東高中", "國立臺東體育實驗高中", "縣立蘭嶼中學"]
                    case "金門縣":
                        return ["學校名稱", "國立金門高中"]
                    case "連江縣":
                        return ["學校名稱", "國立馬祖高中"]
                    case "澎湖縣":
                        return ["學校名稱", "國立馬公高中"]
                    default:
                        return ["學校名稱"]
                }
            case "高職":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "私立開南商工", "私立東方工商", "市立大安高工", "私立育達家商", "市立士林高商", "市立松山工農", "私立開平餐飲", "私立喬治工商", "市立松山家商", "私立稻江高商", "私立惇敘工商", "私立稻護家", "私立華岡藝校", "市立南港高工", "市立木柵高工", "市立內湖高工", "私立志仁高中進校"]
                    case "新北市":
                        return ["學校名稱", "市立瑞芳高工", "私立復興商工", "私立開明工商", "私立智光商工", "私立清傳高商", "私立莊敬家商", "私立穀保家商", "私立豫章高工", "市立三重高商", "私立南強工商", "私立中華商海", "私立能仁家商", "市立新北高工", "市立淡水商工", "私立樹人家商", "市立鶯歌工商"]
                    case "基隆市":
                        return ["學校名稱", "國立基隆高商", "國立海大附中", "私立光榮家商", "私立培德工家"]
                    case "桃園市":
                        return ["學校名稱", "國立北科附工", "市立中壢高商", "市立中壢家商", "私立成功工商", "私立方曙商工", "私立永平工商"]
                    case "新竹市":
                        return ["學校名稱", "國立新竹高商", "國立新竹高工", "私立世界高中"]
                    case "新竹縣":
                        return ["學校名稱", "國立關西高中", "私立內思高工"]
                    case "苗栗縣":
                        return ["學校名稱", "國立大湖農工", "國立苗栗高商", "國立苗栗農工", "私立中興商工", "私立育民工家", "私立賢德工商", "私立龍德家商"]
                    case "臺中市":
                        return ["學校名稱", "國立興大附農", "市立臺中高工", "私立光華高工", "市立臺中家商", "市立豐原高商", "市立東勢高工", "市立霧峰農工", "市立沙鹿高工", "市立大甲高工", "私立慈明高中", "市立神岡高工"]
                    case "彰化縣":
                        return ["學校名稱", "國立彰師大附工", "國立彰化高商", "國立員林農工", "國立二林高商", "國立秀水高工", "國立員林家商", "私立大慶商工", "私立達德商工", "國立永靖高工", "國立崇實高工", "國立北斗家商"]
                    case "南投縣":
                        return ["學校名稱", "國立草屯高商", "國立南投高職", "國立仁愛高農", "國立埔里高工", "私立同德家商", "國立水里商工"]
                    case "雲林縣":
                        return ["學校名稱", "國立虎尾農工", "國立斗六家商", "國立北港農工", "國立西螺農工", "私立大成商工", "國立土庫商工", "私立大德工商"]
                    case "嘉義市":
                        return ["學校名稱", "國立嘉義高工", "國立嘉義家商", "國立嘉義高商", "國立華南高商", "私立東吳工家"]
                    case "嘉義縣":
                        return ["學校名稱", "私立萬能高工", "國立民雄農工"]
                    case "臺南市":
                        return ["學校名稱", "私立南英商工", "國立臺南高工", "國立臺南高商", "國立臺南海事", "國立曾文農工", "國立新化高工", "國立白河商工", "國立曾文家商", "國立新營高工", "國立北門農工", "私立慈幼工商", "私立陽明工商", "私立育德工家", "私立亞洲高餐", "國立玉井工商", "國立成大附工"]
                    case "高雄市":
                        return ["學校名稱", "市立中正高工", "市立高雄高商", "市立高雄高工", "國立岡山農工", "國立旗山農工", "私立三信家商", "國立鳳山商工", "私立旗美商工", "私立高英工商", "私立華德工家", "私立高苑工商", "市立海青工商", "私立中山工商", "私立樹德家商", "市立三民家商", "私立中華藝校", "國立高餐附中"]
                    case "屏東縣":
                        return ["學校名稱", "國立屏東高工", "國立內埔農工", "國立佳冬高農", "國立東港海事", "私立日新工商", "私立民生家商", "國立恆春工商"]
                    case "宜蘭縣":
                        return ["學校名稱", "國立宜蘭高商", "國立蘇澳海事", "國立羅東高工", "國立羅東高商", "國立頭城家商"]
                    case "花蓮縣":
                        return ["學校名稱", "國立花蓮高農", "國立花蓮高工", "國立花蓮高商", "私立上騰高中", "國立光復高商"]
                    case "臺東縣":
                        return ["學校名稱", "私立公東高工", "國立關山高商", "國立臺東高商", "國立成功商水"]
                    case "金門縣":
                        return ["學校名稱", "國立金門農工"]
                    case "澎湖縣":
                        return ["學校名稱", "國立澎湖海事"]
                    default:
                        return ["學校名稱"]
                }
            case "專科學校":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "馬偕醫護專"]
                    case "新北市":
                        return ["學校名稱", "黎明技術學院", "耕莘護專", "臺灣警專"]
                    case "基隆市":
                        return ["學校名稱", "經國管理暨健康學院"]
                    case "桃園市":
                        return ["學校名稱", "南亞技術學院", "新生護專", "陸軍專校"]
                    case "苗栗縣":
                        return ["學校名稱", "仁德護專"]
                    case "嘉義市":
                        return ["學校名稱", "大同技術學院", "崇仁護專"]
                    case "嘉義縣":
                        return ["學校名稱"]
                    case "臺南市":
                        return ["學校名稱", "國立臺南護專", "敏惠護專"]
                    case "高雄市":
                        return ["學校名稱", "和春技術學院", "育英護專", "空軍航空技術學院", "樹人護專"]
                    case "屏東縣":
                        return ["學校名稱", "慈惠護專"]
                    case "宜蘭縣":
                        return ["學校名稱", "聖母護專"]
                    case "花蓮縣":
                        return ["學校名稱", "大漢技術學院"]
                    case "臺東縣":
                        return ["學校名稱", "國立臺東專校"]
                    default:
                        return ["學校名稱"]
                }
            case "普通大學":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "國立臺北藝術大學","國立臺北教育大學", "國立政治大學", "國立臺灣大學", "國立臺灣師範大學", "臺北市立大學", "銘傳大學", "實踐大學", "大同大學", "臺北醫學大學", "康寧大學", "東吳大學", "中國文化大學", "世新大學"]
                    case "新北市":
                        return ["學校名稱", "國立臺北大學", "國立臺灣藝術大學", "輔仁大學", "淡江大學"]
                    case "基隆市":
                        return ["學校名稱", "國立臺灣海洋大學", "華梵大學", "真理大學", "法鼓文理學院", "馬偕醫學院"]
                    case "桃園市":
                        return ["學校名稱", "國立中央大學", "國立體育大學", "中原大學", "長庚大學", "元智大學", "開南大學"]
                    case "新竹市":
                        return ["學校名稱", "國立清華大學", "國立陽明交通大學", "中華大學", "玄奘大學"]
                    case "苗栗縣":
                        return ["學校名稱", "國立聯合大學"]
                    case "臺中市":
                        return ["學校名稱", "國立中興大學", "國立臺中教育大學", "國立臺灣體育運動大學", "東海大學", "逢甲大學", "靜宜大學", "中山醫學大學", "中國醫藥大學", "亞洲大學"]
                    case "彰化縣":
                        return ["學校名稱", "國立彰化師範大學", "大葉大學", "明道大學"]
                    case "南投縣":
                        return ["學校名稱", "國立暨南國際大學"]
                    case "嘉義市":
                        return ["學校名稱", "國立嘉義大學"]
                    case "嘉義縣":
                        return ["學校名稱", "國立中正大學", "南華大學"]
                    case "臺南市":
                        return ["學校名稱", "國立成功大學", "國立臺南藝術大學", "國立臺南大學", "臺灣首府大學", "中信金融管理學院", "長榮大學"]
                    case "高雄市":
                        return ["學校名稱", "國立中山大學", "國立高雄大學", "國立高雄師範大學", "義守大學", "高雄醫學大學"]
                    case "屏東縣":
                        return ["學校名稱", "國立屏東大學"]
                    case "宜蘭縣":
                        return ["學校名稱", "國立宜蘭大學", "佛光大學"]
                    case "花蓮縣":
                        return ["學校名稱", "國立東華大學", "慈濟大學"]
                    case "臺東縣":
                        return ["學校名稱", "國立臺東大學"]
                    case "金門縣":
                        return ["學校名稱", "國立金門大學"]
                    default:
                        return ["學校名稱"]
                }
            case "科技大學":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "中國科技大學", "國立臺北科技大學", "國立臺北商業大學", "國立臺北護理健康大學", "國立臺灣科技大學", "國立臺灣戲曲學院", "德明財經科技大學", "中華科技大學", "臺北城市科技大學"]
                    case "新北市":
                        return ["學校名稱", "明志科技大學", "景文科技大學", "東南科技大學", "華夏科技大學", "致理科技大學", "宏國德霖科技大學", "臺北海洋科技大學", "亞東科技大學", "黎明技術學院"]
                    case "基隆市":
                        return ["學校名稱", "崇右影藝科技大學"]
                    case "桃園市":
                        return ["學校名稱", "龍華科技大學", "健行科技大學", "萬能科技大學", "長庚科技大學"]
                    case "新竹市":
                        return ["學校名稱", "明新科技大學", "聖約翰科技大學", "元培醫事科技大學", "敏實科技大學", "醒吾科技大學"]
                    case "苗栗縣":
                        return ["學校名稱", "育達科技大學"]
                    case "臺中市":
                        return ["學校名稱", "國立勤益科技大學", "國立臺中科技大學", "朝陽科技大學", "弘光科技大學", "嶺東科技大學", "中臺科技大學", "僑光科技大學", "修平科技大學"]
                    case "彰化縣":
                        return ["學校名稱", "建國科技大學", "中州科技大學"]
                    case "南投縣":
                        return ["學校名稱", "南開科技大學"]
                    case "雲林縣":
                        return ["學校名稱", "國立雲林科技大學", "國立虎尾科技大學", "環球科技大學"]
                    case "嘉義縣":
                        return ["學校名稱", "吳鳳科技大學"]
                    case "臺南市":
                        return ["學校名稱", "中華醫事科技大學", "南臺科技大學", "崑山科技大學", "嘉南藥理大學", "臺南應用科技大學", "遠東科技大學"]
                    case "高雄市":
                        return ["學校名稱", "國立高雄科技大學", "國立高雄餐旅大學", "樹德科技大學", "輔英科技大學", "正修科技大學", "高苑科技大學", "文藻外語大學", "東方設計大學"]
                    case "屏東縣":
                        return ["學校名稱", "國立屏東科技大學", "大仁科技大學", "美和科技大學"]
                    case "花蓮縣":
                        return ["學校名稱", "慈濟科技大學"]
                    case "澎湖縣":
                        return ["學校名稱", "國立澎湖科技大學"]
                    default:
                        return ["學校名稱"]
                }
            case "空中大學":
                switch(self.city)
                {
                    case "臺北市":
                        return ["學校名稱", "臺北學習指導中心"]
                    case "新北市":
                        return ["學校名稱", "國立空中大學"]
                    case "基隆市":
                        return ["學校名稱", "基隆學習指導中心"]
                    case "桃園市":
                        return ["學校名稱", "桃園學習指導中心"]
                    case "新竹市":
                        return ["學校名稱", "新竹學習指導中心"]
                    case "苗栗縣":
                        return ["學校名稱", "苗栗服務處"]
                    case "臺中市":
                        return ["學校名稱", "臺中學習指導中心"]
                    case "彰化縣":
                        return ["學校名稱", "彰化服務處"]
                    case "南投縣":
                        return ["學校名稱", "南投服務處"]
                    case "雲林縣":
                        return ["學校名稱", "雲林服務處"]
                    case "嘉義市":
                        return ["學校名稱", "嘉義學習指導中心"]
                    case "臺南市":
                        return ["學校名稱", "臺南學習指導中心"]
                    case "高雄市":
                        return ["學校名稱", "高雄學習指導中心"]
                    case "屏東縣":
                        return ["學校名稱", "屏東服務處"]
                    case "宜蘭縣":
                        return ["學校名稱", "宜蘭學習指導中心"]
                    case "花蓮縣":
                        return ["學校名稱", "花蓮學習指導中心", "國立空中大學壽豐校區"]
                    case "臺東縣":
                        return ["學校名稱", "臺東學習指導中心"]
                    case "金門縣":
                        return ["學校名稱", "金門學習指導中心"]
                    case "連江縣":
                        return ["學校名稱", "馬祖服務處"]
                    case "澎湖縣":
                        return ["學校名稱", "澎湖學習指導中心"]
                    default:
                        return ["學校名稱"]
                }
            default:
                return ["學校名稱"]
        }
    }
    //MARK: 一般大學連結
    func setNormalUniversityLink(school: String) -> String
    {
        switch(school)
        {
        case "國立臺灣海洋大學":
            return "https://www.ntou.edu.tw/"
        case "國立臺北藝術大學":
            return "https://w3.tnua.edu.tw/"
        case "國立臺北教育大學":
            return "https://www.ntue.edu.tw/"
        case "國立政治大學":
            return "https://www.nccu.edu.tw/"
        case "國立臺灣大學":
            return "https://www.ntu.edu.tw/"
        case "國立臺灣師範大學":
            return "https://www.ntnu.edu.tw/"
        case "臺北市立大學":
            return "https://www.utaipei.edu.tw/"
        case "銘傳大學":
            return "https://web.mcu.edu.tw/"
        case "實踐大學":
            return "https://www.usc.edu.tw/"
        case "大同大學":
            return "https://www.ttu.edu.tw/"
        case "臺北醫學大學":
            return "https://www.tmu.edu.tw/"
        case "康寧大學":
            return "https://www.ukn.edu.tw/"
        case "東吳大學":
            return "http://www.scu.edu.tw/"
        case "中國文化大學":
            return "https://www.pccu.edu.tw/"
        case "世新大學":
            return "https://www.shu.edu.tw/"
        case "國立臺北大學":
            return "https://new.ntpu.edu.tw/"
        case "國立臺灣藝術大學":
            return "https://www.ntua.edu.tw/"
        case "輔仁大學":
            return "https://www.fju.edu.tw/"
        case "淡江大學":
            return "https://www.tku.edu.tw/"
        case "華梵大學":
            return "https://www.hfu.edu.tw/"
        case "真理大學":
            return "https://www.au.edu.tw/"
        case "法鼓文理學院":
            return "https://www.dila.edu.tw/"
        case "馬偕醫學院":
            return "https://www.mmc.edu.tw/"
        case "國立中央大學":
            return "https://www.ncu.edu.tw/"
        case "國立體育大學":
            return "https://www.ntsu.edu.tw/"
        case "中原大學":
            return "https://www1.cycu.edu.tw/"
        case "長庚大學":
            return "https://www.cgu.edu.tw/"
        case "元智大學":
            return "https://www.yzu.edu.tw/"
        case "開南大學":
            return "https://www.knu.edu.tw/"
        case "國立清華大學":
            return "https://www.nthu.edu.tw/"
        case "國立陽明交通大學":
            return "https://www.nycu.edu.tw/"
        case "中華大學":
            return "https://www.chu.edu.tw/"
        case "玄奘大學":
            return "https://www.hcu.edu.tw/"
        case "國立聯合大學":
            return "https://www.nuu.edu.tw/"
        case "國立中興大學":
            return "https://www.nchu.edu.tw/"
        case "國立臺中教育大學":
            return "https://www.ntcu.edu.tw/"
        case "國立臺灣體育運動大學":
            return "https://www.ntus.edu.tw/"
        case "東海大學":
            return "https://www.thu.edu.tw/"
        case "逢甲大學":
            return "https://www.fcu.edu.tw/"
        case "靜宜大學":
            return "https://www.pu.edu.tw/"
        case "中山醫學大學":
            return "https://www.csmu.edu.tw/"
        case "中國醫藥大學":
            return "https://www.cmu.edu.tw/"
        case "亞洲大學":
            return "https://www.asia.edu.tw/"
        case "國立暨南國際大學":
            return "https://www.ncnu.edu.tw/"
        case "國立彰化師範大學":
            return "https://www.ncue.edu.tw/"
        case "大葉大學":
            return "https://www.dyu.edu.tw/"
        case "明道大學":
            return "https://www.mdu.edu.tw/"
        case "國立嘉義大學":
            return "https://www.ncyu.edu.tw/"
        case "國立中正大學":
            return "https://www.ccu.edu.tw/"
        case "南華大學":
            return "https://web.nhu.edu.tw/"
        case "國立成功大學":
            return "https://www.ncku.edu.tw/"
        case "國立臺南藝術大學":
            return "https://www.tnnua.edu.tw/"
        case "國立臺南大學":
            return "https://www.nutn.edu.tw/"
        case "臺灣首府大學":
            return "https://web.tsu.edu.tw/"
        case "中信金融管理學院":
            return "https://www.ctbc.edu.tw/"
        case "長榮大學":
            return "https://www.cjcu.edu.tw/"
        case "國立中山大學":
            return "https://www.nsysu.edu.tw/"
        case "高雄師範大學":
            return "https://w3.nknu.edu.tw/"
        case "國立高雄大學":
            return "https://www.nuk.edu.tw/"
        case "義守大學":
            return "https://www.isu.edu.tw/"
        case "高雄醫學大學":
            return "https://www.kmu.edu.tw/"
        case "國立屏東大學":
            return "https://www.nptu.edu.tw/"
        case "國立宜蘭大學":
            return "https://www.niu.edu.tw/"
        case "佛光大學":
            return "https://website.fgu.edu.tw/"
        case "國立東華大學":
            return "https://www.ndhu.edu.tw/"
        case "慈濟大學":
            return "https://www.tcu.edu.tw/"
        case "國立臺東大學":
            return "https://www.nttu.edu.tw/"
        case "國立金門大學":
            return "https://www.nqu.edu.tw/"
        default:
            return "https://www.google.com"
        }
    }
    //MARK: 科技大學連結
    func setTechnologyUniversityLink(school: String) -> String
    {
        switch(school)
        {
            case "中國科技大學":
                return "https://www.cute.edu.tw"
            case "中州科技大學":
                return "https://www.ccut.edu.tw"
            case "中臺科技大學":
                return "https://www.ctust.edu.tw"
            case "中華科技大學":
                return "https://www.cust.edu.tw"
            case "亞東科技大學":
                return "https://www.aeust.edu.tw"
            case "修平科技大學":
                return "https://www.hust.edu.tw"
            case "健行科技大學":
                return "https://www.uch.edu.tw"
            case "僑光科技大學":
                return "https://www.ocu.edu.tw"
            case "元培醫事科技大學":
                return "https://www.ypu.edu.tw"
            case "南臺科技大學":
                return "https://www.stust.edu.tw"
            case "南開科技大學":
                return "https://www.nkut.edu.tw"
            case "吳鳳科技大學":
                return "http://www.wfu.edu.tw"
            case "嘉南藥理大學":
                return "https://www.cnu.edu.tw"
            case "國立勤益科技大學":
                return "https://www.ncut.edu.tw"
            case "國立屏東科技大學":
                return "https://wp.npust.edu.tw"
            case "國立澎湖科技大學":
                return "https://www.npu.edu.tw"
            case "國立臺中科技大學":
                return "https://www.nutc.edu.tw"
            case "國立臺北商業大學":
                return "https://www.ntub.edu.tw"
            case "國立臺北科技大學":
                return "https://www.ntut.edu.tw"
            case "國立臺北護理健康大學":
                return "https://www.ntunhs.edu.tw"
            case "國立臺灣戲曲學院":
                return "https://www.tcpa.edu.tw"
            case "國立臺灣科技大學":
                return "https://www.ntust.edu.tw"
            case "國立虎尾科技大學":
                return "https://www.nfu.edu.tw"
            case "國立雲林科技大學":
                return "https://www.yuntech.edu.tw"
            case "國立高雄科技大學":
                return "https://www.nkust.edu.tw"
            case "國立高雄餐旅大學":
                return "https://www.nkuht.edu.tw"
            case "大仁科技大學":
                return "https://www.tajen.edu.tw"
            case "宏國德霖科技大學":
                return "https://www.hdut.edu.tw"
            case "崇右影藝科技大學":
                return "https://www.cufa.edu.tw"
            case "崑山科技大學":
                return "https://www.ksu.edu.tw"
            case "嶺東科技大學":
                return "https://www.ltu.edu.tw"
            case "建國科技大學":
                return "https://www.ctu.edu.tw"
            case "弘光科技大學":
                return "https://www.hk.edu.tw"
            case "德明財經科技大學":
                return "https://www.takming.edu.tw"
            case "慈濟科技大學":
                return "https://www.tcust.edu.tw"
            case "敏實科技大學":
                return "https://www.mitust.edu.tw"
            case "文藻外語大學":
                return "https://b002.wzu.edu.tw"
            case "明志科技大學":
                return "https://www.mcut.edu.tw"
            case "明新科技大學":
                return "https://www.must.edu.tw"
            case "景文科技大學":
                return "https://www.just.edu.tw"
            case "朝陽科技大學":
                return "https://web.cyut.edu.tw"
            case "東南科技大學":
                return "https://www.tnu.edu.tw"
            case "東方設計大學":
                return "https://www.tf.edu.tw"
            case "樹德科技大學":
                return "https://www.stu.edu.tw"
            case "正修科技大學":
                return "https://www.csu.edu.tw"
            case "環球科技大學":
                return "https://www.twu.edu.tw"
            case "美和科技大學":
                return "https://www.meiho.edu.tw"
            case "聖約翰科技大學":
                return "https://www.sju.edu.tw/index.aspx"
            case "育達科技大學":
                return "https://www.ydu.edu.tw"
            case "致理科技大學":
                return "https://www.chihlee.edu.tw"
            case "臺北城市科技大學":
                return "https://www.tpcu.edu.tw"
            case "臺南應用科技大學":
                return "https://www.tut.edu.tw"
            case "華夏科技大學":
                return "https://www.hwh.edu.tw"
            case "萬能科技大學":
                return "https://www.vnu.edu.tw/zh"
            case "輔英科技大學":
                return "https://www.fy.edu.tw"
            case "遠東科技大學":
                return "http://www.feu.edu.tw"
            case "醒吾科技大學":
                return "https://www.hwu.edu.tw"
            case "長庚科技大學":
                return "https://www.cgust.edu.tw"
            case "高苑科技大學":
                return "https://www.kyu.edu.tw"
            case "黎明技術學院":
                return "https://www.lit.edu.tw"
            case "龍華科技大學":
                return "https://www.lhu.edu.tw"
            default:
                return "https://www.google.com"
        }
    }
}
