# 引入時間相關模組 用於操作時間相關的函數
import time
# 引入處理 JSON 的模組 用於處理 JSON 格式的資料
import json
# 引入 BeautifulSoup 用於解析HTML
from bs4 import BeautifulSoup
# 引入有序字典
from collections import OrderedDict
# 引入 Flask 相關模組 用於建立和處理網頁應用程式
from flask import Flask, jsonify, request, Response
# 引入 Selenium 庫來實現網頁自動化 可以模擬瀏覽器的操作
from selenium import webdriver
# 引入 Selenium 中的 Chrome Service 來設置和啟動 Chrome 瀏覽器
from selenium.webdriver.chrome.service import Service
# 引入 Selenium 中的例外處理模組
from selenium.common.exceptions import NoSuchElementException, TimeoutException
# 引入 Selenium 中 用於定義一些用於定位元素的方法
from selenium.webdriver.common.by import By
# 引入 Selenium 中的 WebDriverWait 來實現顯式等待 等待特定條件滿足後再繼續執行
from selenium.webdriver.support.ui import WebDriverWait
# 引入 Selenium 中的預期條件 用於結合 WebDriverWait 使用
from selenium.webdriver.support import expected_conditions as EC

# http://127.0.0.1:5000/crawler?type=資管&score_1=60&score_2=70&score_3=80&score_4=78&score_5=89

# 建立一個 Flask 應用程式
# __name__ 參數表示當前模組的名稱 通常用於 Flask 以確定根目錄的位置
app = Flask(__name__)
# 設定 Flask 應用程式的 JSON 轉碼為 UTF-8，以支援非ASCII字符
app.config["JSON_AS_ASCII"] = False
# 定義一個路由 當使用者發送 GET 請求到 "/crawler" 時 執行下面的處理函數
@app.route("/crawler", methods=["GET"])

