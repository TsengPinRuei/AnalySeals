//
//  SchoolInformation.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/5/2.
//

import Foundation

struct SchoolInformation
{
    let name: String
    let logo: String
    
    //MARK: 甄試入學(01 02 17 18 19 20 21)
    //相同科系 -> 取分數高的類群
    func getScore5000() -> [ChartScore]
    {
        switch(self.name) {
        case "國立清華大學\n動力機械工程學系":
            return [ChartScore(score: 70, year: 109), ChartScore(score: 71, year: 110), ChartScore(score: 70, year: 111)]
        case "國立臺灣師範大學\n車輛與能源工程學士學位學程":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 66, year: 110), ChartScore(score: 63, year: 111)]
        case "國立臺灣師範大學\n工業教育學系":
            return [ChartScore(score: 59, year: 109), ChartScore(score: 62, year: 110), ChartScore(score: 58, year: 111)]
        case "國立臺灣海洋大學\n水產養殖學系":
            return [ChartScore(score: 29, year: 109), ChartScore(score: 45, year: 110), ChartScore(score: 29, year: 111)]
        case "國立臺灣海洋大學\n商船學系":
            return [ChartScore(title: "數學", score: 5, year: 109), ChartScore(title: "數學", score: 7, year: 110), ChartScore(title: "數學", score: 5, year: 111)]
        case "國立彰化師範大學\n工業教育與技術學系":
            return [ChartScore(score: 44, year: 110)]
        case "國立東華大學\n自然資源與環境學系":
            return [ChartScore(score: 38, year: 109), ChartScore(score: 44, year: 110), ChartScore(score: 31, year: 111)]
        case "國立嘉義大學\n水生生物科學系":
            return [ChartScore(score: 51, year: 109), ChartScore(score: 30, year: 110)]
        case "國立屏東大學\n智慧機器人學系":
            return [ChartScore(score: 39, year: 109), ChartScore(score: 44, year: 110), ChartScore(score: 46, year: 111)]
        case "國立屏東大學\n休閒事業經營學系":
            return [ChartScore(score: 57, year: 109), ChartScore(score: 56, year: 110), ChartScore(score: 56, year: 111)]
        case "國立屏東大學\n休閒運動健康系":
            return [ChartScore(score: 60, year: 109), ChartScore(score: 59, year: 110), ChartScore(score: 58, year: 111)]
        case "國立金門大學\n海洋與邊境管理學系":
            return [ChartScore(title: "國文＋英文＋數學＋專業科目一＋專業科目二＋總級分", score: 94, year: 109), ChartScore(title: "國文＋英文＋數學＋專業科目一＋專業科目二＋總級分", score: 56, year: 110), ChartScore(title: "國文＋英文＋數學＋專業科目一＋專業科目二＋總級分", score: 84, year: 111)]
        case "逢甲大學\n工業工程與系統管理學系":
            return [ChartScore(score: 45, year: 111)]
        case "中原大學\n國際經營與貿易學系":
            return [ChartScore(score: 48, year: 111)]
        case "文藻外語大學\n傳播藝術系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 27, year: 110), ChartScore(score: 32, year: 111)]
        case "嘉南藥理大學\n公共安全及消防系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 29, year: 111)]
        case "嘉南藥理大學\n休閒保健管理系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 25, year: 111)]
        case "嘉南藥理大學\n社會工作系":
            return [ChartScore(score: 23, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 23, year: 111)]
        case "實踐大學 臺北校區\n資訊科技與管理學系":
            return [ChartScore(score: 47, year: 109), ChartScore(score: 48, year: 110), ChartScore(score: 44, year: 111)]
        case "實踐大學 高雄校區\n休閒產業管理學系":
            return [ChartScore(title: "國文＋專業科目一", score: 14, year: 109), ChartScore(title: "國文", score: 6, year: 110), ChartScore(title: "國文＋專業科目一", score: 16, year: 111)]
        case "義守大學\n大眾傳播學系":
            return [ChartScore(score: 40, year: 109), ChartScore(score: 39, year: 110), ChartScore(score: 43, year: 111)]
        case "靜宜大學\n大眾傳播學系":
            return [ChartScore(title: "英文＋專業科目一＋專業科目二", score: 38, year: 109), ChartScore(title: "英文＋專業科目一＋專業科目二", score: 35, year: 110), ChartScore(title: "英文＋專業科目一＋專業科目二", score: 35, year: 111)]
        case "長榮大學\n航運管理學系":
            return [ChartScore(title: "國文＋英文", score: 18, year: 109), ChartScore(title: "國文＋英文", score: 10, year: 110), ChartScore(title: "國文＋英文", score: 15, year: 111)]
        case "亞洲大學\n資訊傳播學系":
            return [ChartScore(score: 43, year: 109), ChartScore(score: 43, year: 110), ChartScore(score: 43, year: 111)]
        case "亞洲大學\n食品營養與保健生技學系食品營養組":
            return [ChartScore(score: 45, year: 109), ChartScore(score: 49, year: 110), ChartScore(score: 48, year: 111)]
        case "亞洲大學\n休閒與遊憩管理學系":
            return [ChartScore(score: 44, year: 109), ChartScore(score: 50, year: 110), ChartScore(score: 46, year: 111)]
        case "開南大學\n國際物流與運輸管理學系":
            return [ChartScore(score: 29, year: 111)]
        case "玄奘大學\n大眾傳播學系":
            return [ChartScore(score: 27, year: 109), ChartScore(score: 27, year: 110), ChartScore(score: 36, year: 111)]
        case "大葉大學\n工業設計學系":
            return [ChartScore(score: 29, year: 109), ChartScore(score: 28, year: 110), ChartScore(score: 22, year: 111)]
        case "國立體育大學\n休閒產業經營學系":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 61, year: 110), ChartScore(score: 58, year: 111)]
        case "國立臺灣科技大學\n材料科學與工程系":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 62, year: 110), ChartScore(score: 66, year: 111)]
        case "國立臺灣科技大學\n企業管理系":
            return [ChartScore(score: 69, year: 109), ChartScore(score: 68, year: 110), ChartScore(score: 68, year: 111)]
        case "國立臺灣科技大學\n資訊管理系":
            return [ChartScore(score: 69, year: 109), ChartScore(score: 70, year: 110), ChartScore(score: 69, year: 111)]
        case "國立臺北科技大學\n車輛工程系":
            return [ChartScore(score: 59, year: 111), ChartScore(score: 62, year: 111), ChartScore(score: 58, year: 111)]
        case "國立臺北科技大學\n材料及資源工程系材料組":
            return [ChartScore(score: 55, year: 109), ChartScore(score: 61, year: 110), ChartScore(score: 58, year: 111)]
        case "國立臺北科技大學\n材料及資源工程系資源組":
            return [ChartScore(score: 57, year: 109), ChartScore(score: 57, year: 110), ChartScore(score: 58, year: 111)]
        case "國立臺北科技大學\n工業工程與管理系":
            return [ChartScore(score: 58, year: 109), ChartScore(score: 56, year: 110), ChartScore(score: 56, year: 111)]
        case "國立臺北科技大學\n文化事業發展系":
            return [ChartScore(score: 62, year: 109), ChartScore(score: 59, year: 110), ChartScore(score: 59, year: 111)]
        case "國立臺北科技大學\n能源與冷凍空調工程系":
            return [ChartScore(score: 46, year: 111)]
        case "國立臺北商業大學 桃園校區\n創意科技與產品設計系":
            return [ChartScore(score: 42, year: 109), ChartScore(score: 49, year: 110), ChartScore(score: 52, year: 111)]
        case "國立雲林科技大學\n工業工程與管理系":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 63, year: 110), ChartScore(score: 61, year: 111)]
        case "國立雲林科技大學\n工業設計系":
            return [ChartScore(score: 56, year: 109), ChartScore(score: 59, year: 110), ChartScore(score: 56, year: 111)]
        case "國立雲林科技大學\n企業管理系":
            return [ChartScore(score: 64, year: 109), ChartScore(score: 64, year: 110), ChartScore(score: 63, year: 111)]
        case "國立雲林科技大學\n財務金融系":
            return [ChartScore(score: 66, year: 109), ChartScore(score: 67, year: 110), ChartScore(score: 65, year: 111)]
        case "國立雲林科技大學\n會計系":
            return [ChartScore(score: 65, year: 109), ChartScore(score: 65, year: 110), ChartScore(score: 63, year: 111)]
        case "國立雲林科技大學\n國際管理學士學位學程":
            return [ChartScore(score: 64, year: 109), ChartScore(score: 64, year: 110), ChartScore(score: 62, year: 111)]
        case "國立雲林科技大學\n應用外語系":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 62, year: 110), ChartScore(score: 60, year: 111)]
        case "國立雲林科技大學\n文化資產維護系":
            return [ChartScore(score: 57, year: 109), ChartScore(score: 57, year: 110), ChartScore(score: 54, year: 111)]
        case "國立高雄科技大學\n水產養殖系":
            return [ChartScore(score: 25, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 14, year: 111)]
        case "國立高雄科技大學\n海事資訊科技系":
            return [ChartScore(score: 35, year: 109), ChartScore(score: 44, year: 110), ChartScore(score: 35, year: 111)]
        case "國立高雄科技大學\n航運技術系":
            return [ChartScore(score: 40, year: 109), ChartScore(score: 48, year: 110), ChartScore(score: 46, year: 111)]
        case "國立高雄科技大學\n工業工程與管理系":
            return [ChartScore(score: 52, year: 109), ChartScore(score: 53, year: 110), ChartScore(score: 52, year: 111)]
        case "國立高雄科技大學\n工業設計系":
            return [ChartScore(score: 55, year: 109), ChartScore(score: 54, year: 110), ChartScore(score: 55, year: 111)]
        case "國立高雄科技大學\n高瞻科技不分系學士學位學程":
            return [ChartScore(score: 31, year: 110), ChartScore(score: 43, year: 111)]
        case "國立高雄科技大學\n智慧商務系":
            return [ChartScore(score: 56, year: 109), ChartScore(score: 33, year: 110), ChartScore(score: 46, year: 111)]
        case "國立高雄科技大學\n造船及海洋工程系":
            return [ChartScore(score: 49, year: 109), ChartScore(score: 43, year: 110), ChartScore(score: 47, year: 111)]
        case "國立高雄科技大學\n金融資訊系":
            return [ChartScore(score: 58, year: 109), ChartScore(score: 59, year: 110), ChartScore(score: 58, year: 111)]
        case "國立高雄科技大學\n風險管理與保險系":
            return [ChartScore(score: 44, year: 109), ChartScore(score: 56, year: 110), ChartScore(score: 54, year: 111)]
        case "國立高雄科技大學\n企業管理系":
            return [ChartScore(score: 66, year: 111)]
        case "國立高雄科技大學\n海洋休閒管理系":
            return [ChartScore(score: 62, year: 109), ChartScore(score: 58, year: 110), ChartScore(score: 59, year: 111)]
        case "國立高雄科技大學\n水產食品科學系":
            return [ChartScore(score: 58, year: 111)]
        case "國立臺中科技大學\n多媒體設計系":
            return [ChartScore(title: "專業科目二", score: 10, year: 109), ChartScore(title: "專業科目二", score: 11, year: 110), ChartScore(title: "專業科目二", score: 10, year: 111)]
        case "國立臺中科技大學\n商業設計系":
            return [ChartScore(score: 59, year: 109), ChartScore(score: 57, year: 110), ChartScore(score: 60, year: 111)]
        case "國立臺中科技大學\n資訊工程系":
            return [ChartScore(title: "專業科目一", score: 13, year: 109), ChartScore(title: "專業科目一", score: 11, year: 110), ChartScore(title: "專業科目一", score: 10, year: 111)]
        case "國立臺中科技大學\n休閒事業經營系":
            return [ChartScore(score: 63, year: 109), ChartScore(score: 63, year: 110), ChartScore(score: 62, year: 111)]
        case "國立虎尾科技大學\n車輛工程系":
            return [ChartScore(score: 45, year: 109), ChartScore(score: 44, year: 110), ChartScore(score: 45, year: 111)]
        case "國立虎尾科技大學\n工業管理系":
            return [ChartScore(score: 47, year: 109), ChartScore(score: 44, year: 110), ChartScore(score: 46, year: 111)]
        case "國立虎尾科技大學\n動力機械工程系":
            return [ChartScore(score: 46, year: 109), ChartScore(score: 45, year: 110), ChartScore(score: 47, year: 111)]
        case "國立虎尾科技大學\n材料科學與工程系":
            return [ChartScore(score: 47, year: 109), ChartScore(score: 38, year: 110), ChartScore(score: 46, year: 111)]
        case "國立虎尾科技大學\n飛機工程系機械組":
            return [ChartScore(score: 50, year: 109), ChartScore(score: 51, year: 110), ChartScore(score: 52, year: 111)]
        case "國立虎尾科技大學\n自動化工程系":
            return [ChartScore(score: 47, year: 109), ChartScore(score: 48, year: 110), ChartScore(score: 50, year: 111)]
        case "國立勤益科技大學\n工業工程與管理系":
            return [ChartScore(score: 41, year: 109), ChartScore(score: 36, year: 110), ChartScore(score: 36, year: 111)]
        case "國立勤益科技大學\n人工智慧應用工程系":
            return [ChartScore(title: "國文＋英文＋數學", score: 21, year: 111)]
        case "國立勤益科技大學\n冷凍空調與能源系能源應用組":
            return [ChartScore(score: 41, year: 109), ChartScore(score: 42, year: 110), ChartScore(score: 39, year: 111)]
        case "國立勤益科技大學\n冷凍空調與能源系環境控制組":
            return [ChartScore(score: 42, year: 109), ChartScore(score: 36, year: 110), ChartScore(score: 37, year: 111)]
        case "國立勤益科技大學\n智慧自動化工程系":
            return [ChartScore(score: 46, year: 111)]
        case "國立勤益科技大學\n流通管理系":
            return [ChartScore(score: 52, year: 109), ChartScore(score: 52, year: 110), ChartScore(score: 48, year: 111)]
        case "國立勤益科技大學\n資訊工程系":
            return [ChartScore(title: "國文＋英文＋數學", score: 31, year: 109), ChartScore(title: "國文＋英文＋數學", score: 29, year: 110), ChartScore(title: "國文＋英文＋數學", score: 29, year: 111)]
        case "國立屏東科技大學\n車輛工程系":
            return [ChartScore(title: "專業科目一＋專業科目二＋總級分", score: 67, year: 109), ChartScore(title: "專業科目一＋專業科目二＋總級分", score: 67, year: 110), ChartScore(title: "專業科目一＋專業科目二＋總級分", score: 60, year: 111)]
        case "國立屏東科技大學\n水產養殖系":
            return [ChartScore(score: 44, year: 109), ChartScore(score: 42, year: 110), ChartScore(score: 22, year: 111)]
        case "國立屏東科技大學\n生物機電工程系":
            return [ChartScore(score: 46, year: 109), ChartScore(score: 41, year: 110), ChartScore(score: 46, year: 111)]
        case "國立屏東科技大學\n材料工程系":
            return [ChartScore(score: 48, year: 109), ChartScore(score: 39, year: 110), ChartScore(score: 44, year: 111)]
        case "國立屏東科技大學\n智慧機電學士學位學程":
            return [ChartScore(score: 36, year: 111)]
        case "國立屏東科技大學\n休閒運動健康系":
            return [ChartScore(score: 48, year: 109), ChartScore(score: 42, year: 110), ChartScore(score: 43, year: 111)]
        case "國立澎湖科技大學\n水產養殖系":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 37, year: 110), ChartScore(score: 33, year: 111)]
        case "國立澎湖科技大學\n行銷與物流管理系":
            return [ChartScore(score: 57, year: 111)]
        case "國立澎湖科技大學\n海洋遊憩系":
            return [ChartScore(score: 53, year: 109), ChartScore(score: 50, year: 110), ChartScore(score: 50, year: 111)]
        case "國立臺北護理健康大學\n休閒產業與健康促進系":
            return [ChartScore(score: 60, year: 109), ChartScore(score: 59, year: 110), ChartScore(score: 59, year: 111)]
        case "國立高雄餐旅大學\n西餐廚藝系":
            return [ChartScore(title: "英文", score: 12, year: 109), ChartScore(title: "英文", score: 12, year: 110), ChartScore(score: 23, year: 111)]
        case "國立高雄餐旅大學\n烘焙管理系":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 56, year: 110), ChartScore(score: 53, year: 111)]
        case "國立高雄餐旅大學\n中餐廚藝系":
            return [ChartScore(title: "英文", score: 11, year: 109), ChartScore(title: "英文", score: 11, year: 110), ChartScore(title: "英文", score: 12, year: 111)]
        case "國立高雄餐旅大學\n航空暨運輸服務管理系":
            return [ChartScore(title: "英文", score: 13, year: 109), ChartScore(title: "英文", score: 13, year: 110), ChartScore(title: "英文", score: 13, year: 111)]
        case "朝陽科技大學\n工業工程與管理系":
            return [ChartScore(score: 34, year: 109), ChartScore(score: 34, year: 110), ChartScore(score: 35, year: 111)]
        case "朝陽科技大學\n航空機械系":
            return [ChartScore(score: 38, year: 109), ChartScore(score: 18, year: 110), ChartScore(score: 32, year: 111)]
        case "朝陽科技大學\n飛行與民航人員技術系":
            return [ChartScore(score: 21, year: 110), ChartScore(score: 18, year: 111)]
        case "朝陽科技大學\n資訊工程系人工智慧組":
            return [ChartScore(score: 31, year: 111)]
        case "朝陽科技大學\n工業設計系":
            return [ChartScore(score: 30, year: 109), ChartScore(score: 34, year: 110), ChartScore(score: 34, year: 111)]
        case "朝陽科技大學\n傳播藝術系":
            return [ChartScore(score: 46, year: 109), ChartScore(score: 45, year: 110), ChartScore(score: 42, year: 111)]
        case "朝陽科技大學\n行銷與流通管理系":
            return [ChartScore(score: 49, year: 109), ChartScore(score: 52, year: 110), ChartScore(score: 51, year: 111)]
        case "朝陽科技大學\n休閒事業管理系":
            return [ChartScore(score: 53, year: 109), ChartScore(score: 52, year: 110), ChartScore(score: 52, year: 111)]
        case "南臺科技大學\n工業管理與資訊系工業管理組":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 24, year: 111)]
        case "南臺科技大學\n流行音樂產業系":
            return [ChartScore(score: 33, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 32, year: 111)]
        case "南臺科技大學\n資訊傳播系":
            return [ChartScore(score: 42, year: 109), ChartScore(score: 33, year: 110), ChartScore(score: 40, year: 111)]
        case "南臺科技大學\n休閒事業管理系":
            return [ChartScore(score: 51, year: 109), ChartScore(score: 43, year: 110), ChartScore(score: 45, year: 111)]
        case "明志科技大學\n材料工程系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 33, year: 111)]
        case "明志科技大學\n工業工程與管理系":
            return [ChartScore(score: 26, year: 109), ChartScore(score: 33, year: 110), ChartScore(score: 36, year: 111)]
        case "明志科技大學\n半導體材料與製程學士學位學程":
            return [ChartScore(score: 33, year: 111)]
        case "明志科技大學\n工業人工智慧學士學位學程":
            return [ChartScore(score: 25, year: 111)]
        case "明志科技大學\n工業設計系":
            return [ChartScore(score: 38, year: 109), ChartScore(score: 34, year: 110), ChartScore(score: 37, year: 111)]
        case "致理科技大學\n行銷與流通管理系":
            return [ChartScore(score: 43, year: 109), ChartScore(score: 47, year: 110), ChartScore(score: 46, year: 111)]
        case "致理科技大學\n企業管理系":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 45, year: 110), ChartScore(score: 45, year: 111)]
        case "致理科技大學\n休閒遊憩管理系":
            return [ChartScore(score: 47, year: 109), ChartScore(score: 46, year: 110), ChartScore(score: 42, year: 111)]
        case "長庚科技大學 林口校區\n保健營養系":
            return [ChartScore(score: 52, year: 109), ChartScore(score: 48, year: 110), ChartScore(score: 50, year: 111)]
        case "大仁科技大學\n消防安全學士學位學程":
            return [ChartScore(score: 30, year: 110), ChartScore(score: 22, year: 111)]
        case "中國科技大學 臺北校區\n土木與防災系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 22, year: 111)]
        case "中國科技大學 臺北校區\n資訊工程系":
            return [ChartScore(score: 27, year: 110), ChartScore(score: 20, year: 111)]
        case "中國科技大學 新竹校區\n視覺傳達設計系":
            return [ChartScore(score: 27, year: 109), ChartScore(score: 35, year: 110), ChartScore(score: 37, year: 111)]
        case "中國科技大學 臺北校區\n企業管理系航空暨運輸服務管理組":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 31, year: 110), ChartScore(score: 35, year: 111)]
        case "中華科技大學 新竹校區\n航空電子系":
            return [ChartScore(score: 32, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 21, year: 111)]
        case "中華科技大學 新竹校區\n航空機械系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 21, year: 110), ChartScore(score: 25, year: 111)]
        case "中華科技大學 臺北校區\n建築系":
            return [ChartScore(score: 33, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 23, year: 111)]
        case "中華科技大學 臺北校區\n企業資訊與管理系":
            return [ChartScore(score: 30, year: 109), ChartScore(score: 35, year: 110), ChartScore(score: 40, year: 111)]
        case "中華醫事科技大學\n視光系":
            return [ChartScore(score: 26, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 27, year: 111)]
        case "臺北海洋科技大學 士林校區\n海洋運動休閒系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 26, year: 111)]
        case "亞東技術學院\n通訊工程系":
            return [ChartScore(score: 33, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 27, year: 111)]
        case "亞東技術學院\n工業管理系":
            return [ChartScore(score: 28, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 21, year: 111)]
        case "亞東技術學院\n工商業設計系":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 28, year: 110), ChartScore(score: 34, year: 111)]
        case "東南科技大學\n表演藝術系":
            return [ChartScore(score: 19, year: 111)]
        case "慈濟科技大學\n資訊科技與管理系":
            return [ChartScore(score: 25, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 23, year: 111)]
        case "華夏科技大學\n智慧車輛系":
            return [ChartScore(score: 20, year: 109), ChartScore(score: 19, year: 110), ChartScore(score: 19, year: 111)]
        case "華夏科技大學\n資訊工程系":
            return [ChartScore(score: 23, year: 111)]
        case "宏國德霖科技大學\n土木工程系":
            return [ChartScore(score: 23, year: 109), ChartScore(score: 29, year: 110), ChartScore(score: 23, year: 111)]
        case "宏國德霖科技大學\n創意產品設計系":
            return [ChartScore(score: 27, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 23, year: 111)]
        case "宏國德霖科技大學\n休閒事業管理系":
            return [ChartScore(score: 32, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 25, year: 111)]
        case "遠東科技大學\n流行音樂產業管理系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 32, year: 110), ChartScore(score: 43, year: 111)]
        case "遠東科技大學\n飛機修護系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 27, year: 111)]
        case "黎明技術學院\n車輛工程系":
            return [ChartScore(score: 23, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 23, year: 111)]
        case "黎明技術學院\n化妝品應用系":
            return [ChartScore(score: 20, year: 109), ChartScore(score: 30, year: 110), ChartScore(score: 33, year: 111)]
        case "黎明技術學院\n表演藝術系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 17, year: 110), ChartScore(score: 21, year: 111)]
        case "吳鳳科技大學\n車輛科技與經營管理系":
            return [ChartScore(score: 18, year: 109), ChartScore(score: 17, year: 110), ChartScore(score: 20, year: 111)]
        case "吳鳳科技大學\n消防系":
            return [ChartScore(score: 20, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 23, year: 111)]
        case "南開科技大學\n自動化工程系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 23, year: 111)]
        case "輔英科技大學\n生物科技系":
            return [ChartScore(score: 34, year: 109), ChartScore(score: 35, year: 110), ChartScore(score: 23, year: 111)]
        case "醒吾科技大學\n表演藝術系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 27, year: 111)]
        case "醒吾科技大學\n新媒體傳播系":
            return [ChartScore(score: 35, year: 109), ChartScore(score: 34, year: 110), ChartScore(score: 21, year: 111)]
        case "醒吾科技大學\n商業設計系":
            return [ChartScore(score: 20, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 20, year: 111)]
        case "修平科技大學\n工業工程與管理系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 25, year: 111)]
        case "德明財經科技大學\n多媒體設計系":
            return [ChartScore(score: 28, year: 109), ChartScore(score: 29, year: 110), ChartScore(score: 27, year: 111)]
        case "嶺東科技大學\n資訊科技系行動與系統應用組":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 16, year: 110), ChartScore(score: 19, year: 111)]
        case "嶺東科技大學\n資訊科技系智慧製造科技組":
            return [ChartScore(score: 23, year: 111)]
        case "嶺東科技大學\n資訊科技系網路管理與雲端應用組":
            return [ChartScore(score: 25, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 28, year: 111)]
        case "嶺東科技大學\n創意產品設計系":
            return [ChartScore(score: 18, year: 111)]
        case "健行科技大學\n財務金融系投資理財組":
            return [ChartScore(score: 18, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 23, year: 111)]
        case "健行科技大學\n工業管理系":
            return [ChartScore(score: 18, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 21, year: 111)]
        case "健行科技大學\n車輛工程系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 23, year: 111)]
        case "健行科技大學\n土木工程系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 18, year: 111)]
        case "建國科技大學\n創意產品與遊戲設計系":
            return [ChartScore(score: 25, year: 109), ChartScore(score: 19, year: 110), ChartScore(score: 20, year: 111)]
        case "建國科技大學\n視覺傳達設計系商業設計組":
            return [ChartScore(score: 33, year: 111)]
        case "臺北城市科技大學\n休閒事業系":
            return [ChartScore(score: 29, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 31, year: 111)]
        case "萬能科技大學\n企業管理系":
            return [ChartScore(score: 24, year: 111)]
        case "萬能科技大學\n行銷與流通管理系":
            return [ChartScore(score: 19, year: 111)]
        case "萬能科技大學\n車輛工程系":
            return [ChartScore(score: 15, year: 109), ChartScore(score: 19, year: 110), ChartScore(score: 18, year: 111)]
        case "萬能科技大學\n室內設計與營建科技系室內設計與管理組":
            return [ChartScore(score: 28, year: 109), ChartScore(score: 25, year: 110), ChartScore(score: 25, year: 111)]
        case "萬能科技大學\n時尚造型設計系時尚表演藝術組":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 15, year: 111)]
        case "萬能科技大學\n航空光機電系":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 18, year: 110), ChartScore(score: 20, year: 111)]
        case "龍華科技大學\n工業管理系":
            return [ChartScore(score: 23, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 21, year: 111)]
        case "元培醫事科技大學\n生物醫學工程系":
            return [ChartScore(score: 26, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 26, year: 111)]
        case "元培醫事科技大學\n生物科技暨製藥技術系":
            return [ChartScore(score: 30, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 26, year: 111)]
        case "明新科技大學\n工業工程與管理系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 18, year: 110), ChartScore(score: 20, year: 111)]
        case "明新科技大學\n半導體與光電科技系":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 27, year: 110), ChartScore(score: 30, year: 111)]
        case "明新科技大學\n資訊工程系":
            return [ChartScore(score: 26, year: 109), ChartScore(score: 31, year: 110), ChartScore(score: 31, year: 111)]
        case "景文科技大學\n視覺傳達設計系視覺設計組":
            return [ChartScore(score: 35, year: 111)]
        case "崑山科技大學\n公共關係暨廣告系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 27, year: 110), ChartScore(score: 26, year: 111)]
        case "崑山科技大學\n視訊傳播設計系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 33, year: 110), ChartScore(score: 28, year: 111)]
        case "崑山科技大學\n智慧機器人工程系":
            return [ChartScore(score: 21, year: 109), ChartScore(score: 21, year: 110), ChartScore(score: 22, year: 111)]
        case "崑山科技大學\n金融管理系":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 28, year: 110), ChartScore(score: 43, year: 111)]
        case "敏實科技大學\n智慧車輛與能源系":
            return [ChartScore(title: "國文＋英文＋數學＋專業科目一＋專業科目二＋總級分", score: 40, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 22, year: 111)]
        case "敏實科技大學\n智慧製造工程系":
            return [ChartScore(title: "國文＋英文＋數學＋專業科目一＋專業科目二＋總級分", score: 44, year: 109), ChartScore(score: 22, year: 110), ChartScore(score: 27, year: 111)]
        case "弘光科技大學\n智慧科技應用系":
            return [ChartScore(score: 30, year: 109), ChartScore(score: 21, year: 110), ChartScore(score: 21, year: 111)]
        case "弘光科技大學\n國際溝通英語系":
            return [ChartScore(score: 48, year: 109), ChartScore(score: 46, year: 110), ChartScore(score: 48, year: 111)]
        case "弘光科技大學\n食品科技系烘焙科技組":
            return [ChartScore(score: 51, year: 109), ChartScore(score: 52, year: 110), ChartScore(score: 50, year: 111)]
        case "弘光科技大學\n健康事業管理系":
            return [ChartScore(score: 23, year: 109), ChartScore(score: 42, year: 110), ChartScore(score: 43, year: 111)]
        case "中臺科技大學\n人工智慧健康管理系":
            return [ChartScore(score: 29, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 22, year: 111)]
        case "中臺科技大學\n牙體技術暨材料系":
            return [ChartScore(score: 29, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 20, year: 111)]
        case "中臺科技大學\n老人照顧系":
            return [ChartScore(score: 26, year: 109), ChartScore(title: "專業科目一＋專業科目二", score: 12, year: 110), ChartScore(title: "專業科目一＋專業科目二", score: 11, year: 111)]
        case "中臺科技大學\n食品科技系":
            return [ChartScore(score: 36, year: 109), ChartScore(title: "國文＋專業科目一＋專業科目二", score: 14, year: 110), ChartScore(title: "國文＋專業科目一＋專業科目二", score: 16, year: 111)]
        case "正修科技大學\n工業工程與管理系":
            return [ChartScore(score: 19, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 18, year: 111)]
        case "樹德科技大學\n生活產品設計系":
            return [ChartScore(score: 31, year: 109), ChartScore(score: 20, year: 110), ChartScore(score: 23, year: 111)]
        case "樹德科技大學\n流通管理系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 24, year: 110), ChartScore(score: 24, year: 111)]
        case "僑光科技大學\n財務金融系":
            return [ChartScore(score: 24, year: 111)]
        case "育達科技大學\n休閒運動管理系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 27, year: 111)]
        case "育達科技大學\n智慧機電工程與應用系":
            return [ChartScore(score: 21, year: 111)]
        case "育達科技大學\n物聯網工程與應用學士學位學程":
            return [ChartScore(score: 25, year: 109), ChartScore(score: 23, year: 110), ChartScore(score: 29, year: 111)]
        case "南亞技術學院\n資訊工程系":
            return [ChartScore(score: 24, year: 109), ChartScore(score: 26, year: 110), ChartScore(score: 29, year: 111)]
        case "崇右影藝科技大學\n時尚造型設計系":
            return [ChartScore(score: 22, year: 109), ChartScore(score: 18, year: 110), ChartScore(score: 31, year: 111)]
        default:
            return []
        }
    }
    //MARK: 登記分發(臺科 北科 北商 雲科 屏科 南護專)
    func getScore8000() -> [ChartScore]
    {
        switch(self.name) {
            //MARK: 國立臺灣科技大學
        case "國立臺灣科技大學\n機械工程系":
            return [ChartScore(title: "機械", score: 630.5, year: 107), ChartScore(title: "機械", score: 600, year: 108), ChartScore(title: "機械", score: 569, year: 109), ChartScore(title: "機械", score: 572.5, year: 110), ChartScore(title: "機械", score: 532.75, year: 111), ChartScore(title: "機械：540 動機：587 電機：563", score: 587, year: 112)]
        case "國立臺灣科技大學\n材料科學與工程系":
            return [ChartScore(title: "機械：628.5 電機：624.5 化工：601", score: 628.5, year: 107), ChartScore(title: "機械：600 電機：618 化工：569", score: 618, year: 108), ChartScore(title: "機械：568.5 電機：597 化工：553.5", score: 597, year: 109), ChartScore(title: "機械：587 化工：578", score: 587, year: 110), ChartScore(title: "機械：668.38 電機：628.38 化工：584.25", score: 668.38, year: 111), ChartScore(title: "機械：656.5 電機：657.5 化工：598.19", score: 657.5, year: 112)]
        case "國立臺灣科技大學\n全球發展工程學士學位學程機械工程組":
            return [ChartScore(title: "機械：899.5 化工：786", score: 899.5, year: 112)]
        case "國立臺灣科技大學\n電機工程系":
            return [ChartScore(title: "電機", score: 628.5, year: 107), ChartScore(title: "電機", score: 622, year: 108), ChartScore(title: "電機", score: 617.5, year: 109), ChartScore(title: "電機", score: 619, year: 110), ChartScore(title: "電機", score: 972, year: 111), ChartScore(title: "電機", score: 970, year: 112)]
        case "國立臺灣科技大學\n電子工程系":
            return [ChartScore(title: "資電", score: 627, year: 107), ChartScore(title: "資電", score: 605, year: 108), ChartScore(title: "資電", score: 577.5, year: 109), ChartScore(title: "資電", score: 615, year: 110), ChartScore(title: "資電", score: 591, year: 111), ChartScore(title: "電機：850 資電：847.5", score: 850, year: 112)]
        case "國立臺灣科技大學\n資訊工程系":
            return [ChartScore(title: "資電", score: 639.75, year: 107), ChartScore(title: "資電", score: 620, year: 108), ChartScore(title: "資電", score: 589, year: 109), ChartScore(title: "資電", score: 619.5, year: 110), ChartScore(title: "資電", score: 601.75, year: 111), ChartScore(title: "資電", score: 773.5, year: 112)]
        case "國立臺灣科技大學\n資訊管理系":
            return [ChartScore(title: "資電：618.5 商管：650.5", score: 650.5, year: 107), ChartScore(title: "資電：602.5 商管：628", score: 628, year: 108), ChartScore(title: "資電：564.5 商管：626", score: 626, year: 109), ChartScore(title: "資電：592.75 商管：638", score: 638, year: 110), ChartScore(title: "資電：593 商管：603", score: 603, year: 111), ChartScore(title: "資電：579 商管：583.75", score: 583.75, year: 112)]
        case "國立臺灣科技大學\n化學工程系":
            return [ChartScore(title: "化工", score: 614, year: 107), ChartScore(title: "化工", score: 744.25, year: 108), ChartScore(title: "化工", score: 729, year: 109), ChartScore(title: "化工", score: 725.75, year: 110), ChartScore(title: "化工", score: 662.5, year: 111), ChartScore(title: "化工", score: 653.63, year: 112)]
        case "國立臺灣科技大學\n營建工程系":
            return [ChartScore(title: "土木", score: 570, year: 107), ChartScore(title: "土木", score: 705.5, year: 108), ChartScore(title: "土木", score: 681.5, year: 109), ChartScore(title: "土木", score: 664.25, year: 110), ChartScore(title: "土木", score: 581.5, year: 111), ChartScore(title: "土木", score: 669.5, year: 112)]
        case "國立臺灣科技大學\n建築系":
            return [ChartScore(title: "土木：575 設計：597", score: 597, year: 107), ChartScore(title: "土木：561.75 設計：577.5", score: 577.5, year: 108), ChartScore(title: "土木：534.75 設計：590", score: 590, year: 109), ChartScore(title: "土木：505 設計：566.5", score: 566.5, year: 110), ChartScore(title: "土木：484.25 設計：558.5", score: 558.5, year: 111), ChartScore(title: "土木：819 設計：861", score: 861, year: 112)]
        case "國立臺灣科技大學\n設計系商業設計組":
            return [ChartScore(title: "設計", score: 598.5, year: 107), ChartScore(title: "設計", score: 778, year: 108), ChartScore(title: "設計", score: 782, year: 109), ChartScore(title: "設計", score: 742, year: 110), ChartScore(title: "設計", score: 769, year: 111), ChartScore(title: "設計", score: 716.5, year: 112)]
        case "國立臺灣科技大學\n設計系工業設計組":
            return [ChartScore(title: "設計", score: 599.5, year: 107), ChartScore(title: "設計", score: 774.5, year: 108), ChartScore(title: "設計", score: 775, year: 109), ChartScore(title: "設計", score: 747.5, year: 110), ChartScore(title: "設計", score: 733, year: 111), ChartScore(title: "設計", score: 715.5, year: 112)]
        case "國立臺灣科技大學\n工業管理系":
            return [ChartScore(title: "工管", score: 538.5, year: 107), ChartScore(title: "工管", score: 654, year: 108), ChartScore(title: "工管：788.5 商管：805.25", score: 805.25, year: 109), ChartScore(title: "資電：751 工管：701.75 商管：802.88", score: 802.88, year: 110), ChartScore(title: "資電：721.25 工管：576.25 商管：786.63", score: 786.63, year: 111), ChartScore(title: "資電：725.75 工管：656.63 商管：759.88", score: 759.88, year: 112)]
        case "國立臺灣科技大學\n企業管理系":
            return [ChartScore(title: "商管", score: 647, year: 107), ChartScore(title: "商管", score: 624.5, year: 108), ChartScore(title: "商管", score: 624.5, year: 109), ChartScore(title: "商管", score: 618, year: 110), ChartScore(title: "商管：598.5 英語：606.5", score: 606.5, year: 111), ChartScore(title: "資電：578 商管：564.5 英語：620", score: 620, year: 112)]
        case "國立臺灣科技大學\n應用外語系":
            return [ChartScore(title: "英語", score: 621.5, year: 107), ChartScore(title: "英語", score: 810.5, year: 108), ChartScore(title: "英語", score: 814.5, year: 109), ChartScore(title: "英語", score: 778, year: 110), ChartScore(title: "英語", score: 769.5, year: 111), ChartScore(title: "商管：715 英語：790", score: 790, year: 112)]
            //MARK: 國立臺北科技大學
        case "國立臺北科技大學\n機械工程系":
            return [ChartScore(title: "機械", score: 609.5, year: 107), ChartScore(title: "機械", score: 734, year: 108), ChartScore(title: "機械", score: 757.5, year: 109), ChartScore(title: "機械", score: 800.75, year: 110), ChartScore(title: "機械", score: 720.75, year: 111)]
        case "國立臺北科技大學\n工業工程與管理系":
            return [ChartScore(title: "機械：605.75 資電：598 商管：636.25", score: 636.25, year: 107), ChartScore(title: "機械：686.25 資電：681.75 商管：738.25", score: 738.25, year: 108), ChartScore(title: "機械：625.38 資電：640.13 商管：739.88", score: 739.88, year: 109), ChartScore(title: "機械：665 資電：688 商管：736.5", score: 736.5, year: 110), ChartScore(title: "機械：587.75 資電：629.25 商管：715.25", score: 715.25, year: 111)]
        case "國立臺北科技大學\n材料及資源工程系材料組":
            return [ChartScore(title: "機械：608.5 化工：556 工管：542.75", score: 608.5, year: 107), ChartScore(title: "機械：908 化工：799 工管：835.5", score: 908, year: 108), ChartScore(title: "機械：843.5 化工：797.5 工管：875", score: 875, year: 109), ChartScore(title: "機械：882.5 化工：836 工管：821", score: 882.5, year: 110), ChartScore(title: "機械：789 化工：714 工管：632", score: 789, year: 111)]
        case "國立臺北科技大學\n材料及資源工程系資源組":
            return [ChartScore(title: "機械：606.75 土木：529.5 工管：535", score: 606.75, year: 107), ChartScore(title: "機械：899 土木：876 工管：790", score: 790, year: 108), ChartScore(title: "機械：820 化工：743 土木：706.5", score: 820, year: 109), ChartScore(title: "機械：868.5 化工：787 土木：742.5", score: 868.5, year: 110), ChartScore(title: "機械：780.5 化工：731 土木：690", score: 780.5, year: 111)]
        case "國立臺北科技大學\n車輛工程系":
            return [ChartScore(title: "動機", score: 592.5, year: 107), ChartScore(title: "動機", score: 569, year: 108), ChartScore(title: "動機", score: 528, year: 109), ChartScore(title: "動機", score: 548, year: 110), ChartScore(title: "動機", score: 478, year: 111)]
        case "國立臺北科技大學\n能源與冷凍空調工程系":
            return [ChartScore(title: "電機", score: 609, year: 107), ChartScore(title: "電機", score: 582.5, year: 108), ChartScore(title: "電機", score: 568, year: 109), ChartScore(title: "電機", score: 573.25, year: 110), ChartScore(title: "機械：498 電機：521 資電：537", score: 537, year: 111)]
        case "國立臺北科技大學\n電機工程系":
            return [ChartScore(title: "電機：623.5 資電：609", score: 623.5, year: 107), ChartScore(title: "電機：600 資電：578.75", score: 600, year: 108), ChartScore(title: "電機：590.25 資電：551.5", score: 590.25, year: 109), ChartScore(title: "電機：600 資電：589", score: 600, year: 110), ChartScore(title: "電機：569 資電：573.5", score: 573.5, year: 111)]
        case "國立臺北科技大學\n資訊工程系":
            return [ChartScore(title: "電機：619.5 資電：609", score: 619.5, year: 107), ChartScore(title: "電機：599.25 資電：592.25", score: 599.25, year: 108), ChartScore(title: "電機：589 資電：555", score: 589, year: 109), ChartScore(title: "電機：598 資電：588.5", score: 598, year: 110), ChartScore(title: "電機：566 資電：568.5", score: 568.5, year: 111)]
        case "國立臺北科技大學\n電子工程系":
            return [ChartScore(title: "電機：622 資電：609.25", score: 622, year: 107), ChartScore(title: "電機：594.5 資電：580.5", score: 580.5, year: 108), ChartScore(title: "電機：586.5 資電：548", score: 586.5, year: 109), ChartScore(title: "電機：598 資電：589.5", score: 598, year: 110), ChartScore(title: "電機：567.75 資電：567", score: 567.75, year: 111)]
        case "國立臺北科技大學\n光電工程系":
            return [ChartScore(title: "資電", score: 600.5, year: 107), ChartScore(title: "資電", score: 742, year: 108), ChartScore(title: "資電", score: 704, year: 109), ChartScore(title: "資電", score: 759, year: 110), ChartScore(title: "資電", score: 716, year: 111)]
        case "國立臺北科技大學\n資訊與財金管理系":
            return [ChartScore(title: "資電：603 商管：652.5", score: 652.5, year: 107), ChartScore(title: "資電：749 商管：813", score: 813, year: 108), ChartScore(title: "資電：706.5 商管：811.5", score: 811.5, year: 109), ChartScore(title: "資電：756.5 商管：814.5", score: 814.5, year: 110), ChartScore(title: "資電：698.75 商管：770.5", score: 770.5, year: 111)]
        case "國立臺北科技大學\n分子科學與工程系":
            return [ChartScore(title: "化工", score: 556.5, year: 107), ChartScore(title: "化工", score: 496, year: 108), ChartScore(title: "化工", score: 490, year: 109), ChartScore(title: "化工", score: 525.5, year: 110), ChartScore(title: "化工", score: 715, year: 111)]
        case "國立臺北科技大學\n化學工程與生物科技系":
            return [ChartScore(title: "化工", score: 557.25, year: 107), ChartScore(title: "化工", score: 516, year: 108), ChartScore(title: "化工", score: 491, year: 109), ChartScore(title: "化工", score: 499.25, year: 110), ChartScore(title: "化工", score: 433, year: 111)]
        case "國立臺北科技大學\n土木工程系":
            return [ChartScore(title: "土木", score: 541, year: 107), ChartScore(title: "土木", score: 516, year: 108), ChartScore(title: "土木", score: 472.5, year: 109), ChartScore(title: "土木", score: 470, year: 110), ChartScore(title: "土木", score: 412, year: 111)]
        case "國立臺北科技大學\n建築系":
            return [ChartScore(title: "土木：534 設計：571.5", score: 571.5, year: 107), ChartScore(title: "土木：772 設計：811", score: 811, year: 108), ChartScore(title: "土木：743.5 設計：818", score: 818, year: 109), ChartScore(title: "土木：708 設計：790.5", score: 790.5, year: 110), ChartScore(title: "土木：636 設計：753.5", score: 753.5, year: 111)]
        case "國立臺北科技大學\n工業設計系產品設計組":
            return [ChartScore(title: "設計", score: 584.5, year: 107), ChartScore(title: "設計", score: 572, year: 108), ChartScore(title: "設計", score: 586.25, year: 109), ChartScore(title: "設計", score: 546.5, year: 110), ChartScore(title: "設計", score: 534, year: 111)]
        case "國立臺北科技大學\n工業設計系家具與室內設計組":
            return [ChartScore(title: "設計", score: 591.5, year: 107), ChartScore(title: "設計", score: 575, year: 108), ChartScore(title: "設計", score: 581.5, year: 109), ChartScore(title: "設計", score: 544.5, year: 110), ChartScore(title: "設計", score: 542, year: 111)]
        case "國立臺北科技大學\n互動設計系視覺傳達設計組":
            return [ChartScore(title: "設計", score: 582.5, year: 107), ChartScore(title: "設計", score: 586.5, year: 108), ChartScore(title: "設計", score: 593.5, year: 109), ChartScore(title: "設計", score: 564, year: 110), ChartScore(title: "設計", score: 551, year: 111)]
        case "國立臺北科技大學\n互動設計系媒體設計組":
            return [ChartScore(title: "設計", score: 577, year: 107), ChartScore(title: "設計", score: 580.5, year: 108), ChartScore(title: "設計", score: 586.5, year: 109), ChartScore(title: "設計", score: 571.5, year: 110), ChartScore(title: "設計", score: 553, year: 111)]
        case "國立臺北科技大學\n文化事業發展系":
            return [ChartScore(title: "設計：572.5 商管：628.5 日語：546.5", score: 628.5, year: 107), ChartScore(title: "設計：719.5 商管：785 日語：758", score: 785, year: 108), ChartScore(title: "設計：733.5 商管：760.5 日語：790", score: 790, year: 109), ChartScore(title: "設計：685.5 商管：772 日語：739", score: 772, year: 110), ChartScore(title: "設計：677.75 商管：733 日語：671", score: 733, year: 111)]
        case "國立臺北科技大學\n經營管理系":
            return [ChartScore(title: "商管", score: 637, year: 107), ChartScore(title: "商管", score: 954, year: 108), ChartScore(title: "商管", score: 942, year: 109), ChartScore(title: "商管", score: 947, year: 110), ChartScore(title: "商管", score: 931, year: 111)]
        case "國立臺北科技大學\n應用英文系":
            return [ChartScore(title: "英語", score: 608.5, year: 107), ChartScore(title: "英語", score: 958, year: 108), ChartScore(title: "英語", score: 791.5, year: 109), ChartScore(title: "英語", score: 742, year: 110), ChartScore(title: "英語", score: 740.5, year: 111)]
            //MARK: 國立臺北商業大學
        case "國立臺北商業大學 桃園校區\n創意科技與產品設計系":
            return [ChartScore(title: "機械：459 資電：406 設計：540.5", score: 540.5, year: 109), ChartScore(title: "機械：517 資電：456.5 設計：520.5", score: 520.5, year: 110), ChartScore(title: "機械：399 資電：423.5 設計：495", score: 495, year: 111), ChartScore(title: "機械：409 資電：413.75 設計：482.5", score: 482.5, year: 112)]
        case "國立臺北商業大學 臺北校區\n資訊管理系":
            return [ChartScore(title: "資電：593 商管：621.75", score: 621.75, year: 107), ChartScore(title: "資電：624.88 商管：676.63", score: 676.63, year: 108), ChartScore(title: "資電：600.25 商管：672.38", score: 672.38, year: 109), ChartScore(title: "資電：655.5 商管：676.38", score: 676.38, year: 110), ChartScore(title: "資電：600.13 商管：638.81", score: 638.81, year: 111), ChartScore(title: "資電：591.63 商管：608.25", score: 608.25, year: 112)]
        case "國立臺北商業大學 桃園校區\n商品創意經營系":
            return [ChartScore(title: "土木：460.5 設計：534 商管：585.5", score: 585.5, year: 107), ChartScore(title: "土木：474.5 設計：534.5 商管：564", score: 564, year: 108)]
        case "國立臺北商業大學 桃園校區\n商業設計管理系":
            return [ChartScore(title: "設計：541 商管：571.25", score: 571.25, year: 107), ChartScore(title: "設計：540.5 商管：557.25", score: 557.25, year: 108), ChartScore(title: "設計：541 商管：566", score: 566, year: 109), ChartScore(title: "設計：690.75 商管：743", score: 743, year: 110), ChartScore(title: "設計：673 商管：666", score: 673, year: 111), ChartScore(title: "設計：519.38 商管：504.5", score: 519.38, year: 112)]
        case "國立臺北商業大學 桃園校區\n數位多媒體設計系":
            return [ChartScore(title: "設計：542 商管：566.5", score: 566.5, year: 107), ChartScore(title: "設計：553 商管：555.5", score: 555.5, year: 108), ChartScore(title: "設計：557 商管：542.5", score: 557, year: 109), ChartScore(title: "設計：523.75 商管：577.5", score: 577.5, year: 110), ChartScore(title: "設計：651.5 商管：652.5", score: 652.5, year: 111), ChartScore(title: "設計：619.5 商管：591.5", score: 619.5, year: 112)]
        case "國立臺北商業大學 臺北校區\n企業管理系":
            return [ChartScore(title: "商管", score: 611.5, year: 107), ChartScore(title: "商管", score: 588, year: 108), ChartScore(title: "商管", score: 586, year: 109), ChartScore(title: "商管", score: 587, year: 110), ChartScore(title: "商管", score: 553, year: 111), ChartScore(title: "商管", score: 667.63, year: 112)]
        case "國立臺北商業大學 臺北校區\n財政稅務系":
            return [ChartScore(title: "商管", score: 615.5, year: 107), ChartScore(title: "商管", score: 594, year: 108), ChartScore(title: "商管", score: 598.5, year: 109), ChartScore(title: "商管", score: 594.5, year: 110), ChartScore(title: "商管", score: 570.5, year: 111), ChartScore(title: "商管", score: 533, year: 112)]
        case "國立臺北商業大學 臺北校區\n財務金融系":
            return [ChartScore(title: "商管", score: 631, year: 107), ChartScore(title: "商管", score: 608.5, year: 108), ChartScore(title: "商管", score: 609.5, year: 109), ChartScore(title: "商管", score: 621, year: 110), ChartScore(title: "商管", score: 666.31, year: 111), ChartScore(title: "商管", score: 628.63, year: 112)]
        case "國立臺北商業大學 臺北校區\n國際商務系":
            return [ChartScore(title: "商管：614.5 英語：594.5", score: 614.5, year: 107), ChartScore(title: "商管：590 英語：601", score: 601, year: 108), ChartScore(title: "商管：593 英語：609", score: 609, year: 109), ChartScore(title: "商管：588.5 英語：557.5", score: 588.5, year: 110), ChartScore(title: "商管：561 英語：563.75", score: 563.75, year: 111), ChartScore(title: "商管：521 英語：575", score: 575, year: 112)]
        case "國立臺北商業大學 臺北校區\n會計資訊系":
            return [ChartScore(title: "商管", score: 628, year: 107), ChartScore(title: "商管", score: 776.75, year: 108), ChartScore(title: "商管", score: 779.5, year: 109), ChartScore(title: "商管", score: 776.5, year: 110), ChartScore(title: "商管", score: 835.5, year: 111), ChartScore(title: "商管", score: 768.63, year: 112)]
        case "國立臺北商業大學 臺北校區\n應用外語系":
            return [ChartScore(title: "英語", score: 584, year: 107), ChartScore(title: "英語", score: 591, year: 108), ChartScore(title: "英語", score: 599, year: 109), ChartScore(title: "英語", score: 554.25, year: 110), ChartScore(title: "英語", score: 765, year: 111), ChartScore(title: "英語", score: 752.5, year: 112)]
            //MARK: 國立雲林科技大學
        case "國立雲林科技大學\n機械工程系":
            return [ChartScore(title: "機械", score: 578, year: 107), ChartScore(title: "機械", score: 681.25, year: 108), ChartScore(title: "機械：617.5 動機：578.75", score: 617.5, year: 109), ChartScore(title: "機械：661.75 動機：640.5", score: 661.75, year: 110), ChartScore(title: "機械：582.5 動機：617.5", score: 617.5, year: 111)]
        case "國立雲林科技大學\n工業工程與管理系":
            return [ChartScore(title: "機械：562 工管：534.5 商管：610", score: 610, year: 107), ChartScore(title: "機械：527 工管：459.5 商管：582", score: 582, year: 108), ChartScore(title: "機械：467.5 資電：466.75 商管：579.5", score: 579.5, year: 109), ChartScore(title: "機械：495.5 資電：532.5 商管：585", score: 585, year: 110), ChartScore(title: "機械：464 資電：497 商管：541.75", score: 541.75, year: 111)]
        case "國立雲林科技大學\n工業設計系":
            return [ChartScore(title: "機械：600 設計：560", score: 600, year: 107), ChartScore(title: "機械：542.5 設計：559", score: 559, year: 108), ChartScore(title: "機械：508.5 資電：480 設計：558.5", score: 558.5, year: 109), ChartScore(title: "機械：524 資電：540 設計：530.5", score: 540, year: 110), ChartScore(title: "機械：460 資電：535 設計：523.75", score: 535, year: 111)]
        case "國立雲林科技大學\n電機工程系":
            return [ChartScore(title: "電機：599 資電：585.5", score: 599, year: 107), ChartScore(title: "電機：568 資電：544.25", score: 568, year: 108), ChartScore(title: "電機：554 資電：512", score: 554, year: 109), ChartScore(title: "電機：566.24 資電：561.5", score: 566.24, year: 110), ChartScore(title: "電機：524.5 資電：508", score: 524.5, year: 111)]
        case "國立雲林科技大學\n電子工程系":
            return [ChartScore(title: "電機：599 資電：581.5", score: 592.5, year: 107), ChartScore(title: "電機：867 資電：850", score: 867, year: 108), ChartScore(title: "電機：848 資電：790", score: 848, year: 109), ChartScore(title: "電機：864 資電：890", score: 890, year: 110), ChartScore(title: "電機：807 資電：823.5", score: 823.5, year: 111)]
        case "國立雲林科技大學\n資訊工程系":
            return [ChartScore(title: "資電", score: 594.25, year: 107), ChartScore(title: "資電", score: 555, year: 108), ChartScore(title: "電機：557.5 資電：514.5", score: 557.5, year: 109), ChartScore(title: "電機：547 資電：567 工管：406.75", score: 567, year: 110), ChartScore(title: "電機：509 資電：527 工管：389", score: 527, year: 111)]
        case "國立雲林科技大學\n資訊管理系":
            return [ChartScore(title: "資電：577.75 商管：629", score: 629, year: 107), ChartScore(title: "資電：838.5 商管：933", score: 933, year: 108), ChartScore(title: "資電：752 商管：926", score: 926, year: 109), ChartScore(title: "資電：860 商管：942", score: 942, year: 110), ChartScore(title: "資電：787 商管：871", score: 871, year: 111)]
        case "國立雲林科技大學\n環境與安全衛生工程系":
            return [ChartScore(title: "機械：562.5 化工：511", score: 562.5, year: 107), ChartScore(title: "機械：786 化工：716", score: 786, year: 108), ChartScore(title: "機械：717 資電：688 化工：664.5", score: 717, year: 109), ChartScore(title: "機械：751.5 資電：829 化工：684", score: 829, year: 110), ChartScore(title: "資電：704 化工：600", score: 704, year: 111)]
        case "國立雲林科技大學\n化學工程與材料工程系":
            return [ChartScore(title: "化工", score: 523.5, year: 107), ChartScore(title: "化工", score: 729, year: 108), ChartScore(title: "化工", score: 676, year: 109), ChartScore(title: "化工", score: 701.5, year: 110), ChartScore(title: "化工", score: 403.75, year: 111)]
        case "國立雲林科技大學\n文化資產維護系":
            return [ChartScore(title: "化工：517.5 設計：556.5 商管：599", score: 599, year: 107), ChartScore(title: "化工：459 設計：551.25 商管：562", score: 562, year: 108), ChartScore(title: "化工：376 設計：582 商管：547.5", score: 582, year: 109), ChartScore(title: "化工：420 設計：528.5 商管：557.25", score: 557.25, year: 110), ChartScore(title: "化工：375 設計：513.5 商管：493", score: 493, year: 111)]
        case "國立雲林科技大學\n營建工程系":
            return [ChartScore(title: "土木", score: 495, year: 107), ChartScore(title: "土木", score: 489, year: 108), ChartScore(title: "土木", score: 428, year: 109), ChartScore(title: "土木", score: 435.5, year: 110), ChartScore(title: "土木", score: 392.5, year: 111)]
        case "國立雲林科技大學\n建築與室內設計系建築組":
            return [ChartScore(title: "土木：513 設計：558.5", score: 558.5, year: 107), ChartScore(title: "土木：520 設計：558", score: 558, year: 108), ChartScore(title: "土木：448 設計：559.25", score: 559.25, year: 109), ChartScore(title: "土木：465 設計：536.5", score: 536.5, year: 110), ChartScore(title: "土木：422.25 設計：519.5", score: 519.5, year: 111)]
        case "國立雲林科技大學\n建築與室內設計系室內組":
            return [ChartScore(title: "土木：502.5 設計：570.5", score: 570.5, year: 107), ChartScore(title: "土木：511 設計：561", score: 561, year: 108), ChartScore(title: "土木：451.5 設計：563", score: 563, year: 109), ChartScore(title: "土木：440 設計：562", score: 562, year: 110), ChartScore(title: "土木：406 設計：521", score: 521, year: 111)]
        case "國立雲林科技大學\n創意生活設計系":
            return [ChartScore(title: "土木：474.75 設計：600.25 生活：577.5", score: 600.25, year: 107), ChartScore(title: "土木：503 設計：557 生活：588", score: 588, year: 108), ChartScore(title: "土木：412 設計：560.5 生活：546.5", score: 560.5, year: 109), ChartScore(title: "土木：438 設計：561 生活：522", score: 561, year: 110), ChartScore(title: "土木：396.5 設計：534 生活：561", score: 561, year: 111)]
        case "國立雲林科技大學\n跨域整合設計學士學位學程":
            return [ChartScore(title: "土木：389 設計：525", score: 525, year: 111)]
        case "國立雲林科技大學\n視覺傳達設計系":
            return [ChartScore(title: "設計", score: 565, year: 107), ChartScore(title: "設計", score: 563.5, year: 108), ChartScore(title: "設計", score: 561, year: 109), ChartScore(title: "設計", score: 536, year: 110), ChartScore(title: "設計", score: 541, year: 111)]
        case "國立雲林科技大學\n數位媒體設計系":
            return [ChartScore(title: "設計", score: 574, year: 107), ChartScore(title: "設計", score: 560, year: 108), ChartScore(title: "設計", score: 563.5, year: 109), ChartScore(title: "設計", score: 554, year: 110), ChartScore(title: "設計", score: 555, year: 111)]
        case "國立雲林科技大學\n企業管理系":
            return [ChartScore(title: "商管：613.5 英語：568.5", score: 613.5, year: 107), ChartScore(title: "商管：758 英語：765", score: 765, year: 108), ChartScore(title: "商管：748 英語：768", score: 768, year: 109), ChartScore(title: "商管：751 英語：711.5", score: 751, year: 110), ChartScore(title: "商管：706 英語：697.25", score: 697.25, year: 111)]
        case "國立雲林科技大學\n財務金融系":
            return [ChartScore(title: "商管：629.5 英語：572.25", score: 629.5, year: 107), ChartScore(title: "商管：949 英語：942.5", score: 949, year: 108), ChartScore(title: "商管：959 英語：968.5", score: 968.5, year: 109), ChartScore(title: "商管：946 英語：890", score: 946, year: 110), ChartScore(title: "商管：888 英語：846.5", score: 846.5, year: 111)]
        case "國立雲林科技大學\n會計系":
            return [ChartScore(title: "商管", score: 617.5, year: 107), ChartScore(title: "商管", score: 590.5, year: 108), ChartScore(title: "商管", score: 591, year: 109), ChartScore(title: "商管", score: 760, year: 110), ChartScore(title: "商管", score: 804, year: 111)]
        case "國立雲林科技大學\n國際管理學士學位學程":
            return [ChartScore(title: "商管", score: 633, year: 107), ChartScore(title: "商管", score: 763, year: 108), ChartScore(title: "商管", score: 759, year: 109), ChartScore(title: "商管", score: 751, year: 110), ChartScore(title: "商管", score: 705.5, year: 111)]
        case "國立雲林科技大學\n應用外語系":
            return [ChartScore(title: "商管：604.5 英語：570", score: 604.5, year: 107), ChartScore(title: "商管：896 英語：931", score: 931, year: 108), ChartScore(title: "商管：889.5 英語：923.5", score: 923.5, year: 109), ChartScore(title: "商管：886 英語：855", score: 886, year: 110), ChartScore(title: "商管：818.5 英語：829.5", score: 829.5, year: 111)]
            //MARK: 國立高雄科技大學
        case "國立高雄科技大學\n工業工程與管理系":
            return [ChartScore(title: "機械：506 工管：443 商管：547.5", score: 547.5, year: 108), ChartScore(title: "機械：435.5 工管：516.5 商管：528", score: 528, year: 109), ChartScore(title: "機械：471 工管：364.5 商管：537.5", score: 537.5, year: 110), ChartScore(title: "機械：401 工管：335 商管：469", score: 469, year: 111), ChartScore(title: "機械：420.5 資電：432 商管：460.25", score: 460.25, year: 112)]
            //MARK: 國立虎尾科技大學
        case "國立虎尾科技大學\n機械與電腦輔助工程系":
            return [ChartScore(title: "機械", score: 523.5, year: 107), ChartScore(title: "機械", score: 441.5, year: 108), ChartScore(title: "機械", score: 386, year: 109), ChartScore(title: "機械", score: 437, year: 110), ChartScore(title: "機械：343 動機：301", score: 343, year: 111), ChartScore(title: "機械：343 動機：352.5", score: 352.5, year: 112)]
        case "國立虎尾科技大學\n材料科學與工程系":
            return [ChartScore(title: "機械：506.75 資電：470 化工：475", score: 506.75, year: 107), ChartScore(title: "機械：427 資電：433.75 化工：410.5", score: 433.75, year: 108), ChartScore(title: "機械：377.5 資電：328.5 化工：352.5", score: 377.5, year: 109), ChartScore(title: "機械：423.5 資電：452 化工：383", score: 452, year: 110), ChartScore(title: "機械：330 資電：331 化工：305.5", score: 331, year: 111), ChartScore(title: "機械：569.5 資電：604 化工：505", score: 604, year: 112)]
        case "國立虎尾科技大學\n機械設計工程系":
            return [ChartScore(title: "機械", score: 509, year: 107), ChartScore(title: "機械", score: 430, year: 108), ChartScore(title: "機械", score: 375.5, year: 109), ChartScore(title: "機械", score: 416.5, year: 110), ChartScore(title: "機械", score: 333, year: 112), ChartScore(title: "機械", score: 398, year: 112)]
        case "國立虎尾科技大學\n動力機械工程系":
            return [ChartScore(title: "機械：507.5 動機：453", score: 507.5, year: 107), ChartScore(title: "機械：426.5 動機：415", score: 426.5, year: 108), ChartScore(title: "機械：364.5 動機：363.5", score: 364.5, year: 109), ChartScore(title: "機械：409 動機：373", score: 409, year: 110), ChartScore(title: "機械：322.5 動機：309 電機：363.5", score: 363.5, year: 111), ChartScore(title: "機械：345.5 動機：340 電機：344.5", score: 345.5, year: 112)]
        case "國立虎尾科技大學\n自動化工程系":
            return [ChartScore(title: "機械：546.5 電機：536", score: 546.5, year: 107), ChartScore(title: "機械：469.5 電機：447", score: 469.5, year: 108), ChartScore(title: "機械：400 電機：427.5", score: 427.5, year: 109), ChartScore(title: "機械：454 電機：460.5", score: 460.5, year: 110), ChartScore(title: "機械：339.25 電機：376.25", score: 376.25, year: 111), ChartScore(title: "機械：366 電機：368", score: 368, year: 112)]
            //MARK: 國立屏東科技大學
        case "國立屏東科技大學\n機械工程系":
            return [ChartScore(title: "機械：483 動機：466", score: 483, year: 107), ChartScore(title: "機械：532.75 動機：527.75", score: 532.75, year: 108), ChartScore(title: "機械：454.5 動機：540.75", score: 540.75, year: 109), ChartScore(title: "機械：531.25 動機：509.63", score: 531.25, year: 110), ChartScore(title: "機械：436.75 動機：458.75", score: 458.75, year: 111)]
        case "國立屏東科技大學\n生物機電工程系":
            return [ChartScore(title: "機械：481 動機：464.5 電機：505", score: 505, year: 107), ChartScore(title: "機械：419.5 動機：412.5 電機：442", score: 442, year: 108), ChartScore(title: "機械：471.25 動機：477.75 電機：580.5", score: 580.5, year: 109), ChartScore(title: "機械：518.5 動機：487.75 電機：539.5", score: 539.5, year: 110), ChartScore(title: "機械：430.5 動機：408.5 電機：432", score: 432, year: 111)]
        case "國立屏東科技大學\n智慧機電學士學位學程":
            return [ChartScore(title: "機械：375.5 電機：349 農業：473", score: 473, year: 111)]
        case "國立屏東科技大學\n先進材料學士學位學程":
            return [ChartScore(title: "機械：478.25 電機：483.5", score: 483.5, year: 107), ChartScore(title: "機械：418 電機：430", score: 430, year: 108), ChartScore(title: "機械：365.5 電機：439 化工：351.5", score: 439, year: 109), ChartScore(title: "電機：383 化工：376.5", score: 383, year: 110)]
        case "國立屏東科技大學\n車輛工程系":
            return [ChartScore(title: "動機", score: 489.75, year: 107), ChartScore(title: "動機", score: 545, year: 108), ChartScore(title: "動機", score: 492.25, year: 109), ChartScore(title: "動機：517.75 電機：525.5", score: 525.5, year: 110), ChartScore(title: "動機：433.75 電機：434.63", score: 434.63, year: 111)]
        case "國立屏東科技大學\n木材科學與設計系":
            return [ChartScore(title: "土木：409.5 設計：521 農業：547.5", score: 547.5, year: 107), ChartScore(title: "土木：426.5 設計：516 農業：495", score: 516, year: 108), ChartScore(title: "土木：367 設計：511 農業：522.75", score: 522.75, year: 109), ChartScore(title: "土木：379.5 設計：485 農業：361", score: 485, year: 110), ChartScore(title: "土木：352.75 設計：470 農業：383", score: 470, year: 111)]
        case "國立屏東科技大學\n土木工程系":
            return [ChartScore(title: "土木", score: 383, year: 107), ChartScore(title: "土木", score: 401.5, year: 108), ChartScore(title: "土木", score: 337.5, year: 109), ChartScore(title: "土木", score: 350, year: 110), ChartScore(title: "土木", score: 297, year: 111)]
        case "國立屏東科技大學\n水土保持系":
            return [ChartScore(title: "土木：372 農業：460.5", score: 460.5, year: 107), ChartScore(title: "土木：496.75 農業：550.75", score: 550.75, year: 108), ChartScore(title: "土木：433.25 農業：631", score: 631, year: 109), ChartScore(title: "土木：433.5 農業：447", score: 447, year: 110), ChartScore(title: "土木：352.25 農業：419.5", score: 419.5, year: 111)]
        case "國立屏東科技大學\n環境工程與科學系":
            return [ChartScore(title: "工管：457 衛護：440.5 農業：488", score: 488, year: 107), ChartScore(title: "工管：372.5 衛護：496.5 農業：429", score: 496.5, year: 108), ChartScore(title: "工管：387.5 衛護：455 農業：440", score: 455, year: 109), ChartScore(title: "化工：269.5 工管：242.5 衛護：431.5", score: 431.5, year: 110), ChartScore(title: "電機：309.75 化工：212 衛護：262", score: 309.75, year: 111)]
        case "國立屏東科技大學\n材料工程系":
            return [ChartScore(title: "電機：327.5 化工：321.75", score: 327.5, year: 111)]
        case "國立屏東科技大學\n資訊管理系":
            return [ChartScore(title: "商管", score: 505.5, year: 107), ChartScore(title: "商管", score: 575, year: 108), ChartScore(title: "商管", score: 531.5, year: 109), ChartScore(title: "商管", score: 572, year: 110), ChartScore(title: "商管", score: 443.5, year: 111)]
        case "國立屏東科技大學\n工業管理系":
            return [ChartScore(title: "商管", score: 493.5, year: 107), ChartScore(title: "商管", score: 472, year: 108), ChartScore(title: "商管", score: 545.94, year: 109), ChartScore(title: "商管", score: 582.81, year: 110), ChartScore(title: "商管", score: 452.5, year: 111)]
        case "國立屏東科技大學\n企業管理系":
            return [ChartScore(title: "商管", score: 499.5, year: 107), ChartScore(title: "商管", score: 607.5, year: 108), ChartScore(title: "商管", score: 556.75, year: 109), ChartScore(title: "商管", score: 603.25, year: 110), ChartScore(title: "商管", score: 490, year: 111)]
        case "國立屏東科技大學\n財務金融國際學士學位學程":
            return [ChartScore(title: "商管", score: 550.5, year: 107), ChartScore(title: "商管", score: 684, year: 108), ChartScore(title: "商管", score: 649, year: 109), ChartScore(title: "商管", score: 646.5, year: 110), ChartScore(title: "商管", score: 542, year: 111)]
        case "國立屏東科技大學\n應用外語系":
            return [ChartScore(title: "商管：510.75 幼保：541.5 英語：509", score: 541.5, year: 107), ChartScore(title: "商管：483 幼保：499.5 英語：511", score: 511, year: 108), ChartScore(title: "商管：433 幼保：422.5 英語：516.5", score: 516.5, year: 109), ChartScore(title: "商管：469.5 幼保：502 英語：460", score: 502, year: 110), ChartScore(title: "商管：360 幼保：442 英語：405.75", score: 442, year: 111)]
        case "國立屏東科技大學\n社會工作系":
            return [ChartScore(title: "商管：500 幼保：514", score: 514, year: 107), ChartScore(title: "商管：466 幼保：494", score: 494, year: 108), ChartScore(title: "商管：444 衛護：498.5 幼保：452", score: 498.5, year: 109), ChartScore(title: "商管：463 衛護：423 幼保：483.5", score: 483.5, year: 110), ChartScore(title: "商管：386 衛護：372 幼保：459.5", score: 459.5, year: 111)]
        case "國立屏東科技大學\n休閒運動健康系":
            return [ChartScore(title: "商管：498 餐旅：564", score: 564, year: 107), ChartScore(title: "商管：465 餐旅：542", score: 542, year: 108), ChartScore(title: "商管：434.25 英語：503 餐旅：560.5", score: 560.5, year: 109), ChartScore(title: "商管：464.5 英語：433.5 餐旅：528", score: 528, year: 110), ChartScore(title: "商管：394 英語：388 餐旅：494", score: 494, year: 111)]
        case "國立屏東科技大學\n水產養殖系":
            return [ChartScore(title: "衛護：504.5 農業：554 水產：402", score: 554, year: 107), ChartScore(title: "衛護：522 農業：475 水產：403", score: 522, year: 108), ChartScore(title: "衛護：579.75 農業：503.25 水產：259.5", score: 579.75, year: 109), ChartScore(title: "衛護：605.75 農業：436.5 水產：301.5", score: 605.75, year: 110), ChartScore(title: "衛護：351 農業：373 水產：276", score: 373, year: 111)]
        case "國立屏東科技大學\n生物科技系":
            return [ChartScore(title: "衛護：478.5 食品：468.5 農業：532", score: 532, year: 107), ChartScore(title: "衛護：749.5 食品：640.5 農業：713.5", score: 749.5, year: 108), ChartScore(title: "衛護：834 食品：540 農業：713.5", score: 834, year: 109), ChartScore(title: "衛護：749 食品：578 農業：583", score: 749, year: 110), ChartScore(title: "化工：364.5 食品：473.5 農業：542.5", score: 542.5, year: 111)]
        case "國立屏東科技大學\n食品科學系":
            return [ChartScore(title: "食品", score: 526.5, year: 107), ChartScore(title: "食品", score: 505.25, year: 108), ChartScore(title: "食品", score: 468.75, year: 109), ChartScore(title: "食品", score: 391.5, year: 110), ChartScore(title: "食品", score: 361, year: 111)]
        case "國立屏東科技大學\n餐旅管理系":
            return [ChartScore(title: "食品：540 生活：462.5 餐旅：570", score: 570, year: 107), ChartScore(title: "食品：655 生活：604 餐旅：840", score: 840, year: 108), ChartScore(title: "食品：520 生活：613 餐旅：778", score: 778, year: 109), ChartScore(title: "食品：554 生活：649.5 餐旅：800.5", score: 800.5, year: 110), ChartScore(title: "食品：397 生活：698.5 餐旅：733.5", score: 733.5, year: 111)]
        case "國立屏東科技大學\n幼兒保育系":
            return [ChartScore(title: "幼保", score: 514, year: 107), ChartScore(title: "幼保", score: 714.88, year: 108), ChartScore(title: "幼保", score: 643.25, year: 109), ChartScore(title: "幼保", score: 682.5, year: 110), ChartScore(title: "幼保", score: 676.88, year: 111)]
        case "國立屏東科技大學\n時尚設計與管理系":
            return [ChartScore(title: "生活", score: 521.5, year: 107), ChartScore(title: "生活", score: 428.25, year: 108), ChartScore(title: "生活", score: 477.5, year: 109), ChartScore(title: "生活", score: 422, year: 110), ChartScore(title: "生活", score: 469, year: 111)]
        case "國立屏東科技大學\n農園生產系":
            return [ChartScore(title: "農業", score: 487, year: 107), ChartScore(title: "農業", score: 429, year: 108), ChartScore(title: "農業", score: 416, year: 109), ChartScore(title: "農業", score: 345, year: 110), ChartScore(title: "農業", score: 338.5, year: 111)]
        case "國立屏東科技大學\n森林系":
            return [ChartScore(title: "農業", score: 478, year: 107), ChartScore(title: "農業", score: 449.5, year: 108), ChartScore(title: "農業", score: 455, year: 109), ChartScore(title: "農業", score: 401.5, year: 110), ChartScore(title: "農業", score: 371.5, year: 111)]
        case "國立屏東科技大學\n動物科學與畜產系":
            return [ChartScore(title: "農業", score: 602.5, year: 107), ChartScore(title: "農業", score: 547, year: 108), ChartScore(title: "衛護：462 農業：553.5", score: 553.5, year: 109), ChartScore(title: "農業", score: 505, year: 110), ChartScore(title: "農業", score: 498.25, year: 111)]
        case "國立屏東科技大學\n植物醫學系":
            return [ChartScore(title: "農業", score: 482, year: 107), ChartScore(title: "農業", score: 540, year: 108), ChartScore(title: "農業", score: 566, year: 109), ChartScore(title: "農業", score: 360, year: 110), ChartScore(title: "農業", score: 412, year: 111)]
        case "國立屏東科技大學\n農企業管理系":
            return [ChartScore(title: "農業", score: 473.5, year: 107), ChartScore(title: "農業", score: 418, year: 108), ChartScore(title: "農業", score: 423.5, year: 109), ChartScore(title: "農業", score: 282, year: 110), ChartScore(title: "農業", score: 342, year: 111)]
        case "國立屏東科技大學\n熱帶農業暨國際合作系":
            return [ChartScore(title: "農業：495.5 水產：395", score: 495.5, year: 107), ChartScore(title: "農業：615 水產：456.5", score: 615, year: 108), ChartScore(title: "農業", score: 611, year: 109), ChartScore(title: "農業", score: 293, year: 110), ChartScore(title: "農業", score: 416, year: 111)]
        case "國立屏東科技大學\n獸醫學系":
            return [ChartScore(title: "農業", score: 654.5, year: 107), ChartScore(title: "農業", score: 604.5, year: 108), ChartScore(title: "農業", score: 621, year: 109), ChartScore(title: "農業", score: 613, year: 110), ChartScore(title: "農業", score: 585, year: 111)]
        case "國立臺南護理專科學校\n化妝品應用科":
            return [ChartScore(title: "設計：527.5 家政群生活應用類：219.5", score: 527.5, year: 107), ChartScore(title: "設計：772.5 家政群生活應用類：350", score: 772.5, year: 108), ChartScore(title: "設計：692.5 家政群生活應用類：546", score: 692.5, year: 109), ChartScore(title: "設計：748 家政群生活應用類：607", score: 748, year: 110), ChartScore(title: "家政群生活應用類", score: 682, year: 111), ChartScore(title: "家政群生活應用類", score: 534, year: 112)]
        default:
            return []
        }
    }
}
