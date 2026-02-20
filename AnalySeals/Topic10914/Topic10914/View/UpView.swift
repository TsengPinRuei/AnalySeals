//
//  UpView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/8.
//

import SwiftUI

struct UpView: View
{
    @Environment(\.dismiss) private var dismiss
    
    //顯示LoadingView的狀態
    @State private var showLoading: Bool=false
    //顯示成功畫面的狀態
    @State private var showSuccess: Bool=false
    //當前TabView頁面
    @State private var page: Int=0
    //進度條數字
    @State private var progress: CGFloat=0
    //圖片名稱 最後的名稱為空是為了顯示對應性別的圖片
    @State private var image:[ImageResource]=[.signUpEmail, .signUpPassword1, .signUpName, .signUpGender, .signUpSchool, .signUpSchool, .signUpPassword2, .guest]
    //帳號 密碼 名字 性別 地區 縣市 學歷 學校 密碼驗證
    @State private var inInformation: [String]=["", "", "", "性別", "地區", "縣市", "最高學歷", "學校名稱", ""]
    //註冊失敗的Alert
    @State private var error: Alerter=Alerter(message: "", show: false)
    
    //Picker最高學歷選項
    private var degree: [String]=["最高學歷", "高中", "高職", "專科學校", "普通大學", "科技大學", "空中大學"]
    //Picker性別選項
    private let gender: [String]=["性別", "男生", "女生"]
    //Picker地區選項
    private let region: [String]=["地區", "北", "中", "南", "東", "外島"]
    //標題名稱
    private let title: [String]=["電子郵件", "密碼", "名字", "性別", "地區及縣市", "學歷及學校", "確認密碼", "準備就緒"]
    
