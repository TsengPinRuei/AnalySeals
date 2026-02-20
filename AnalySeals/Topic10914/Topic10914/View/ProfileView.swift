//
//  ProfileView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/7.
//

import SwiftUI

struct ProfileView: View
{
    //關閉當前畫面的狀態
    @Environment(\.dismiss) private var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //是否顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    //顯示LoadingView的狀態
    @State private var showLoading: Bool=false
    //使用者輸入資訊 名字 簽名 地區 縣市 學歷 學校 密碼
    @State private var inInformation: [String]=["", "", "", "", "", "", ""]
    //警戒訊息用
    @State private var alert: Alerter=Alerter(message: "", show: false)
    @State private var city: [String]=[]
    @State private var school: [String]=[]
    @State private var realtime: Realtimer=Realtimer()
    
    //Picker地區選項
    private let region: [String]=["地區", "北", "中", "南", "東", "外島"]
    //Picker學歷選項
    private let degree: [String]=["最高學歷", "高中", "高職", "專科學校", "普通大學", "科技大學", "空中大學"]
    
    //MARK: 檢查資訊
    private func checkInformation() async
    {
        let bad=["幹", "婊子", "黑鬼", "fuck", "bitch", "dick", "nigger"]
        
        //MARK: 驗證名字
        if(self.inInformation[0].isEmpty || self.inInformation[0].count>10 || bad.contains(where: self.inInformation[0].lowercased().contains))
        {
            self.alert.showAlert(title: "這個名字我覺得不行😥", message: "小魚值得更好的名字")
        }
        //MARK: 確認密碼
        else if(self.inInformation[6] != self.user.password)
        {
            self.alert.showAlert(title: "無法修改資訊😥", message: "要不要考慮「忘記密碼」")
        }
        //MARK: 驗證成功
        else
        {
            withAnimation(.easeInOut)
            {
                self.showLoading=true
            }
            
            SwiftUI.Task
            {
                await self.updateInformation()
            }
        }
    }
    //MARK: 取得地區
    private func getRegion() -> String
    {
        let city=self.user.city
        
        if(["臺北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣"].contains(city))
        {
            return "北"
        }
        else if(["苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣"].contains(city))
        {
            return "中"
        }
        else if(["嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣"].contains(city))
        {
            return "南"
        }
        else if(["宜蘭縣", "花蓮縣", "臺東縣"].contains(city))
        {
            return "東"
        }
        else if(["金門縣", "連江縣", "澎湖縣"].contains(city))
        {
            return "外島"
        }
        else
        {
            return ""
        }
    }
    //MARK: 初始化輸入資料
    private func setInformation()
    {
        self.inInformation[0]=self.user.name
        self.inInformation[1]=self.user.bio ?? ""
        self.inInformation[2]=self.user.region
        self.inInformation[3]=self.user.city
        self.inInformation[4]=self.user.degree
        self.inInformation[5]=self.user.school
    }
    //MARK: 更新User的資料
    private func updateDatabase(column: String, data: String)
    {
        //從Realtime Database取得指定資料
        self.realtime.getData(column: column)
        {data in
            if let data=data
            {
                switch(column)
                {
                    case "Name":
                        self.user.name=data
                    case "Bio":
                        self.user.bio=data
                    case "City":
                        self.user.city=data
                    case "Degree":
                        self.user.degree=data
                    case "School":
                        self.user.school=data
                    default:
                        break
                }
            }
        }
        
        //更新Realtime Database中的指定資料及user中的指定資料
        self.realtime.updateData(column: column, data: data)
        {
            //更新資料成功
            switch(column)
            {
                case "Name":
                    self.user.name=data
                case "Bio":
                    self.user.bio=data
                case "City":
                    self.user.city=data
                case "Degree":
                    self.user.degree=data
                case "School":
                    self.user.school=data
                default:
                    break
            }
        }
    }
    //MARK: 更新Realtime Database中的資料
    private func updateInformation() async
    {
        //名字沒重複的話 更新名字到Firebase
        if(self.inInformation[0] != self.user.name)
        {
            self.updateDatabase(column: "Name", data: self.inInformation[0])
        }
        //個性簽名沒重複的話 更新個性簽名到Firebase
        if(!self.inInformation[1].isEmpty)
        {
            self.updateDatabase(column: "Bio", data: self.inInformation[1])
        }
        //地區沒重複的話 更新user中的地區
        if(self.inInformation[2] != self.user.region)
        {
            self.user.region=self.inInformation[2]
        }
        //縣市沒重複的話 更新縣市到Firebase
        if(self.inInformation[3] != self.user.city)
        {
            self.updateDatabase(column: "City", data: self.inInformation[3])
        }
        //學歷沒重複的話 更新學歷到Firebase
        if(self.inInformation[4] != self.user.degree)
        {
            self.updateDatabase(column: "Degree", data: self.inInformation[4])
        }
        //學校沒重複的話 更新學校到Firebase
        if(self.inInformation[5] != self.user.school)
        {
            self.updateDatabase(column: "School", data: self.inInformation[5])
        }
        
        withAnimation(.easeInOut)
        {
            self.showLoading=false
        }
        
        self.alert.showAlert(title: "資訊修改成功🤩", message: "看來我們又更了解你了")
    }
    
