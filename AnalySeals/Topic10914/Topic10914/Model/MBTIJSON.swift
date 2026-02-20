//
//  MBTIJSON.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/25.
//

import Foundation

struct MBTIJSON: Codable
{
    var personality_type: String
    var type_code: String
    var analysis: String
    var mind_type: String
    var mind_content: String
    var energy_type: String
    var energy_content: String
    var nature_type: String
    var nature_content: String
    var tactics_type: String
    var tactics_content: String
    var identity_type: String
    var identity_content: String
    
    //MARK: 人格特質中文
    func chinesePersonality() -> String
    {
        let type: String=self.personality_type
        
        if(type=="Architect")
        {
            return "建築師"
        }
        else if(type=="Logician")
        {
            return "邏輯學家"
        }
        else if(type=="Commander")
        {
            return "指揮官"
        }
        else if(type=="Debater")
        {
            return "辯論家"
        }
        else if(type=="Advocate")
        {
            return "提倡者"
        }
        else if(type=="Mediator")
        {
            return "調停者"
        }
        else if(type=="Protagonist")
        {
            return "主人公"
        }
        else if(type=="Campaigner")
        {
            return "競選者"
        }
        else if(type=="Logistician")
        {
            return "物流師"
        }
        else if(type=="Defender")
        {
            return "守衛者"
        }
        else if(type=="Executive")
        {
            return "總經理"
        }
        else if(type=="Consul")
        {
            return "執政官"
        }
        else if(type=="Virtuoso")
        {
            return "鑑賞家"
        }
        else if(type=="Adventurer")
        {
            return "探險家"
        }
        else if(type=="Entrepreneur")
        {
            return "企業家"
        }
        else if(type=="Entertainer")
        {
            return "表演者"
        }
        return ""
    }
    //MARK: 推薦科系
    func getDepartment(career: String) -> String
    {
        var department: [String]=[]
        var result: String=""
        
        if(career=="金融家")
        {
            department.append("數學")
            department.append("金融學")
            department.append("會計學")
            department.append("經濟學")
            department.append("統計學")
            department.append("資訊科學")
            department.append("資訊管理學")
            department.append("國際企業學")
            department.append("國際貿易學")
            department.append("商業管理學")
            department.append("財務管理學")
        }
        else if(career=="律師")
        {
            department.append("法律學")
            department.append("政治學")
            department.append("外交學")
            department.append("心理學")
            department.append("公共事務學")
            department.append("公共行政學")
            department.append("公共行政與政策學")
            department.append("公共行政暨政策學")
            department.append("社會工作學")
            department.append("行政管理學")
            department.append("犯罪防治學")
            department.append("國際事務與企業學")
            department.append("法律學士學位學程")
            department.append("海洋法政學士學位學程")
        }
        else if(career=="建築工程學家")
        {
            department.append("建築學")
            department.append("土木工程學")
            department.append("機械工程學")
            department.append("電機工程學")
            department.append("環境工程學")
            department.append("都市計畫學")
            department.append("都市計畫與開發管理學")
            department.append("都市計畫與空間資訊學")
        }
        else if(career=="研究開發人員")
        {
            department.append("工程科學")
            department.append("機械工程學")
            department.append("航空工程學")
            department.append("土木工程學")
            department.append("水利工程學")
            department.append("化學工程學")
            department.append("材料工程學")
            department.append("生醫工程學")
            department.append("環境工程學")
            department.append("資訊工程學")
            department.append("電機工程學")
            department.append("光電工程學")
            department.append("電子工程學")
            department.append("通訊工程學")
            department.append("資訊管理學")
        }
        else if(career=="軟體設計師")
        {
            department.append("資訊工程學")
            department.append("資訊管理學")
            department.append("媒體設計學")
            department.append("電子工程學")
        }
        else if(career=="電腦工程師")
        {
            department.append("電機工程學")
            department.append("電子工程學")
            department.append("資訊工程學")
            department.append("資訊管理學")
        }
        else if(career=="軟硬體工程師")
        {
            department.append("資訊工程學")
            department.append("資訊管理學")
            department.append("媒體設計學")
            department.append("電子工程學")
            department.append("電機工程學")
        }
        else if(career=="業務")
        {
            department.append("保險學")
            department.append("行銷學")
            department.append("管理學")
            department.append("商船學")
            department.append("航運管理學")
            department.append("企業管理學")
            department.append("運輸管理學")
            department.append("運輸科學")
            department.append("運輸與物流學")
            department.append("行銷與流通管理學")
        }
        else if(career=="行政經理")
        {
            department.append("政治經濟學")
            department.append("公共事務學")
            department.append("公共行政學")
            department.append("行政管理學")
            department.append("公共行政與政策學")
            department.append("公共行政暨政策學")
        }
        else if(career=="銀行")
        {
            department.append("管理學")
            department.append("保險學")
            department.append("金融學")
            department.append("會計學")
            department.append("經濟學")
            department.append("統計學")
            department.append("資訊科學")
            department.append("資訊管理學")
            department.append("國際企業學")
            department.append("國際貿易學")
            department.append("商業管理學")
            department.append("財務管理學")
        }
        else if(career=="攝影師")
        {
            department.append("攝影學")
            department.append("傳播學")
            department.append("圖文傳播學")
            department.append("大眾傳播學")
            department.append("圖文傳播藝術學")
            department.append("廣播電視電影學")
        }
        else if(career=="廣告業" || career=="企劃工作")
        {
            department.append("廣告學")
            department.append("攝影學")
            department.append("傳播學")
            department.append("圖文傳播學")
            department.append("大眾傳播學")
            department.append("圖文傳播藝術學")
            department.append("廣播電視電影學")
            department.append("公共關係暨廣告學")
        }
        else if(career=="社工" || career=="治療業" || career=="心靈工作者")
        {
            department.append("心理學")
            department.append("社會學")
            department.append("幼兒保育")
            department.append("社會福利學")
            department.append("社會工作學")
            department.append("幼兒教育學")
            department.append("兒童與家庭學")
            department.append("兒童與家庭服務")
            department.append("幼兒保育暨產業")
            department.append("諮商與臨床心理學")
            department.append("兒童與家庭科學學")
            department.append("兒童教育暨事業經營")
            department.append("兒童發展與家庭教育學")
            department.append("家庭研究與兒童發展學")
            department.append("社會政策與社會工作學")
            department.append("醫學社會學與社會工作學")
        }
        else if(career=="作家")
        {
            department.append("文學")
            department.append("戲劇學")
            department.append("歷史學")
            department.append("新聞學")
            department.append("臺灣文學")
            department.append("中國文學")
            department.append("中國語文")
            department.append("創意設計學")
            department.append("臺灣語文學")
            department.append("外國語文學")
            department.append("創意產業學")
            department.append("創意實踐學")
            department.append("大眾傳播學")
            department.append("創意與傳播")
            department.append("文學與創作學")
            department.append("創意產業設計學")
            department.append("傳播與創意產業學")
            department.append("文學創作與表演學")
        }
        else if(career=="記者")
        {
            department.append("傳播學")
            department.append("新聞學")
            department.append("大眾傳播學")
            department.append("傳媒科技學")
            department.append("新聞傳播學")
            department.append("傳播藝術學")
            department.append("創意媒體學")
            department.append("創意設計學")
            department.append("網路傳播科學")
            department.append("多媒體動畫學")
            department.append("數位媒體設計學")
            department.append("視覺傳達設計學")
            department.append("互動媒體設計學")
            department.append("數位多媒體設計學")
            department.append("傳播與動畫藝術學")
            department.append("大眾傳播與廣告學")
            department.append("新聞與大眾傳播學")
            department.append("傳播暨科技管理學")
            department.append("傳播與科技管理學")
        }
        else if(career=="演員")
        {
            department.append("新聞學")
            department.append("傳播學")
            department.append("廣告學")
            department.append("公共關係學")
            department.append("廣播電視學")
            department.append("數位媒體設計")
            department.append("多媒體設計")
            department.append("廣告傳播設計")
            department.append("公共事務管理")
            department.append("企業傳播管理")
            department.append("傳播與科技管理")
            department.append("傳播學與科技學")
            department.append("媒體傳播")
            department.append("數位媒體設計與管理")
            department.append("新聞傳播學")
            department.append("廣告傳播學")
            department.append("數位媒體學")
            department.append("公共關係與廣告學")
            department.append("數位內容科技")
            department.append("資訊傳播工程學")
            department.append("傳播科技與管理學")
            department.append("大眾傳播學")
            department.append("新聞與大眾傳播學")
            department.append("傳播與國際事務學")
            department.append("文化創意產業學")
            department.append("創意行銷與傳播管理")
            department.append("科技傳播與管理學")
            department.append("資訊與傳播學")
            department.append("科技媒體與行銷學")
            department.append("數位多媒體設計")
            department.append("創新設計學")
            department.append("文化創意產業創新設計學")
            department.append("數位科技設計")
            department.append("科技創意設計")
            department.append("數位學習科技")
            department.append("數位科技設計學")
            department.append("數位多媒體設計與管理學")
            department.append("數位多媒體科技學")
            department.append("數位科技傳播學")
            department.append("傳播科技")
            department.append("數位傳播設計學")
            department.append("數位內容科技學")
            department.append("數位科技應用學")
            department.append("科技傳播學")
            department.append("新媒體傳播學")
            department.append("新聞與資訊傳播學")
            department.append("傳播技術與科技學")
            department.append("資訊科技傳播學")
            department.append("數位媒體設計系")
            department.append("創意行銷與傳播管理系")
            department.append("數位媒體設計系")
            department.append("創意行銷與傳播管理系")
            department.append("新聞學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("新聞學學士學位學程")
            department.append("傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("資訊傳播學學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞與資訊傳播學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("資訊與傳播學士學位學程")
            department.append("新聞傳播學系學士學位學程")
            department.append("新聞學學位學程")
            department.append("傳播學學位學程")
            department.append("科技傳播學學位學程")
            department.append("新聞傳播學學位學程")
            department.append("新聞與資訊傳播學學位學程")
            department.append("大眾傳播學學位學程")
            department.append("資訊與傳播學學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
            department.append("新聞傳播學士學位學程")
            department.append("新聞學士學位學程")
            department.append("大眾傳播學士學位學程")
            department.append("傳播學士學位學程")
            department.append("科技傳播學士學位學程")
            department.append("新聞傳播學學士學位學程")
            department.append("新聞與資訊傳播學學士學位學程")
            department.append("大眾傳播學學士學位學程")
            department.append("資訊與傳播學學士學位學程")
        }
        else if(career=="政治人物")
        {
            department.append("政治學")
            department.append("法律學")
            department.append("公共關係學")
            department.append("公共事務學")
            department.append("國際事務學")
            department.append("外交學")
            department.append("公共事務學")
            department.append("公共行政學")
            department.append("公共行政與政策學")
            department.append("公共行政暨政策學")
            department.append("行政管理學")
            department.append("國際事務與企業學")
            department.append("法律學士學位學程")
        }
        else if(career=="藝術家")
        {
            department.append("戲劇學")
            department.append("音樂學")
            department.append("美術學")
            department.append("舞蹈學")
            department.append("景觀學")
            department.append("建築學")
            department.append("工業設計")
            department.append("視覺傳達設計")
            department.append("創意產業設計")
            department.append("藝術與文學學系")
            department.append("數位媒體設計")
        }
        else if(career=="空服員")
        {
            department.append("航空事業管理")
            department.append("飛行技術")
            department.append("航空運輸管理")
            department.append("交通管理科學系")
            department.append("運輸科技與管理")
            department.append("機場與航空管理")
            department.append("旅遊事業管理")
            department.append("休閒事業管理")
            department.append("國際企業管理")
            department.append("企業管理")
            department.append("人力資源管理")
            department.append("行銷管理")
        }
        
        //去除重複科系
        if(!department.isEmpty)
        {
            department=Array(Set(department)).sorted()
            
            for i in department
            {
                result.append((i.contains("學位學程") ? "\(i)":"\(i)系").appending("\n"))
            }
            //去除最後的換行符號
            result=result[0...result.count-2]
        }
        else
        {
            result.append("尚無科系資料")
        }
        
        return result
    }
    //MARK: 性格中文分析
    func setAnalysisC() -> String
    {
        let type: String=self.type_code[0...3]
        
        if(type=="INTJ")
        {
            return "相當獨立、樂於獨處。\n不太會受他人的評價影響，但也因而容易被認為傲慢。"
        }
        else if(type=="INTP")
        {
            return "熱愛追求知識、富有創造力。\n在應對上具有理性特質，因此在處事上難以共情，甚至會給人高高在上的感覺。"
        }
        else if(type=="ENTJ")
        {
            return "擅長用規範和經驗渲染他人，相當具有領導風範的類型，但是執著、硬派的管理風格，常常會帶給身邊人壓力。"
        }
        else if(type=="ENTP")
        {
            return "總是有用不完的點子，能夠不斷發展出新的道路，是相當受人景仰的人格類型。\n對於自己的意見深信不疑，也讓他們容易對別人產生疑慮。"
        }
        else if(type=="INFJ")
        {
            return "天生有著強烈的道德和理想，樂於付諸行動去幫助他人，但也因為過度追求完美，常常會有壓力過度的狀況。"
        }
        else if(type=="INFP")
        {
            return "外表看上去難以親近，但其實是外冷內熱的創意大師。\n相當理想化，也容易因此受騙。"
        }
        else if(type=="ENFJ")
        {
            return "天生就有吸引人的特質，因此很容易影響他人，自己也常常會擔心、胡思亂想，進而讓支持者或朋友受到影響。"
        }
        else if(type=="ENFP")
        {
            return "能夠為了理想拼命，會不斷反思自己的人生經驗。\n過於好奇的個性，也讓他們注意力較低落。"
        }
        else if(type=="ISTJ")
        {
            return "正直、腳踏實地、高效率。\n頗受傳統組織歡迎，但也比較不易離開舒適圈。"
        }
        else if(type=="ISFJ")
        {
            return "天性和善、使人安心。\n較不會表達自己的需求，缺乏領導力、觀念上也較保守。"
        }
        else if(type=="ESTJ")
        {
            return "做事投入、喜歡團隊合作。\n個性上循規蹈矩，所以比較無法發展出新的創意。"
        }
        else if(type=="ESFJ")
        {
            return "善於鼓勵他人、熱於關注周遭狀況，但常常花太多心力在別人身上，導致自己的心情容易受影響。"
        }
        else if(type=="ISTP")
        {
            return "熱於追求成就感，特別是親手實作、解決難題等，因此更喜歡和機器、機械相處。\n不太擅長處理人際關係。"
        }
        else if(type=="ISFP")
        {
            return "喜歡在生活上追求變化，環境適應力高、想像力豐富。\n個性上有點衝動，沒辦法靜下心來完成一套規劃。"
        }
        else if(type=="ESTP")
        {
            return "熱愛冒險、做事追求做到好，面對突發狀況也得心應手，但比較無法適應傳統組織，也相對缺乏耐心。"
        }
        else if(type=="ESFP")
        {
            return "表演慾旺盛、樂於嘗試新鮮事，然而面對一成不變的環境，卻容易覺得無聊而分心。\n活在當下、不太會規劃未來。"
        }
        return ""
    }
    //MARK: 性格英文分析
    func setAnalysisE() -> String
    {
        let type: String=self.type_code[0...3]
        
        if(type=="INTJ")
        {
            return "Quite independent and happy to be alone. \nIt is not easy to be influenced by other people's evaluation, but it is also easy to be regarded as arrogant."
        }
        else if(type=="INTP")
        {
            return "Love to pursue knowledge and be creative. \nThey have a rational characteristic in dealing with it, so it is difficult to ally ally deal with things, and it will even give people a sense of superior."
        }
        else if(type=="ENTJ")
        {
            return "They are good at rendering others with norms and experience, which is quite a leading style, but the persistent and hard-line management style often brings pressure to people around him."
        }
        else if(type=="ENTP")
        {
            return "There are always endless ideas and the ability to constantly develop new paths, which is a highly admired personality type. \nThe belief in their own opinions also makes it easy for them to have doubts about others."
        }
        else if(type=="INFJ")
        {
            return "Born with strong morals and ideals, willing to take action to help others, but because of their excessive pursuit of perfection, they often has excessive pressure."
        }
        else if(type=="INFP")
        {
            return "It looks difficult to get close to, but in fact, they are a creative master who is cold outside and hot inside. \nQuite idealistic and easy to be deceived."
        }
        else if(type=="ENFJ")
        {
            return "Born with attractive characteristics, so it is easy to influence others, and they often worry and think nonsense, which will affect supporters or friends."
        }
        else if(type=="ENFP")
        {
            return "Work hard for ideals and constantly reflect on life experience. \nOverly curious personality also makes them pay less attention."
        }
        else if(type=="ISTJ")
        {
            return "Integrity, down-to-earth and efficient. \nIt is quite popular with traditional organizations, but it is not easy to leave the comfort zone."
        }
        else if(type=="ISFJ")
        {
            return "Nature and kindness make people feel at ease. \nLess likely to express needs, lack leadership, and more conservative in concept."
        }
        else if(type=="ESTJ")
        {
            return "They are committed to doing things and like teamwork. \nThe personality follows the rules, so it is relatively difficult to develop new ideas."
        }
        else if(type=="ESFJ")
        {
            return "Good at encouraging others and paying attention to the surrounding situation, but often spend too much effort on others, which makes mood easily affected."
        }
        else if(type=="ISTP")
        {
            return "They are passionate about pursuing a sense of accomplishment, especially by hand, solving problems, et cetera., so they prefer to get along with machines and machines. \n They are not very good at dealing with interpersonal relationships."
        }
        else if(type=="ISFP")
        {
            return "They like to pursue change in life, with high environmental adaptability and rich imagination. \nThey are a little impulsive in personality, and they can not calm down to complete a set of plans."
        }
        else if(type=="ESTP")
        {
            return "They love adventure and pursue doing things well. They are also proficient in the face of sudden situations, but they are relatively unable to adapt to traditional organizations and are relatively impatient."
        }
        else if(type=="ESFP")
        {
            return "They are eager to perform and willing to try new things, but in the face of an unchanging environment, they are easy to feel bored and distracted. \nLive in the present and don't know much about planning for the future."
        }
        return ""
    }
    //MARK: 職業推薦
    func setCareer() -> String
    {
        let type: String=self.type_code[0...3]
        
        if(type=="INTJ")
        {
            return "金融家\n律師\n建築工程學家"
        }
        else if(type=="INTP")
        {
            return "研究開發人員\n軟體設計師\n電腦工程師"
        }
        else if(type=="ENTJ")
        {
            return "業務\n行政經理\n金融家\n銀行"
        }
        else if(type=="ENTP")
        {
            return "律師\n辯論家\n攝影師\n廣告業"
        }
        else if(type=="INFJ")
        {
            return "社工\n調解人員\n占卜師\n治療業"
        }
        else if(type=="INFP")
        {
            return "心靈工作者\n作家\n記者\n演員"
        }
        else if(type=="ENFJ")
        {
            return "演講家\n教練\n導遊\n政治人物"
        }
        else if(type=="ENFP")
        {
            return "藝術家\n空服員\n記者\n企劃工作"
        }
        else if(type=="ISTJ")
        {
            return "公務員\n軍官\n保安"
        }
        else if(type=="ISFJ")
        {
            return "醫療工作\n服務業\n餐飲業"
        }
        else if(type=="ESTJ")
        {
            return "金融工作\n管理工作\n行政主管"
        }
        else if(type=="ESFJ")
        {
            return "教育\n文職工作\n活動企劃"
        }
        else if(type=="ISTP")
        {
            return "軟硬體工程師\n技師\n機師"
        }
        else if(type=="ISFP")
        {
            return "藝術家\n作家\n廚師"
        }
        else if(type=="ESTP")
        {
            return "旅遊工作者\n主持人\n設計師"
        }
        else if(type=="ESFP")
        {
            return "室內設計師\n服裝設計師\n藝術家\n音樂家"
        }
        return ""
    }
}
