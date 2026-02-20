//
//  InView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct InView: View
{
    //紀錄登入狀態及帳密資訊
    @AppStorage("signIn") private var signIn: Bool=false
    
    //View返回的狀態
    @Environment(\.dismiss) private var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //鎖定輸入狀態
    @FocusState private var focus: Information?
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    //警戒訊息用
    @State private var invalidAccount: Bool=false
    @State private var forgetAccount: Bool=false
    @State private var forgetPassword: Bool=false
    //顯示UpView
    @State private var showUp: Bool=false
    //顯示LoadingView
    @State private var showLoading: Bool=false
    //輸入的帳號密碼
    @State private var inAccount: String=""
    @State private var inPassword: String=""
    @State private var alert: Alerter=Alerter(message: "", show: false)
    
    private enum Information: Hashable
    {
        case account
        case password
    }
    
    private func checkAccountPassword(account: String, password: String) -> Int
    {
        if(account.isEmpty)
        {
            return 1
        }
        else if(password.isEmpty)
        {
            return 2
        }
        else
        {
            return 0
        }
    }
    private func logIn() async
    {
        //MARK: 檢查帳號密碼欄位
        switch(self.checkAccountPassword(account: self.inAccount, password: self.inPassword))
        {
            //帳號未輸入 鎖定輸入帳號
            case 1:
                self.focus = .account
            //密碼未輸入 鎖定輸入密碼
            case 2:
                self.focus = .password
            //驗證帳號密碼
            case 0:
                withAnimation(.easeInOut)
                {
                    self.showLoading=true
                }
                
                //MARK: Realtime Database登入
                Authenticationer().signIn(account: self.inAccount, password: self.inPassword)
                {error in
                    DispatchQueue.main.async
                    {
                        //登入失敗
                        if let error=error
                        {
                            withAnimation(.easeInOut)
                            {
                                self.showLoading=false
                            }
                            
                            self.alert.showAlert(title: "帳號或密碼有誤：", message: error.localizedDescription)
                        }
                        //登入成功 從Firebase抓資料並且存進user
                        else
                        {
                            Realtimer().putData(account: self.inAccount)
                            {data in
                                self.user.account=data["Account"] as! String
                                self.user.password=data["Password"] as! String
                                self.user.name=data["Name"] as! String
                                self.user.gender=data["Gender"] as! String
                                self.user.degree=data["Degree"] as! String
                                self.user.city=data["City"] as! String
                                self.user.school=data["School"] as! String
                                self.user.bio=data["Bio"] as? String
                                self.user.note=Int(data["Note"] as! String)!
                                self.user.track=data["Track"] as! Bool
                                self.user.meTag=data["MeTag"] as? String
                                
                                withAnimation(.easeInOut)
                                {
                                    self.showLoading=false
                                }
                                //登入狀態
                                self.signIn=true
                                //關閉畫面
                                self.dismiss()
                            }
                        }
                    }
                }
            default:
                break
        }
    }
    
    var body: some View
    {
        ZStack
        {
            BackgroundCapsule()
            
            //MARK: InToUpView
            if(self.showUp)
            {
                //透明式切換畫面
                InToUpView().transition(.opacity)
            }
            //MARK: InView
            else
            {
                VStack(spacing: 20)
                {
                    //MARK: 標題圖片 標題
                    Image(uiImage: UIImage(named: "AppIcon")!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(Circle())
                        .overlay
                        {
                            ZStack
                            {
                                Color(.backBar)
                                    .colorInvert()
                                    .opacity(0.8)
                                    .clipShape(Circle())
                                
                                VStack
                                {
                                    Text("豹讀詩書")
                                    
                                    Text("AnalySeals")
                                }
                                .bold()
                                .font(.largeTitle)
                                .foregroundStyle(Color(.welcomeTitle))
                            }
                        }
                        //MARK: 開發者專用 快速登入
                        .onTapGesture(count: 3)
                        {
                            withAnimation(.easeInOut)
                            {
                                self.inAccount="topicgood123@gmail.com"
                                self.inPassword="topic123"
                            }
                            SwiftUI.Task
                            {
                                await self.logIn()
                            }
                        }
                        //MARK: 開發者專用 快速登入
                        .onLongPressGesture
                        {
                            withAnimation(.easeInOut)
                            {
                                self.inAccount="s10914054@gm.cyut.edu.tw"
                                self.inPassword="s10914054"
                            }
                            SwiftUI.Task
                            {
                                await self.logIn()
                            }
                        }
                    
                    //MARK: 輸入框
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.rectangle).opacity(0.8))
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .padding()
                        //MARK: TextField 忘記帳號密碼
                        .overlay
                        {
                            VStack(spacing: 20)
                            {
                                ModifyField(
                                    text: self.$inAccount,
                                    fieldType: .text,
                                    placeholder: "帳號...",
                                    keyboard: .emailAddress,
                                    submit: .next
                                )
                                .focused(self.$focus, equals: .account)
                                .padding(.horizontal)
                                .onSubmit
                                {
                                    self.focus = .password
                                }
                                
                                //MARK: 忘記帳號
                                HStack
                                {
                                    //將忘記帳號擠到最右邊
                                    Spacer()
                                    
                                    Text("忘記帳號")
                                        .font(.footnote)
                                        .onTapGesture
                                        {
                                            self.forgetAccount.toggle()
                                        }
                                        .alert("帳號就是你的電子郵件唷😘", isPresented: self.$forgetAccount)
                                        {
                                            //連接到Line應用程式 顯示官方帳號資訊
                                            Button("聯絡客服", role: .destructive)
                                            {
                                                UIApplication.shared.open(URL(string: "https://line.me/R/ti/p/@805ndypi")!)
                                            }
                                            
                                            Button("我知道了", role: .cancel) {}
                                        }
                                }
                                .padding(.horizontal)
                                
                                ModifyField(
                                    text: self.$inPassword,
                                    fieldType: .secure,
                                    placeholder: "密碼...",
                                    keyboard: .asciiCapable,
                                    submit: .done
                                )
                                .focused(self.$focus, equals: .password)
                                .padding(.horizontal)
                                
                                //MARK: 忘記密碼
                                HStack
                                {
                                    //將忘記密碼擠到最右邊
                                    Spacer()
                                    
                                    Text("忘記密碼")
                                        .font(.footnote)
                                        .onTapGesture
                                        {
                                            //驗證帳號錯誤
                                            if(!NSPredicate(
                                                format:"SELF MATCHES %@",
                                                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                                            ).evaluate(with: self.inAccount))
                                            {
                                                self.invalidAccount.toggle()
                                            }
                                            else
                                            {
                                                //MARK: 修改密碼
                                                Authenticationer().resetPassword(account: self.inAccount)
                                                self.forgetPassword.toggle()
                                            }
                                        }
                                        .alert("你的電子郵件輸入錯誤🫠", isPresented: self.$invalidAccount)
                                        {
                                            Button("確認", role: .cancel)
                                            {
                                                self.focus = .account
                                            }
                                        }
                                        .alert("「更改密碼郵件」\n已發送到您的電子郵件\n請前往確認", isPresented: self.$forgetPassword)
                                        {
                                            Button("確認", role:  .cancel)
                                            {
                                            }
                                        }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.horizontal)
                        }
                    
                    VStack(spacing: 30)
                    {
                        //MARK: 登入按鈕
                        Button
                        {
                            SwiftUI.Task
                            {
                                await self.logIn()
                            }
                        }
                        label:
                        {
                            Text("開始使用").modifyButtonTextStyle(width: 280, height: 50, fgColor: .black)
                        }
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                        //alert觸發動作 顯示自定義的alert
                        .alert(isPresented: self.$alert.show)
                        {
                            return Alert(
                                title: Text(self.alert.title!),
                                message: Text(self.alert.message),
                                dismissButton: .default(Text("我知道了"))
                            )
                        }
                        
                        //MARK: 註冊按鈕
                        Button
                        {
                            //動畫式的觸發動作
                            withAnimation(.easeInOut)
                            {
                                self.showUp.toggle()
                            }
                        }
                        label:
                        {
                            Text("前往註冊").modifyButtonTextStyle(width: 280, height: 50, fgColor: .black)
                        }
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    }
                }
            }
            
            //MARK: LoadingView
            if(self.showLoading)
            {
                LoadingView(type: "").transition(.opacity)
            }
        }
        .ignoresSafeArea(.all)
        //隱藏系統預設的NavigationBarBackButton
        .navigationBarBackButtonHidden()
        //MARK: 返回主頁
        .toolbar
        {
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
        }
        .onAppear
        {
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