def crawler():
        # 從 GET 參數中取得 "type" 參數 代表類群
        Application_Type = request.args.get("type")
        # 從 GET 參數中取得 "score_1" 參數 代表中文分數
        score_chinese = request.args.get("score_1")
         # 從 GET 參數中取得 "score_2" 參數 代表英文分數
        score_english = request.args.get("score_2")
        # 從 GET 參數中取得 "score_3" 參數 代表數學分數
        score_math = request.args.get("score_3")
        # 從 GET 參數中取得 "score_4" 參數 代表專業科目一分數
        score_subject1 = request.args.get("score_4")
        # 從 GET 參數中取得 "score_5" 參數 代表專業科目二分數
        score_subject2 = request.args.get("score_5")
        # -----

        # 創建一個 ChromeOptions 對象 用於設定 Chrome 瀏覽器的選項
        options = webdriver.ChromeOptions()
        # 添加一個選項 使瀏覽器啟動時最大化視窗
        options.add_argument("start-maximized")
        # 添加一個實驗性的選項 排除指定的開關 這裡排除了 "enable-logging" 以阻止日誌消息顯示在控制台上
        options.add_experimental_option("excludeSwitches", ["enable-logging"])
        # ---
        
        # 設定 Chrome 瀏覽器的驅動器路徑
        loute = Service("/Users/tsengpinruei/Desktop/crawler/chromedriver-mac-arm64/chromedriver")
        # 使用指定的選項和驅動器路徑創建 Chrome 瀏覽器對象
        driver = webdriver.Chrome(options=options, service=loute)
        # 訪問指定的網址
        driver.get("https://hs.1111.com.tw/techAnalysisInput.aspx")
        # -----

        # 創建 WebDriverWait 對象，最多等待1秒 用於等待元素可見
        wait = WebDriverWait(driver, 1)
        # 點擊按鈕
        time.sleep(1)
        # 建立 XPath 表達式 以便選擇指定文字的標籤(label)元素
        chkgroup = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//label[contains(text(), '" + Application_Type + "' )]"))))
        # 點擊該元素
        chkgroup.click()

        # 等待中文成績輸入框可見 並輸入中文成績
        chinese = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam1")))
        chinese.send_keys(int(score_chinese))
        # 等待英文成績輸入框可見 並輸入英文成績
        english = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam2")))
        english.send_keys(score_english)
        # 等待數學成績輸入框可見 並輸入數學成績
        math = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam3")))
        math.send_keys(score_math)
        # 等待專業科目一成績輸入框可見 並輸入專業科目一成績
        subject1 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam4")))
        subject1.send_keys(score_subject1)
        # 等待專業科目二成績輸入框可見 並輸入專業科目二成績
        subject2 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$exam5")))
        subject2.send_keys(score_subject2)
        # 等待1秒，確保輸入的資料已被處理
        time.sleep(1)

        # 點擊下一步按鈕
        button1 = wait.until(EC.visibility_of_element_located((By.NAME, "ctl00$ContentPlaceHolder1$lbtn")))
        button1.click()
        # 等待1秒
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

        # 將視窗滾動到頂部
        driver.execute_script("window.scrollTo(0, 0);")

        # 點擊確定按鈕
        button3 = wait.until(EC.visibility_of_element_located((By.XPATH, "//*[@id='ctl00_ContentPlaceHolder1_Button1']")))
        button3.click()

        # 第三頁

        # 定義機會評估的選項
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
        # 點擊按鈕登入
        time.sleep(2)
        go_login = wait.until(EC.visibility_of_element_located((By.XPATH, ".//a[contains(text(), '會員登入')]")))
        go_login.click()
        # 輸入帳號
        acc = wait.until(EC.visibility_of_element_located((By.NAME, "id")))
        acc.click()
        acc.send_keys("H225584089")
        # 輸入密碼
        pw = wait.until(EC.visibility_of_element_located((By.NAME, "pass")))
        pw.click()
        pw.send_keys("topicgood123")
        # 點擊登入按鈕
        login = wait.until(EC.visibility_of_element_located((By.ID, "smlogin")))
        login.click()

        # 取得評估的資料
        for i in range(len(chance_value_id)):
            value1 = wait.until(EC.visibility_of_element_located((By.ID, chance_value_id[i]))).text
            chance_dict[str(chance_key[i])] = value1
        
        print(chance_dict)
        # 將結果存入 result 變數
        result = chance_dict
        # 點擊結果

        # 注意!!!
        # wait.until(EC.visibility_of_element_located寫法的確會大幅減少時間但是無法存儲資料
        # 如需儲存請用driver.find_elements或driver.find_element
        
        # ------------------------機會渺茫------------------------
        # 刪除
        # ------------------------------------------------------------

        # ------------------------夢幻校系------------------------
        # 等待夢幻校系元素可見 並點擊
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '夢幻校系' )]"))))
        chance.click()

        # 初始化空字典和列表 用於存放爬取的資訊
        chance_dic2 = {}
        list2 = []

        # 使用 Selenium 找到包含學校名稱、科系和其他資訊的元素集合
        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        # 檢查是否有學校資訊
        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                # 初始化空字典 用於存放每一個學校的資訊
                step_dic = {}
                # 處理其他資訊的文本 替換換行符號並取得 "篩" 字符的索引
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                # 刪除索引之前的文本 得到最終的夢幻校系資訊
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                # 將學校、科系和夢幻校系資訊組成字典
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list2.append(step_dic)
            
            # 將字典放入夢幻校系的結果字典中
            chance_dic2["夢幻校系"] = list2
        else:
            # 如果沒有學校資訊，則添加一個標記為 "無內容" 的字典
            list2.append({"無內容": "無內容"})
            chance_dic2["無學校名稱"] = list2

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
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
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
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list4.append(step_dic)

            chance_dic4["最適落點"] = list4
        else:
            list4.append({"無內容": "無內容"})
            chance_dic4["無學校名稱"] = list4

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
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list5.append(step_dic)

            chance_dic5["保守選填"] = list5
        else:
            list5.append({"無內容": "無內容"})
            chance_dic5["無學校名稱"] = list5

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
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list6.append(step_dic)

            chance_dic6["安全穩固"] = list6
        else:
            list6.append({"無內容": "無內容"})
            chance_dic6["無學校名稱"] = list6

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
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list7.append(step_dic)

            chance_dic7["極具優勢"] = list7
        else:
            list7.append({"無內容": "無內容"})
            chance_dic7["無學校名稱"] = list7

        print("'極具優勢'執行完成")
        # ------------------------------------------------------------

        # ------------------------其他參考------------------------
        chance = wait.until(EC.visibility_of_element_located((By.XPATH, str(".//*[contains(text(), '其他參考' )]"))))
        chance.click()

        chance_dic8 = {}
        list8 = []

        school_chance = driver.find_elements(By.CLASS_NAME, "school")
        subject_chance = driver.find_elements(By.CLASS_NAME, "faculty")
        chance_other = driver.find_elements(By.CLASS_NAME, "other")

        if len(school_chance) != 0:
            for i in range(len(school_chance)):
                step_dic = {}
                chance_other_text = chance_other[i].text.replace("\n", "，")
                replace_index = chance_other_text.index("篩")
                chance_text = chance_other_text.replace(chance_other_text[:replace_index:], "")
                step_dic[school_chance[i].text + "_" + subject_chance[i].text] = chance_text
                list8.append(step_dic)

            chance_dic8["其他參考"] = list8
        else:
            list8.append({"無內容": "無內容"})
            chance_dic8["無學校名稱"] = list8

        print("'其他參考'執行完成")
        # ------------------------------------------------------------
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
    app.run(host="0.0.0.0", port=5000, debug=True)