    //MARK: 檢查輸入資訊
    private func checkInformation() async
    {
        let bad=["幹", "婊子", "黑鬼", "fuck", "bitch", "nigger"]
        
        //電子郵件正則表達式
        let account: Bool =
        NSPredicate(
            format: "SELF MATCHES %@",
            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        )
        .evaluate(with: self.inInformation[0])
        
        //密碼正則表達式
        let password: Bool =
        NSPredicate(
            format: "SELF MATCHES %@",
            "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        )
        .evaluate(with: self.inInformation[1])
        
        //MARK: 電子郵件不符合格式
        if(!account)
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "本豹看不太懂「電子郵件」格式...")
        }
        //MARK: 密碼不符合格式
        else if(!password)
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "「密碼」好像不是本豹想要的...")
        }
        //MARK: 名字不符合格式
        else if(self.inInformation[2].isEmpty || self.inInformation[2].count>10 || bad.contains(where: self.inInformation[2].lowercased().contains))
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "小魚值得更好的「名字」！")
        }
        //MARK: 未選擇性別
        else if(self.inInformation[3]=="性別")
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "小魚是有「性別」的生物！")
        }
        //MARK: 未選擇地區
        else if(self.inInformation[4]=="地區")
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "本豹找不到你的故鄉...")
        }
        //MARK: 未選擇縣市
        else if(self.inInformation[5]=="縣市")
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "小魚來自哪個縣市的大海呢")
        }//MARK: 未選擇學歷
        else if(self.inInformation[6]=="最高學歷")
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "這好像違背了AnalySeals的初衷？")
        }
        //MARK: 未選擇學校
        else if(self.inInformation[7]=="學校名稱")
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "這好像違背了AnalySeals的初衷？")
        }
        //MARK: 密碼驗證不同
        else if(self.inInformation[8] != self.inInformation[1])
        {
            self.error.showAlert(title: "出了點小狀況😥", message: "金魚腦，「密碼」好像不一樣喔！")
        }
        //MARK: 驗證成功
        else
        {
            //顯示LoadingView
            withAnimation(.easeInOut)
            {
                self.showLoading=true
            }
            
            //註冊資訊
            SwiftUI.Task
            {
                await self.signUpInformation()
            }
        }
    }
    //MARK: 根據頁面顯示畫面
    private func setUpView(index: Int) -> some View
    {
        switch(index)
        {
            //MARK: 帳號 名字
            case 0, 2:
                return AnyView(
                    VStack
                    {
                        ModifyField(
                            text: self.$inInformation[index],
                            fieldType: .text,
                            background: .clear,
                            keyboard: index==0 ? .emailAddress:.namePhonePad,
                            submit: .done
                        )
                        .signUpFieldStyle()
                        
                        //電子郵件
                        if(index==0)
                        {
                            Text("記得要輸入正確的電子郵件格式喔！").font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .leading])
                        }
                        //名字
                        else if(index==2)
                        {
                            VStack(alignment: .leading, spacing: 5)
                            {
                                Text("命名規則：")
                                Text("1. 不可以為空")
                                Text("2. 名字總長度不可以大於10")
                                Text("3. 不可以包含敏感字詞")
                            }
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        }
                    }
                )
            //MARK: 密碼
            case 1, 6:
                return AnyView(
                    VStack
                    {
                        ModifyField(
                            text: self.$inInformation[(index==1 ? 1:8)],
                            fieldType: .secure,
                            background: .clear,
                            submit: .done
                        )
                        .signUpFieldStyle()
                        
                        //驗證密碼
                        if(index==6)
                        {
                            Text("請輸入與上次相同的密碼")
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                        
                        VStack(alignment: .leading, spacing: 5)
                        {
                            Text("密碼規則：")
                            Text("1. 至少包含一個字母（不包含大小寫）")
                            Text("2. 至少包含一個數字")
                            Text("3. 密碼總長度不可以小於6")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading])
                    }
                )
            //MARK: 性別
            case 3:
                return AnyView(
                    Picker("", selection: self.$inInformation[3])
                    {
                        ForEach(self.gender, id: \.self)
                        {index in
                            Text(index).tag(index)
                        }
                    }
                        .signUpPickerStyle()
                        .onChange(of: self.inInformation[3])
                        {(_, new) in
                            let count=self.image.count
                            
                            if(new=="男生")
                            {
                                self.image[count-1] = .male
                            }
                            else if(new=="女生")
                            {
                                self.image[count-1] = .female
                            }
                            else
                            {
                                self.image[count-1] = .guest
                            }
                        }
                )
            //MARK: 地區 縣市
            case 4:
                return AnyView(
                    VStack(spacing: 0)
                    {
                        //MARK: 地區
                        Picker("", selection: self.$inInformation[4])
                        {
                            ForEach(self.region.indices, id: \.self)
                            {index in
                                Text("\(self.region[index])\((index>0 && index<5) ? "部":"")").tag(self.region[index])
                            }
                        }
                        .signUpPickerStyle()
                        
                        Capsule()
                            .fill(Color(.backBar))
                            .frame(height: 1)
                            .padding(.horizontal)
                        
                        //MARK: 縣市
                        Picker("", selection: self.$inInformation[5])
                        {
                            ForEach(City(region: self.inInformation[4]).setCity(), id: \.self)
                            {index in
                                Text(index).tag(index)
                            }
                        }
                        .signUpPickerStyle()
                    }
                )
            //MARK: 學歷 學校
            case 5:
                return AnyView(
                    VStack(spacing: 0)
                    {
                        //MARK: 學歷
                        Picker("", selection: self.$inInformation[6])
                        {
                            ForEach(self.degree, id: \.self)
                            {index in
                                Text(index).tag(index)
                            }
                        }
                        .signUpPickerStyle()
                        
                        Capsule()
                            .fill(Color(.backBar))
                            .frame(height: 1)
                            .padding(.horizontal)
                        
                        //MARK: 學校
                        Picker("", selection: self.$inInformation[7])
                        {
                            ForEach(School(degree: self.inInformation[6], city: self.inInformation[5]).setSchool(), id: \.self)
                            {index in
                                Text(index).tag(index)
                            }
                        }
                        .signUpPickerStyle()
                    }
                )
            //MARK: 資訊總覽
            default:
                let title: [String]=["帳號", "名字", "性別", "地區", "縣市", "學歷", "學校"]
                let informationIndex: [Int]=[0, 2, 3, 4, 5, 6, 7]
                
                return AnyView(
                    List
                    {
                        Section("請確認您的資訊：")
                        {
                            ForEach(title.indices, id: \.self)
                            {index in
                                HStack
                                {
                                    Text("\(title[index])：").bold()
                                    
                                    Text(self.inInformation[informationIndex[index]])
                                }
                            }
                            .font(.title3)
                            .foregroundStyle(Color(.backBar))
                            .listRowBackground(Rectangle().fill(.ultraThinMaterial))
                            .listRowSeparator(.hidden)
                        }
                        .headerProminence(.increased)
                        
                        //MARK: 檢查資訊按鈕
                        Button
                        {
                            SwiftUI.Task
                            {
                                await self.checkInformation()
                            }
                        }
                        label:
                        {
                            Text("確認註冊")
                                .bold()
                                .font(.title3)
                                .foregroundStyle(.blue)
                                .frame(maxWidth: .infinity)
                        }
                        .listRowBackground(
                            Rectangle()
                                .fill(.ultraThickMaterial)
                                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                        )
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                        .listStyle(.inset)
                        .scrollIndicators(.hidden)
                        .scrollContentBackground(.hidden)
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.top, -30)
                )
        }
    }
    //MARK: 註冊資訊到Authentication及存放資料到Realtime Database
    private func signUpInformation() async
    {
        //將資訊儲存到Realtime Database 並註冊到Firebase Authentication
        Authenticationer().signUp(information: self.inInformation)
        {error in
            DispatchQueue.main.async
            {
                //完成動作 停止顯示LoadingView
                withAnimation(.easeInOut)
                {
                    self.showLoading=false
                }
                
                //註冊失敗
                if let error=error
                {
                    self.error.showAlert(title: "出了點小狀況😥", message: error.localizedDescription)
                }
                //註冊成功
                else
                {
                    withAnimation(.easeInOut)
                    {
                        self.inInformation=["", "", "", "性別", "地區", "縣市", "最高學歷", "學校名稱", ""]
                        self.showSuccess=true
                    }
                }
            }
        }
    }
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                //MARK: 背景
                BackgroundCapsule()
                
                //MARK: TabView
                TabView(selection: self.$page)
                {
                    ForEach(self.image.indices, id: \.self)
                    {index in
                        VStack(spacing: 10)
                        {
                            //MARK: 標題
                            Text(self.title[index])
                                .bold()
                                .font(.largeTitle)
                                .foregroundStyle(Color(.backBar))
                            
                            VStack(spacing: 50)
                            {
                                //MARK: 圖片
                                if(index<self.image.count-1)
                                {
                                    Image(self.image[index])
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 30))
                                        .shadow(color: Color(.backBar), radius: 1)
                                }
                                else
                                {
                                    Image(self.image[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .shadow(color: Color(.backBar), radius: 1)
                                }
                                
                                //MARK: 輸入畫面
                                self.setUpView(index: index).padding(index==4 || index==5 ? 0:10)
                            }
                            
                            //MARK: 輔助說明
                            if(index==5)
                            {
                                Text("如果「學校」沒有選項時，\n可以檢查是否有選擇「縣市」喔。")
                                    .font(.headline)
                                    .foregroundStyle(Color(.backBar))
                                    .multilineTextAlignment(.center)
                            }
                            
                            //將畫面推上去
                            Spacer()
                        }
                        .padding()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.smooth, value: self.page)
                
                //MARK: LoadingView
                if(self.showLoading)
                {
                    LoadingView(type: "").transition(.opacity.animation(.easeInOut))
                }
                //MARK: 註冊成功畫面
                if(self.showSuccess)
                {
                    Color.black
                        .ignoresSafeArea(.all)
                        .opacity(0.6)
                        .overlay
                        {
                            Button
                            {
                                self.dismiss()
                            }
                            label:
                            {
                                VStack(spacing: 100)
                                {
                                    VStack
                                    {
                                        Text("註冊成功🤩\n")
                                        
                                        Text("學海無涯，")
                                        
                                        Text("快來探索這深奧的海洋世界吧！")
                                    }
                                    .bold()
                                    .foregroundStyle(Color(.welcomeTitle))
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .frame(width: 50, height: 25)
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                                .background(Color(.rectangle))
                                .clipShape(.rect(cornerRadius: 20))
                            }
                        }
                        .transition(.opacity.animation(.easeInOut))
                }
            }
            //MARK: 失敗Alert
            .alert(isPresented: self.$error.show)
            {
                return Alert(
                    title: Text(self.error.title!),
                    message: Text(self.error.message),
                    dismissButton: .cancel(Text("確認")) {}
                )
            }
            .toolbar
            {
                //MARK: ProgressBar
                ToolbarItem(placement: .principal)
                {
                    ProgressBar(page: self.$page, progress: self.$progress)
                }
                
                //MARK: 翻頁按紐
                ToolbarItem(placement: .bottomBar)
                {
                    HStack
                    {
                        Button
                        {
                            self.page-=1
                        }
                        label:
                        {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                        }
                        .disabled(self.page==0)
                        .animation(.easeInOut, value: self.page)
                        
                        Spacer()
                        
                        Button
                        {
                            self.page+=1
                        }
                        label:
                        {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                        }
                        .disabled(self.page==self.title.count-1)
                        .animation(.easeInOut, value: self.page)
                    }
                    .bold()
                    .frame(height: 40)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                    .background(Color(.background))
                }
            }
        }
    }
}
