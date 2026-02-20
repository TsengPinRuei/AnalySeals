import time
import json
import random
from flask import Flask, jsonify, request, Response
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import NoSuchElementException, TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
from collections import OrderedDict


app = Flask(__name__)

app.config["JSON_AS_ASCII"] = False


@app.route("/mbti", methods=["POST"])
def mbti():
    # -----
    # 阻止日誌發送消息出現在控制台上
    options = webdriver.ChromeOptions()
    options.add_argument("start-maximized")
    options.add_experimental_option("excludeSwitches", ["enable-logging"])
    # ---
    loute = Service("/Users/tsengpinruei/Desktop/crawler/chromedriver-mac-arm64/chromedriver")
    driver = webdriver.Chrome(options=options, service=loute)
    driver.get("https://www.16personalities.com/free-personality-test")
    # -----
    # "1" = 非常不同意;2 = 很不同意;3 = 不同意;4 = 還好;5 = 同意;6 = 很同意;7 = 非常同意
    # ---

    # 指定服务器地址

    A_1 = request.args.get("A1")
    A_2 = request.args.get("A2")
    A_3 = request.args.get("A3")
    A_4 = request.args.get("A4")
    A_5 = request.args.get("A5")
    A_6 = request.args.get("A6")

    B_1 = request.args.get("B1")
    B_2 = request.args.get("B2")
    B_3 = request.args.get("B3")
    B_4 = request.args.get("B4")
    B_5 = request.args.get("B5")
    B_6 = request.args.get("B6")

    C_1 = request.args.get("C1")
    C_2 = request.args.get("C2")
    C_3 = request.args.get("C3")
    C_4 = request.args.get("C4")
    C_5 = request.args.get("C5")
    C_6 = request.args.get("C6")

    D_1 = request.args.get("D1")
    D_2 = request.args.get("D2")
    D_3 = request.args.get("D3")
    D_4 = request.args.get("D4")
    D_5 = request.args.get("D5")
    D_6 = request.args.get("D6")

    E_1 = request.args.get("E1")
    E_2 = request.args.get("E2")
    E_3 = request.args.get("E3")
    E_4 = request.args.get("E4")
    E_5 = request.args.get("E5")
    E_6 = request.args.get("E6")

    F_1 = request.args.get("F1")
    F_2 = request.args.get("F2")
    F_3 = request.args.get("F3")
    F_4 = request.args.get("F4")
    F_5 = request.args.get("F5")
    F_6 = request.args.get("F6")

    G_1 = request.args.get("G1")
    G_2 = request.args.get("G2")
    G_3 = request.args.get("G3")
    G_4 = request.args.get("G4")
    G_5 = request.args.get("G5")
    G_6 = request.args.get("G6")

    H_1 = request.args.get("H1")
    H_2 = request.args.get("H2")
    H_3 = request.args.get("H3")
    H_4 = request.args.get("H4")
    H_5 = request.args.get("H5")
    H_6 = request.args.get("H6")

    I_1 = request.args.get("I1")
    I_2 = request.args.get("I2")
    I_3 = request.args.get("I3")
    I_4 = request.args.get("I4")
    I_5 = request.args.get("I5")
    I_6 = request.args.get("I6")

    J_1 = request.args.get("J1")
    J_2 = request.args.get("J2")
    J_3 = request.args.get("J3")
    J_4 = request.args.get("J4")
    J_5 = request.args.get("J5")
    J_6 = request.args.get("J6")
    # ---

    time.sleep(3)
    wait = WebDriverWait(driver, 1)  # 創建WebDriverWait對象，最多等10秒
    # 第一題
    if A_1 is None:
        A_1 = random.randint(1, 7)

    if str(A_1) == "7":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[1]/label"
    elif str(A_1) == "6":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[2]/label"
    elif str(A_1) == "5":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[3]/label"
    elif str(A_1) == "4":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[4]/label"
    elif str(A_1) == "3":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[5]/label"
    elif str(A_1) == "2":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[6]/label"
    elif str(A_1) == "1":
        path = "//*[@id='start-quiz']/div[2]/div[2]/span[7]/label"

    bt1 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt1.click()

    # 第二題
    if A_2 is None:
        A_2 = random.randint(1, 7)

    if str(A_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(A_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(A_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(A_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(A_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(A_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(A_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt2 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt2.click()

    # 第三題
    if A_3 is None:
        A_3 = random.randint(1, 7)

    if str(A_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(A_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(A_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(A_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(A_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(A_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(A_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt3 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt3.click()

    # 第四題
    if A_4 is None:
        A_4 = random.randint(1, 7)

    if str(A_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(A_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(A_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(A_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(A_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(A_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(A_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt4 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt4.click()

    # 第五題
    if A_5 is None:
        A_5 = random.randint(1, 7)

    if str(A_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(A_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(A_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(A_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(A_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(A_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(A_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt5 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt5.click()

    # 第六題
    if A_6 is None:
        A_6 = random.randint(1, 7)

    if str(A_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(A_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(A_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(A_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(A_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(A_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(A_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt6 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt6.click()

    # 下一步
    next1 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next1.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第七題
    if B_1 is None:
        B_1 = random.randint(1, 7)

    if str(B_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(B_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(B_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(B_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(B_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(B_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(B_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt7 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt7.click()

    # 第八題
    if B_2 is None:
        B_2 = random.randint(1, 7)

    if str(B_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(B_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(B_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(B_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(B_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(B_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(B_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt8 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt8.click()

    # 第九題
    if B_3 is None:
        B_3 = random.randint(1, 7)

    if str(B_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(B_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(B_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(B_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(B_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(B_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(B_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt9 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt9.click()

    # 第十題
    if B_4 is None:
        B_4 = random.randint(1, 7)

    if str(B_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(B_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(B_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(B_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(B_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(B_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(B_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt10 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt10.click()

    # 第十一題
    if B_5 is None:
        B_5 = random.randint(1, 7)

    if str(B_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(B_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(B_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(B_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(B_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(B_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(B_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt11 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt11.click()

    # 第十二題
    if B_6 is None:
        B_6 = random.randint(1, 7)

    if str(B_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(B_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(B_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(B_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(B_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(B_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(B_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt12 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt12.click()

    # 下一步
    next2 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next2.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第十三題
    if C_1 is None:
        C_1 = random.randint(1, 7)

    if str(C_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(C_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(C_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(C_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(C_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(C_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(C_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt13 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt13.click()

    # 第十四題
    if C_2 is None:
        C_2 = random.randint(1, 7)

    if str(C_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(C_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(C_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(C_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(C_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(C_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(C_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt14 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt14.click()

    # 第十五題
    if C_3 is None:
        C_3 = random.randint(1, 7)

    if str(C_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(C_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(C_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(C_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(C_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(C_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(C_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt15 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt15.click()

    # 第十六題
    if C_4 is None:
        C_4 = random.randint(1, 7)

    if str(C_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(C_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(C_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(C_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(C_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(C_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(C_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt16 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt16.click()

    # 第十七題
    if C_5 is None:
        C_5 = random.randint(1, 7)

    if str(C_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(C_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(C_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(C_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(C_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(C_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(C_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt17 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt17.click()

    # 第十八題
    if C_6 is None:
        C_6 = random.randint(1, 7)

    if str(C_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(C_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(C_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(C_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(C_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(C_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(C_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt18 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt18.click()

    # 下一步
    next3 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next3.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第十九題
    if D_1 is None:
        D_1 = random.randint(1, 7)

    if str(D_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(D_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(D_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(D_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(D_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(D_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(D_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt19 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt19.click()

    # 第二十題
    if D_2 is None:
        D_2 = random.randint(1, 7)

    if str(D_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(D_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(D_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(D_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(D_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(D_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(D_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt20 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt20.click()

    # 第二十一題
    if D_3 is None:
        D_3 = random.randint(1, 7)

    if str(D_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(D_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(D_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(D_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(D_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(D_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(D_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt21 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt21.click()

    # 第二十二題
    if D_4 is None:
        D_4 = random.randint(1, 7)

    if str(D_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(D_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(D_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(D_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(D_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(D_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(D_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt22 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt22.click()

    # 第二十三題
    if D_5 is None:
        D_5 = random.randint(1, 7)

    if str(D_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(D_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(D_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(D_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(D_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(D_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(D_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt23 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt23.click()

    # 第二十四題
    if D_6 is None:
        D_6 = random.randint(1, 7)

    if str(D_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(D_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(D_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(D_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(D_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(D_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(D_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt24 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt24.click()

    # 下一步
    next4 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next4.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第二十五題
    if E_1 is None:
        E_1 = random.randint(1, 7)

    if str(E_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(E_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(E_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(E_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(E_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(E_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(E_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt25 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt25.click()

    # 第二十六題
    if E_2 is None:
        E_2 = random.randint(1, 7)

    if str(E_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(E_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(E_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(E_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(E_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(E_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(E_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt26 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt26.click()

    # 第二十七題
    if E_3 is None:
        E_3 = random.randint(1, 7)

    if str(E_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(E_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(E_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(E_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(E_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(E_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(E_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt27 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt27.click()

    # 第二十八題
    if E_4 is None:
        E_4 = random.randint(1, 7)

    if str(E_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(E_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(E_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(E_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(E_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(E_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(E_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt28 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt28.click()

    # 第二十九題
    if E_5 is None:
        E_5 = random.randint(1, 7)

    if str(E_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(E_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(E_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(E_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(E_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(E_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(E_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt29 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt29.click()

    # 第三十題
    if E_6 is None:
        E_6 = random.randint(1, 7)

    if str(E_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(E_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(E_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(E_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(E_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(E_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(E_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt30 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt30.click()

    # 下一步
    next5 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next5.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第三十一題
    if F_1 is None:
        F_1 = random.randint(1, 7)

    if str(F_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(F_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(F_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(F_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(F_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(F_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(F_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt31 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt31.click()

    # 第三十二題
    if F_2 is None:
        F_2 = random.randint(1, 7)

    if str(F_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(F_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(F_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(F_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(F_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(F_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(F_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt32 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt32.click()

    # 第三十三題
    if F_3 is None:
        F_3 = random.randint(1, 7)

    if str(F_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(F_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(F_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(F_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(F_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(F_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(F_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt33 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt33.click()

    # 第三十四題
    if F_4 is None:
        F_4 = random.randint(1, 7)

    if str(F_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(F_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(F_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(F_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(F_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(F_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(F_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt34 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt34.click()

    # 第三十五題
    if F_5 is None:
        F_5 = random.randint(1, 7)

    if str(F_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(F_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(F_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(F_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(F_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(F_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(F_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt35 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt35.click()

    # 第三十六題
    if F_6 is None:
        F_6 = random.randint(1, 7)

    if str(F_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(F_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(F_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(F_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(F_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(F_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(F_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt36 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt36.click()

    # 下一步
    next6 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next6.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第三十七題
    if G_1 is None:
        G_1 = random.randint(1, 7)

    if str(G_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(G_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(G_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(G_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(G_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(G_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(G_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt37 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt37.click()

    # 第三十八題
    if G_2 is None:
        G_2 = random.randint(1, 7)

    if str(G_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(G_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(G_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(G_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(G_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(G_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(G_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt38 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt38.click()

    # 第三十九題
    if G_3 is None:
        G_3 = random.randint(1, 7)

    if str(G_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(G_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(G_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(G_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(G_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(G_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(G_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt39 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt39.click()

    # 第四十題
    if G_4 is None:
        G_4 = random.randint(1, 7)

    if str(G_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(G_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(G_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(G_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(G_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(G_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(G_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt40 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt40.click()

    # 第四十一題
    if G_5 is None:
        G_5 = random.randint(1, 7)

    if str(G_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(G_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(G_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(G_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(G_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(G_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(G_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt41 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt41.click()

    # 第四十二題
    if G_6 is None:
        G_6 = random.randint(1, 7)

    if str(G_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(G_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(G_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(G_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(G_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(G_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(G_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt42 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt42.click()

    # 下一步
    next7 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next7.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第四十三題
    if H_1 is None:
        H_1 = random.randint(1, 7)

    if str(H_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(H_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(H_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(H_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(H_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(H_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(H_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt43 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt43.click()

    # 第四十四題
    if H_2 is None:
        H_2 = random.randint(1, 7)

    if str(H_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(H_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(H_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(H_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(H_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(H_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(H_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt44 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt44.click()

    # 第四十五題
    if H_3 is None:
        H_3 = random.randint(1, 7)

    if str(H_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(H_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(H_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(H_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(H_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(H_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(H_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt45 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt45.click()

    # 第四十六題
    if H_4 is None:
        H_4 = random.randint(1, 7)

    if str(H_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(H_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(H_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(H_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(H_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(H_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(H_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt46 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt46.click()

    # 第四十七題
    if H_5 is None:
        H_5 = random.randint(1, 7)

    if str(H_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(H_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(H_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(H_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(H_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(H_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(H_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt47 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt47.click()

    # 第四十八題
    if H_6 is None:
        H_6 = random.randint(1, 7)

    if str(H_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(H_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(H_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(H_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(H_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(H_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(H_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt48 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt48.click()

    # 下一步
    next8 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next8.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第四十九題
    if I_1 is None:
        I_1 = random.randint(1, 7)

    if str(I_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(I_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(I_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(I_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(I_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(I_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(I_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt49 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt49.click()

    # 第五十題
    if I_2 is None:
        I_2 = random.randint(1, 7)

    if str(I_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(I_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(I_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(I_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(I_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(I_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(I_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt50 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt50.click()

    # 第五十一題
    if I_3 is None:
        I_3 = random.randint(1, 7)

    if str(I_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(I_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(I_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(I_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(I_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(I_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(I_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt51 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt51.click()

    # 第五十二題
    if I_4 is None:
        I_4 = random.randint(1, 7)

    if str(I_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(I_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(I_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(I_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(I_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(I_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(I_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt52 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt52.click()

    # 第五十三題
    if I_5 is None:
        I_5 = random.randint(1, 7)

    if str(I_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(I_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(I_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(I_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(I_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(I_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(I_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt53 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt53.click()

    # 第五十四題
    if I_6 is None:
        I_6 = random.randint(1, 7)

    if str(I_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(I_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(I_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(I_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(I_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(I_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(I_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt54 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt54.click()

    # 下一步
    next9 = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    next9.click()

    driver.execute_script("window.scrollTo(0, 0);")

    # 第五十五題
    if J_1 is None:
        J_1 = random.randint(1, 7)

    if str(J_1) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[1]/label"
    elif str(J_1) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[2]/label"
    elif str(J_1) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[3]/label"
    elif str(J_1) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[4]/label"
    elif str(J_1) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[5]/label"
    elif str(J_1) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[6]/label"
    elif str(J_1) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[1]/div[2]/div[2]/span[7]/label"

    bt55 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt55.click()

    # 第五十六題
    if J_2 is None:
        J_2 = random.randint(1, 7)

    if str(J_2) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[1]/label"
    elif str(J_2) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[2]/label"
    elif str(J_2) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[3]/label"
    elif str(J_2) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[4]/label"
    elif str(J_2) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[5]/label"
    elif str(J_2) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[6]/label"
    elif str(J_2) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[2]/div[2]/div[2]/span[7]/label"

    bt56 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt56.click()

    # 第五十七題
    if J_3 is None:
        J_3 = random.randint(1, 7)

    if str(J_3) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[1]/label"
    elif str(J_3) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[2]/label"
    elif str(J_3) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[3]/label"
    elif str(J_3) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[4]/label"
    elif str(J_3) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[5]/label"
    elif str(J_3) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[6]/label"
    elif str(J_3) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[3]/div[2]/div[2]/span[7]/label"

    bt57 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt57.click()

    # 第五十八題
    if J_4 is None:
        J_4 = random.randint(1, 7)

    if str(J_4) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[1]/label"
    elif str(J_4) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[2]/label"
    elif str(J_4) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[3]/label"
    elif str(J_4) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[4]/label"
    elif str(J_4) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[5]/label"
    elif str(J_4) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[6]/label"
    elif str(J_4) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[4]/div[2]/div[2]/span[7]/label"

    bt58 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt58.click()

    # 第五十九題
    if J_5 is None:
        J_5 = random.randint(1, 7)

    if str(J_5) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[1]/label"
    elif str(J_5) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[2]/label"
    elif str(J_5) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[3]/label"
    elif str(J_5) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[4]/label"
    elif str(J_5) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[5]/label"
    elif str(J_5) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[6]/label"
    elif str(J_5) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[5]/div[2]/div[2]/span[7]/label"

    bt59 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt59.click()

    # 第六十題
    if J_6 is None:
        J_6 = random.randint(1, 7)

    if str(J_6) == "7":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[1]/label"
    elif str(J_6) == "6":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[2]/label"
    elif str(J_6) == "5":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[3]/label"
    elif str(J_6) == "4":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[4]/label"
    elif str(J_6) == "3":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[5]/label"
    elif str(J_6) == "2":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[6]/label"
    elif str(J_6) == "1":
        path = "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[1]/fieldset[6]/div[2]/div[2]/span[7]/label"

    bt60 = wait.until(EC.visibility_of_element_located((By.XPATH, path)))
    bt60.click()

    # 下一步
    result = wait.until(
        EC.visibility_of_element_located(
            (
                By.XPATH,
                "//*[@id='main-app']/main/div[1]/div[2]/div/form/div[2]/button/span[1]",
            )
        )
    )
    result.click()

    time.sleep(3)

    personality_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__type__name"))
    )
    personality_type = str(personality_type.text)

    personality_type_code = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__type__code"))
    )
    code = personality_type_code.text.replace("\n", " ")
    code_index = code.index("is")
    type_code = code.replace(code[: code_index + 3 :], "")

    analysis = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__type__snippet"))
    )
    analysis = str(analysis.text)

    bt_next = wait.until(
        EC.visibility_of_element_located(
            (By.XPATH, "//*[@id='access-quiz-results']/div/div/div[2]/button")
        )
    )
    bt_next.click()

    IorE_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "card__trait"))
    )
    IorE_type = str(IorE_type.text)

    IorE_content = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__trait__description"))
    )
    IorE_content = str(IorE_content.text)

    bt_next1 = wait.until(
        EC.visibility_of_element_located(
            (By.XPATH, "//*[@id='access-quiz-results']/div/div/div[2]/button")
        )
    )
    bt_next1.click()

    OorI_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "card__trait"))
    )
    OorI_type = str(OorI_type.text)

    OorI_content = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__trait__description"))
    )
    OorI_content = str(OorI_content.text)

    bt_next2 = wait.until(
        EC.visibility_of_element_located(
            (By.XPATH, "//*[@id='access-quiz-results']/div/div/div[2]/button")
        )
    )
    bt_next2.click()

    ForT_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "card__trait"))
    )
    ForT_type = str(ForT_type.text)

    ForT_content = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__trait__description"))
    )
    ForT_content = str(ForT_content.text)

    bt_next3 = wait.until(
        EC.visibility_of_element_located(
            (By.XPATH, "//*[@id='access-quiz-results']/div/div/div[2]/button")
        )
    )
    bt_next3.click()

    PorJ_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "card__trait"))
    )
    PorJ_type = str(PorJ_type.text)

    PorJ_content = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__trait__description"))
    )
    PorJ_content = str(PorJ_content.text)

    bt_next4 = wait.until(
        EC.visibility_of_element_located(
            (By.XPATH, "//*[@id='access-quiz-results']/div/div/div[2]/button")
        )
    )
    bt_next4.click()

    TorA_type = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "card__trait"))
    )
    TorA_type = str(TorA_type.text)

    TorA_content = wait.until(
        EC.visibility_of_element_located((By.CLASS_NAME, "results__trait__description"))
    )
    TorA_content = str(TorA_content.text)

    time.sleep(3)

    json_str = json.dumps(
        {
            "personality_type": personality_type,
            "type_code": type_code,
            "analysis": analysis,
            "mind_type": IorE_type,
            "mind_content": IorE_content,
            "energy_type": OorI_type,
            "energy_content": OorI_content,
            "nature_type": ForT_type,
            "nature_content": ForT_content,
            "tactics_type": PorJ_type,
            "tactics_content": PorJ_content,
            "identity_type": TorA_type,
            "identity_content": TorA_content,
        },
        ensure_ascii=False,
    )
    return Response(json_str, content_type="application/json")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