    var body: some View
    {
        ZStack
        {
            //MARK: 背景圖片
            BackgroundCapsule()
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.rectangle).opacity(0.8))
                .overlay
                {
                    List
                    {
                        //MARK: 名字
                        Section("名字")
                        {
                            ModifyField(
                                text: self.$inInformation[0],
                                fieldType: .text,
                                keyboard: .namePhonePad,
                                submit: .done
                            )
                        }
                        .headerProminence(.increased)
                        .listRowInsets(EdgeInsets())
                        
                        //MARK: 個性簽名
                        Section("個性簽名 \(self.inInformation[1].count)／50")
                        {
                            TextEditor(text: self.$inInformation[1])
                                //字數限制50字
                                .limitInput(text: self.$inInformation[1], max: 50)
                                .autocorrectionDisabled()
                                //隱藏預設背景
                                .scrollContentBackground(.hidden)
                                .background(.ultraThickMaterial)
                                .clipShape(.rect(cornerRadius: 10))
                                .padding(6)
                                .frame(height: 100)
                                .background(Color(.field))
                        }
                        .headerProminence(.increased)
                        .listRowInsets(EdgeInsets())
                        
                        //MARK: 地區 縣市
                        Section("所屬縣市")
                        {
                            HStack
                            {
                                //MARK: 地區
                                Picker("", selection: self.$inInformation[2])
                                {
                                    ForEach(self.region.indices, id: \.self)
                                    {index in
                                        Text("\(self.region[index])\(index>0 && index<5 ? "部":"")").tag(self.region[index])
                                    }
                                }
                                .pickerStyle(.wheel)
                                //地區改變時 縣市同步改變
                                .onChange(of: self.inInformation[2])
                                {(_, new) in
                                    self.city=City(region: new).setCity()
                                }
                                
                                //MARK: 縣市
                                Picker("", selection: self.$inInformation[3])
                                {
                                    ForEach(self.city, id: \.self)
                                    {index in
                                        Text(index).tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //縣市改變時 學校同步改變
                                .onChange(of: self.inInformation[3])
                                {(_, new) in
                                    self.school=School(degree: self.inInformation[4], city: new).setSchool()
                                }
                            }
                            .frame(height: 120)
                        }
                        .headerProminence(.increased)
                        .listRowBackground(Color(.field))
                        .listRowInsets(EdgeInsets())
                        
                        //MARK: 學歷 學校
                        Section("所屬學校")
                        {
                            HStack
                            {
                                //MARK: 學歷
                                Picker("", selection: self.$inInformation[4])
                                {
                                    ForEach(self.degree, id: \.self)
                                    {index in
                                        Text(index).tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //學歷改變時 學校同步改變
                                .onChange(of: self.inInformation[4])
                                {(_, new) in
                                    self.school=School(degree: new, city: self.inInformation[3]).setSchool()
                                }
                                
                                //MARK: 學校
                                Picker("", selection: self.$inInformation[5])
                                {
                                    ForEach(self.school, id: \.self)
                                    {index in
                                        Text(index).tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                            }
                            .frame(height: 120)
                        }
                        .headerProminence(.increased)
                        .listRowBackground(Color(.field))
                        .listRowInsets(EdgeInsets())
                        
                        //MARK: 密碼
                        Section("密碼驗證")
                        {
                            ModifyField(
                                text: self.$inInformation[6],
                                fieldType: .secure,
                                submit: .done
                            )
                        }
                        .headerProminence(.increased)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .scrollIndicators(.hidden)
                    //隱藏預設背景
                    .scrollContentBackground(.hidden)
                    .padding(.vertical)
                }
                .padding()
            
            //MARK: LoadingView
            if(self.showLoading)
            {
                LoadingView(type: "")
                    .ignoresSafeArea(.all)
                    .transition(.opacity.animation(.easeInOut))
            }
        }
        //隱藏預設的BackButton
        .navigationBarBackButtonHidden()
        //MARK: Alert
        .alert(isPresented: self.$alert.show)
        {
            return Alert(
                title: Text(self.alert.title!),
                message: Text(self.alert.message),
                dismissButton: .cancel(Text("確認"))
                {
                    if(self.alert.title!.hasPrefix("資訊修改成功"))
                    {
                        self.dismiss()
                    }
                }
            )
        }
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
            
            //MARK: 預設按鈕
            ToolbarItem(placement: .topBarTrailing)
            {
                Button("恢復預設")
                {
                    withAnimation(.easeInOut)
                    {
                        self.setInformation()
                        self.inInformation[6]=""
                    }
                }
            }
            
            //MARK: 完成按鈕
            ToolbarItem(placement: .topBarTrailing)
            {
                Button("完成")
                {
                    SwiftUI.Task
                    {
                        await self.checkInformation()
                    }
                }
                .bold()
            }
            
            //MARK: Keyboard
            ToolbarItem(placement: .keyboard)
            {
                Button("確認")
                {
                    UIApplication.shared.dismissKeyboard()
                }
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onAppear
        {
            //MARK: 初始化所有資料
            withAnimation(.easeInOut)
            {
                self.user.region=self.getRegion()
                self.city=City(region: self.getRegion()).setCity()
                self.school=School(degree: self.user.degree, city: self.user.city).setSchool()
                self.setInformation()
            }
            
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
