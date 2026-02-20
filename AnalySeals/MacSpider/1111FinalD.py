# 詳細註解看1111FinalT.py
import time
import json
from bs4 import BeautifulSoup
from collections import OrderedDict
from flask import Flask, jsonify, request, Response
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import NoSuchElementException, TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# http://127.0.0.1:8000/crawler?type=商業&score_1=90&score_2=80&score_3=70&score_4=89&score_5=78
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
@app.route("/crawler", methods=["GET"])

def crawler():
        # 從 GET 參數中取得
        Application_Type = request.args.get("type")
        score_chinese = request.args.get("score_1")
        score_english = request.args.get("score_2")
        score_math = request.args.get("score_3")
        score_subject1 = request.args.get("score_4")
        score_subject2 = request.args.get("score_5")

        # 如果沒有指定數字，回傳錯誤訊息
        if None in [
            Application_Type,
            score_chinese,
            score_english,
            score_math,
            score_subject1,
            score_subject2,
        ]:
            return jsonify({"error": "請提供所有必要的參數"})
        # -----

        # 阻止日誌發送消息出現在控制台上
        options = webdriver.ChromeOptions()
        options.add_argument("start-maximized")
        options.add_experimental_option("excludeSwitches", ["enable-logging"])
        # ---

        loute = Service("/Users/tsengpinruei/Desktop/crawler/chromedriver-mac-arm64/chromedriver")
        driver = webdriver.Chrome(options=options, service=loute)
        driver.get("https://hs.1111.com.tw/techAnalysisInputReg.aspx")
        # -----
        wait = WebDriverWait(driver, 1)  # 創建WebDriverWait對象，最多等10秒
        # 點擊按鈕
        time.sleep(1)
        chkgroup = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//label[contains(text(), '" + Application_Type + "' )]"))))
        chkgroup.click()

        # 輸入資料
        chinese = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam1")))
        chinese.send_keys(int(score_chinese))

        english = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam2")))
        english.send_keys(score_english)

        math = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam3")))
        math.send_keys(score_math)

        subject1 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam4")))
        subject1.send_keys(score_subject1)

        subject2 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam5")))
        subject2.send_keys(score_subject2)

        time.sleep(1)

        # 點擊下一步
        button1 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$lbtn")))
        button1.click()

        time.sleep(1)

        # 第二頁
        # 爬取全部學校名稱
        school = driver.find_elements(By.XPATH, ".//label[contains(text(), '大學')]")
        all_school = []
        print("以下為結果 :")
        for i in range(len(school)):
            all_school.append(school[i].text)
        print(all_school)

        # 點擊結果分析
        button2 = wait.until(EC.visibility_of_element_located((By.ID, "testBtn2")))
        button2.click()

        driver.execute_script("window.scrollTo(0, 0);")

        # 點擊確定
        button3 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$Button2")))
        button3.click()

        # 第三頁
        chance_key = ["夢幻校系", "嘗試進攻", "最適落點", "保守選填", "安全穩固", "極具優勢", "其他參考"]
        chance_value_id = [
            "lbldiffscore2",
            "lbldiffscore3",
            "lbldiffscore4",
            "lbldiffscore5",
            "lbldiffscore6",
            "lbldiffscore7",
            "lbldiffscore0",
        ]
        chance_dict = OrderedDict()

        # 嘗試進攻、最適落點、保守選項需登入會員
        # 點擊按鈕(登入)
        time.sleep(2)
        go_login = wait.until(EC.visibility_of_element_located((By.XPATH, ".//a[contains(text(), '會員登入')]")))
        go_login.click()

        acc = wait.until(EC.visibility_of_element_located((By.NAME, "id")))
        acc.click()
        acc.send_keys("H225584089")
        pw = wait.until(EC.visibility_of_element_located((By.NAME, "pass")))
        pw.click()
        pw.send_keys("topicgood123")

        login = wait.until(EC.visibility_of_element_located((By.ID, "smlogin")))
        login.click()

        for i in range(len(chance_value_id)):
            value1 = wait.until(EC.visibility_of_element_located((By.ID, chance_value_id[i]))).text
            chance_dict[chance_key[i]] = value1
        
        print(chance_dict)

        result = chance_dict
        # 點擊結果

        # 注意!!!
        # wait.until(EC.visibility_of_element_located寫法的確會大幅減少時間但是無法存儲資料
        # 如需儲存請用driver.find_elements或driver.find_element

        # ------------------------機會渺茫------------------------
        # 刪除
        # ------------------------------------------------------------

        # ------------------------夢幻校系------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '夢幻校系' )]"))))
        chance.click()

        chance_dic2 = {}
        list2 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list2.append(step_dic)

            chance_dic2["夢幻校系"] = list2
        else:
            list2.append({"無內容": "無內容"})
            chance_dic2["無學校名稱"] = list2
        time.sleep(0.5)

        print("'夢幻校系'執行完成")
        # ------------------------------------------------------------

        # ------------------------嘗試進攻------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '嘗試進攻' )]"))))
        chance.click()

        chance_dic3 = {}
        list3 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list3.append(step_dic)

            chance_dic3["嘗試進攻"] = list3
        else:
            list3.append({"無內容": "無內容"})
            chance_dic3["無學校名稱"] = list3

        print("'嘗試進攻'執行完成")
        # ------------------------------------------------------------

        # ------------------------最適落點------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '最適落點' )]"))))
        chance.click()

        chance_dic4 = {}
        list4 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list4.append(step_dic)

            chance_dic4["最適落點"] = list4
        else:
            list4.append({"無內容": "無內容"})
            chance_dic4["無學校名稱"] = list4
        time.sleep(0.5)

        print("'最適落點'執行完成")
        # ------------------------------------------------------------

        # ------------------------保守選填------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '保守選填' )]"))))
        chance.click()

        chance_dic5 = {}
        list5 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list5.append(step_dic)

            chance_dic5["保守選填"] = list5
        else:
            list5.append({"無內容": "無內容"})
            chance_dic5["無學校名稱"] = list5
        time.sleep(0.5)

        print("'保守選填'執行完成")
        # ------------------------------------------------------------

        # ------------------------安全穩固------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '安全穩固' )]"))))
        chance.click()

        chance_dic6 = {}
        list6 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list6.append(step_dic)

            chance_dic6["安全穩固"] = list6
        else:
            list6.append({"無內容": "無內容"})
            chance_dic6["無學校名稱"] = list6
        time.sleep(0.5)

        print("'安全穩固'執行完成")
        # ------------------------------------------------------------

        # ------------------------極具優勢------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '極具優勢' )]"))))
        chance.click()

        chance_dic7 = {}
        list7 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list7.append(step_dic)

            chance_dic7["極具優勢"] = list7
        else:
            list7.append({"無內容": "無內容"})
            chance_dic7["無學校名稱"] = list7
        time.sleep(0.5)

        print("'極具優勢'執行完成")
        # ------------------------------------------------------------

        '''
        # ------------------------其他參考------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '其他參考' )]"))))
        chance.click()
        '''

        chance_dic8 = {}
        '''
        list8 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}

                time.sleep(0.1)
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("我")
                chance_text = chance_other_text.replace(chance_other_text[replace_index - 1 : :], "")
                step_dic[school_chance[i].text + "_" + subject_chance[3 * i].text] = chance_text
                list8.append(step_dic)

            chance_dic8["其他參考"] = list8
        else:
            list8.append({"無內容": "無內容"})
            chance_dic8["無學校名稱"] = list8
        time.sleep(0.5)

        print("'其他參考'執行完成")
        # ------------------------------------------------------------
        '''
        print("-----結尾-----")

        # ------
        time.sleep(3)
        driver.close()
        # -----

        # 轉換編碼
        # 回傳結果
        # "夢幻校系", "嘗試進攻", "最適落點", "保守選填", "安全穩固", "極具優勢", "其他參考"}
        json_str = json.dumps(
            {
                "result": result,
                "levelDream": chance_dic2,
                "levelTry": chance_dic3,
                "levelFit": chance_dic4,
                "levelCareful": chance_dic5,
                "levelSafe": chance_dic6,
                "levelHigh": chance_dic7,
                "levelOther": chance_dic8,
            },
            ensure_ascii=False,
        )
        return Response(json_str, content_type="application/json")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
