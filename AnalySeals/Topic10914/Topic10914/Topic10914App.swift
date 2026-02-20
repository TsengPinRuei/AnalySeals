//
//  Topic10914App.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/4.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseDatabase
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Topic10914App: App
{
    //記錄深淺模式
    @AppStorage("activateDark") private var activeDark: Bool=false
    //紀錄字型大小
    @AppStorage("fontSize") private var fontSize: String="預設"
    //紀錄登入狀態
    @AppStorage("signIn") var signIn: Bool=false
    
    //提供所有View使用的使用者資料
    @StateObject var user: User=User()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController=PersistenceController.shared
    
    var body: some Scene
    {
        WindowGroup
        {
            IntroView()
                //CoreData -> ToDoCalendarView
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //SwiftData -> ToDoMonthView ToDoWeekView
                //目前SwiftData還不能儲存多個Model 所以只儲存WeekTask
                .modelContainer(for: WeekTask.self)
                //提供所有View使用的使用者資料
                .environmentObject(self.user)
                //深淺模式
                .preferredColorScheme(self.activeDark ? .dark:.light)
                //字體大小
                .fontSize(size: self.fontSize)
                //連接資料庫 授權通知
                .onAppear
                {
                    //取得Firebase中的指定資料名稱
                    Realtimer().getData(column: "Account")
                    {data in
                        if let data=data
                        {
                            let reference =
                            Database
                                .database()
                                .reference()
                                .child("User")
                                .queryOrdered(byChild: "Account")
                                .queryEqual(toValue: data)
                            
                            self.user.account=data
                            //將資料存進user
                            reference.observeSingleEvent(of: .value)
                            {snapshot in
                                if let value=snapshot.value as? [String: Any]
                                {
                                    let user=value.first!.value as! [String: Any]
                                    
                                    self.user.password=user["Password"] as! String
                                    self.user.name=user["Name"] as! String
                                    self.user.gender=user["Gender"] as! String
                                    self.user.degree=user["Degree"] as! String
                                    self.user.city=user["City"] as! String
                                    self.user.school=user["School"] as! String
                                    self.user.bio=user["Bio"] as? String
                                    self.user.note=Int(user["Note"] as! String)!
                                }
                            }
                        }
                    }
                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
                    {(granted, error) in
                        //if(granted) { print("User notifications are allowed.") }
                        //else { print("User notifications are not allowed.") }
                    }
                }
        }
    }
}
