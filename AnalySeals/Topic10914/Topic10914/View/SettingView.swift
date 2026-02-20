//
//  SettingView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct SettingView: View
{
    //紀錄顯示心情數量
    @AppStorage("activeNumber") private var activeNumber: Bool=true
    //記錄深淺模式
    @AppStorage("activateDark") private var activeDark: Bool=false
    //淺深模式開關
    @AppStorage("toggleDark") private var toggleDark: Bool=false
    //紀錄字型大小
    @AppStorage("fontSize") private var fontSize: String="預設"
    //每日通知
    @AppStorage("mail") private var mail: [String]=[]
    //紀錄每日通知
    @AppStorage("notificate") private var notificate: Bool=false
    //是否顯示落點分析學校：極具優勢 安全穩固 保守選填 最適落點 嘗試進攻 夢幻校系 其他參考
    @AppStorage("prefer") private var prefer: [Bool]=[false, false, true, true, true, false, false]
    //每日通知是否已讀
    @AppStorage("read") private var read: [Bool]=[]
    //紀錄登入狀態
    @AppStorage("signIn") private var signIn: Bool=true
    //每日通知的時間
    @AppStorage("time") private var time: Date =
    {
        var setting=DateComponents()
        
        setting.hour=8
        setting.hour=0
        setting.second=0
        
        return Calendar.current.date(from: setting)!
    }()
    //進度表形式
    @AppStorage("toDoStyle") private var toDoStyle: Int=0
    
    //View返回的狀態
    @Environment(\.dismiss) var dismiss
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //切換深淺模式的動畫遮罩
    @State private var maskAnimation: Bool=false
    //顯示 返回主頁 的狀態
    @State private var showBackButton: Bool=false
    //顯示AboutView的狀態
    @State private var showDeveloper: Bool=false
    //顯示進度表說明
    @State private var showPop: Bool=false
    @State private var fontLanguage: String=""
    //深淺模式動畫的點擊起始點
    @State private var clickPoint: CGRect = .zero
    //切換深淺模式時的當前圖片
    @State private var currentToggleImage: UIImage?
    //切換深淺模式時的預先圖片
    @State private var previousToggleImage: UIImage?
    //修改密碼用警戒訊息
    @State private var changePasswordAlert: Alerter=Alerter(message: "", show: false)
    //註銷帳號用警戒訊息
    @State private var deleteAccountAlert: Alerter=Alerter(message: "", show: false)
    //退出APP用警戒訊息
    @State private var exitAlert: Alerter=Alerter(message: "", show: false)
    
    private let size: [String]=["預設", "大", "中", "小"]
    private let language: [String]=["中文", "英文", "日文", "韓文", "德文"]
    
    //MARK: 區塊間的間隔
    private func SmallDevider() -> some View
    {
        Capsule()
            .fill(.clear)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    //MARK: 設定區塊
    private func SmallSection(title: String, image: String) -> some View
    {
        HStack(spacing: 0)
        {
            Text(title)
            
            Spacer()
            
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(height: 25)
        }
        .bold()
        .foregroundStyle(Color(.toolbar))
        .listRowBackground(Color.clear)
        .listRowSeparatorTint(Color(.toolbar))
    }
    //MARK: 刪除動作
    private func deleteAction()
    {
        //將該帳號發佈的所有筆記從Firestore刪除
        Firestorer().deleteUserNote(user: self.user.account)
        {
            //取的該帳號發佈過的筆記數量
            Realtimer().getData(column: "Note")
            {data in
                if let data=data,
                   let count=Int(data),
                   let id=Authenticationer().getID()
                {
                    //將該帳號發佈的所有圖片從Storage刪除
                    for i in 0..<count
                    {
                        Storager().deleteImage(noteID: "\(id) \(i)")
                    }
                    
                    Realtimer().deleteData
                    {
                        Authenticationer().delete
                        {
                            //刪除當前使用者在User的所有資料
                            self.user.clearAll()
                            //登出狀態
                            self.signIn=false
                            //關閉畫面
                            self.dismiss()
                        }
                    }
                }
            }
        }
    }
    //MARK: 登出動作
    private func signOutAction(completion: @escaping () -> Void)
    {
        //Firebase都刪除之後再執行
        self.user.clearAll()
        //登出狀態
        self.signIn=false
        completion()
    }
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            List
            {
                Group
                {
                    //MARK: 環境設定
                    self.SmallSection(title: "環境設定", image: "iphone")
                    
                    //MARK: 深淺模式
                    HStack
                    {
                        Text("深淺模式")
                        
                        Spacer()
                        
                        Button
                        {
                            self.toggleDark.toggle()
                        }
                        label:
                        {
                            Image(systemName: self.toggleDark ? "moon.fill":"sun.max.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(self.toggleDark ? .yellow:Color(hexa: "FA5F55"))
                                .frame(height: 30)
                                //深淺模式切換動畫的起始點
                                .switchPoint
                                {point in
                                    self.clickPoint=point
                                }
                        }
                    }
                    
                    //MARK: 進度表形式
                    HStack(spacing: 20)
                    {
                        Text("進度表說明")
                            .foregroundStyle(.blue)
                            .onTapGesture
                            {
                                self.showPop.toggle()
                            }
                            .popover(isPresented: self.$showPop)
                            {
                                Text("為了提升彈性操作的空間，\n進度表間的資料不會同步。")
                                    .padding()
                                    .presentationCompactAdaptation(.popover)
                                    .presentationBackground(.ultraThinMaterial)
                            }
                        
                        Picker("", selection: self.$toDoStyle)
                        {
                            Text("月曆").tag(0)
                            
                            Text("週曆").tag(1)
                            
                            Text("週月曆").tag(2)
                        }
                        .tint(Color(.backBar))
                    }
                    
                    //MARK: 字型
                    Picker("字型", selection: self.$fontSize)
                    {
                        ForEach(self.size, id:\.self)
                        {index in
                            Text(index).tag(index)
                        }
                    }
                    .tint(Color(.backBar))
                    
                    //MARK: 語言
                    Picker("語言", selection: self.$fontLanguage)
                    {
                        ForEach(self.language.indices, id:\.self)
                        {index in
                            Text(self.language[index])//.tag(self.language[index])
                        }
                    }
                    .tint(Color(.backBar))
                }
                .listRowBackground(Color.clear)
                
                self.SmallDevider()
                
                Group
                {
                    //MARK: 系統設定
                    self.SmallSection(title: "系統設定", image: "gear")
                    
                    //MARK: 心情數量
                    Toggle("顯示心情數量", isOn: self.$activeNumber).tint(Color(.toggle))
                    
                    //MARK: 允許偷窺
                    Toggle("允許偷窺", isOn: self.$user.track).tint(Color(.toggle))
                        //SwiftUI有Bug：即使user.track是false 在重新開啟APP之後會是顯示true 所以寫判斷true false的onAppear
                        .onAppear
                        {
                            Realtimer().getTrack
                            {data in
                                self.user.track=(data=="true" ? true:false)
                            }
                        }
                        .onChange(of: self.user.track)
                        {(_, new) in
                            //更新Realtime Database中的資料
                            Realtimer().updateData(column: "Track", data: new)
                        }
                    
                    //MARK: 學校推薦
                    DisclosureGroup("學校推薦")
                    {
                        let name: [String]=["極具優勢", "安全穩固", "保守選填", "最適落點", "嘗試進攻", "夢幻校系", "其他參考"]
                        
                        ForEach(name.indices, id: \.self)
                        {index in
                            Button
                            {
                                self.prefer[index] = !self.prefer[index]
                            }
                            label:
                            {
                                HStack
                                {
                                    Text(name[index])
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark")
                                        .opacity(self.prefer[index] ? 1:0)
                                        .animation(.easeInOut, value: self.prefer[index])
                                }
                            }
                        }
                    }
                    .tint(Color(.backBar))
                    
                    //MARK: 每日通知
                    VStack
                    {
                        Toggle("每日通知", isOn: self.$notificate).tint(Color(.toggle))
                            .onChange(of: self.notificate)
                            {(_, new) in
                                //啟用每日通知
                                if(new)
                                {
                                    //依照自定義的時間設定每日通知 發布通知並將通知更新到mail
                                    self.mail.insert(notificateTime(time: Calendar.current.dateComponents([.hour, .minute], from: self.time)), at: 0)
                                    self.read.insert(false, at: 0)
                                }
                            }
                        
                        DatePicker("指定通知時間", selection: self.$time, displayedComponents: [.hourAndMinute])
                            .disabled(!self.notificate)
                            .opacity(self.notificate ? 1:0.25)
                            .animation(.easeInOut, value: self.notificate)
                            //儲存修改過後的每日通知時間
                            .onChange(of: self.time)
                            {(_, new) in
                                self.time=new
                            }
                    }
                }
                .listRowBackground(Color.clear)
                
                self.SmallDevider()
                
                //MARK: 服務
                Group
                {
                    self.SmallSection(title: "服務", image: "person.crop.fill")
                    
                    //MARK: 更改密碼
                    Button("更改密碼")
                    {
                        Authenticationer().resetPassword(account: self.user.account)
                        self.changePasswordAlert.showAlert(message: "「更改密碼郵件」\n已發送到您的電子郵件\n請前往確認")
                    }
                    .foregroundStyle(.blue)
                    .alert(isPresented: self.$changePasswordAlert.show)
                    {
                        return Alert(title: Text(self.changePasswordAlert.message))
                    }
                    
                    //MARK: 聯絡客服
                    //連接到Line應用程式 顯示官方帳號資訊
                    Link("聯絡客服", destination: URL(string: "https://line.me/R/ti/p/@805ndypi")!).foregroundStyle(.blue)
                    
                    //MARK: 關於我們
                    Button("關於我們")
                    {
                        self.showDeveloper.toggle()
                    }
                    .foregroundStyle(.blue)
                    
                    //MARK: 刪除帳號
                    Button
                    {
                        self.deleteAccountAlert.showAlert(title: "真的要讓我吃掉你嗎🥹", message: "海豹正淚眼汪汪的流著口水")
                    }
                    label:
                    {
                        Text("刪除帳號")
                            .bold()
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                    }
                    //alert觸發動作 顯示自定義的alert -> 將資料從資料庫中刪除
                    .alert(isPresented: self.$deleteAccountAlert.show)
                    {
                        return Alert(
                            title: Text(self.deleteAccountAlert.title!),
                            message: Text(self.deleteAccountAlert.message),
                            primaryButton: .destructive(Text("確認刪除")) { self.deleteAction() },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            
            HStack
            {
                //MARK: 登出按鈕
                Button
                {
                    Authenticationer().signOut
                    {
                        //登出動作完成之後再關閉畫面
                        self.signOutAction
                        {
                            self.dismiss()
                        }
                    }
                }
                label:
                {
                    Text("登出")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(.button))
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                //MARK: 退出按鈕
                Button
                {
                    self.exitAlert.showAlert(title: "真的要離開了嗎🥺", message: "海豹默默地擠出了一滴眼淚")
                }
                label:
                {
                    Text("退出")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(.button))
                        .clipShape(.rect(cornerRadius: 10))
                }
                //alert觸發動作 顯示自定義的alert
                .alert(isPresented: self.$exitAlert.show)
                {
                    return Alert(
                        title: Text(self.exitAlert.title!),
                        message: Text(self.exitAlert.message),
                        primaryButton: .destructive(Text("確認退出"),
                        action:
                        {
                            notificateInterval()
                            exit(0)
                        }),
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding(.horizontal, 30)
            .padding(.top)
        }
        .background(Color(.systemGray5))
        //MARK: 切換深淺模式View圖
        .createImage(
            toggle: self.toggleDark,
            current: self.$currentToggleImage,
            previous: self.$previousToggleImage,
            activate: self.$activeDark
        )
        //MARK: 深淺模式前後的截圖
        .overlay
        {
            GeometryReader
            {reader in
                let size=reader.size
                
                if let previous=self.previousToggleImage,
                   let current=self.currentToggleImage
                {
                    ZStack
                    {
                        Image(uiImage: previous)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width, height: size.height)
                        
                        Image(uiImage: current)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading)
                            {
                                Circle()
                                    .frame(
                                        width: self.clickPoint.width*(self.maskAnimation ? 80:1),
                                        height: self.clickPoint.height*(self.maskAnimation ? 80:1)
                                    )
                                    .frame(width: self.clickPoint.width, height: self.clickPoint.height)
                                    .offset(x: self.clickPoint.minX, y: self.clickPoint.minY)
                                    .ignoresSafeArea()
                            }
                    }
                    //MARK: 切換動畫
                    .task
                    {
                        //切換深淺模式動畫正在執行中
                        guard !self.maskAnimation else { return }
                        
                        //執行切換深淺模式動畫
                        withAnimation(.easeInOut(duration: 0.9), completionCriteria: .logicallyComplete)
                        {
                            self.maskAnimation=true
                        }
                        completion:
                        {
                            self.currentToggleImage=nil
                            self.previousToggleImage=nil
                            self.maskAnimation=false
                        }
                    }
                }
            }
            //動畫覆蓋
            .mask
            {
                Rectangle()
                    .overlay(alignment: .topLeading)
                    {
                        Circle()
                            .frame(width: self.clickPoint.width, height: self.clickPoint.height)
                            .offset(x: self.clickPoint.minX, y: self.clickPoint.minY)
                            .blendMode(.destinationOut)
                    }
            }
            .ignoresSafeArea()
        }
        //MARK: Sheet
        .sheet(isPresented: self.$showDeveloper)
        {
            DeveloperView().presentationDetents([.large])
        }
        //避免鍵盤出現擠壓到View
        .ignoresSafeArea(.keyboard)
        .navigationBarTitle("設定")
        .toolbarTitleDisplayMode(.inline)
        //隱藏系統預設的NavigationBarBackButton
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemGray5), for: .navigationBar)
        //MARK: Toolbar
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
        //執行動畫時不可互動
        .disabled(self.previousToggleImage != nil || self.currentToggleImage != nil || self.maskAnimation)
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
