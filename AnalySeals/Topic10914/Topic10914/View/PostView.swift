//
//  PostView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct PostView: View
{
    //紀錄登入狀態
    @AppStorage("signIn") var signIn: Bool=false
    
    @Binding var selection: Int
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //顯示LoadingView的狀態
    @State private var showLoading: Bool=false
    //顯示標籤列表的狀態
    @State private var showTagOption: Bool=false
    @State private var page: String="文字"
    //筆記標題
    @State private var noteTitle: String=""
    //筆記文字
    @State private var noteText: String=""
    //筆記標籤
    @State private var noteTag: String=""
    //圖片選擇功能用
    @State private var showImageOption: [Bool]=[false]
    //筆記圖片
    @State private var noteImage: [UIImage?]=[nil]
    //圖片來源
    @State private var source: [PhotoSource?]=[nil]
    //警戒訊息用
    @State private var result: Alerter=Alerter(message: "", show: false)
    
    //標籤
    private let tag: [String]=["學校資訊", "學業科目", "筆記攻略", "心情閒聊", "音樂", "繁星推薦", "個人申請", "考試分發", "特殊選才", "登記分發", "推薦甄試", "國外留學"]
    
    //MARK: 儲存筆記進資料庫
    private func uploadNote(completion: @escaping () -> Void) async
    {
        //確認是否登入
        guard let id=Authenticationer().getID()
        else
        {
            print("NotePostView Error: User not signed in")
            return
        }
        
        withAnimation(.easeInOut)
        {
            self.showLoading=true
        }
        
        let dateFormat: DateFormatter=DateFormatter()
        dateFormat.dateFormat="yyyy/MM/dd"
        
        let note: Note=Note(
            userId: id+" \(self.user.note)",
            user: self.user.account,
            title: self.noteTitle,
            text: self.noteText,
            tag: self.noteTag,
            collect: [],
            collectCount: 0,
            like: [],
            likeCount: 0,
            dislike: [],
            dislikeCount: 0,
            date: dateFormat.string(from: Date())
        )
        
        //將資料存進Firestore Database
        Firestorer().uploadNote(note: note, user: self.user)
        {
            //將圖片存進Firestore Storage
            Storager().uploadImage(noteID: note.userId, image: self.noteImage)
            {
                completion()
            }
        }
    }
    
    var body: some View
    {
        ZStack(alignment: .top)
        {
            //MARK: 背景顏色
            Color(.bottomBar).ignoresSafeArea(.all)
            
            VStack(spacing: 0)
            {
                HStack(spacing: 5)
                {
                    //MARK: Picker
                    Picker("", selection: self.$page)
                    {
                        Text("文字").tag("文字")
                        
                        Text("圖片").tag("圖片")
                    }
                    .pickerStyle(.segmented)
                    //利用GitHub的套件 修改SegmentedPicker的屬性
                    .introspect(.picker(style: .segmented), on: .iOS(.v13, .v14, .v15, .v16, .v17))
                    {picker in
                        //選擇Bar顏色
                        picker.selectedSegmentTintColor=UIColor(named: "SideColor")
                        //被選擇的字體及顏色
                        picker
                            .setTitleTextAttributes(
                                [
                                    .font: UIFont.preferredFont(forTextStyle: .headline),
                                    .foregroundColor: UIColor(named: "SideTextColor")!
                                ],
                                for: .selected
                            )
                        //未被選擇的字體及顏色
                        picker
                            .setTitleTextAttributes(
                                [
                                    .font: UIFont.preferredFont(forTextStyle: .caption1),
                                    .foregroundColor: UIColor.systemGray6
                                ],
                                for: .normal
                            )
                    }
                    .background(Color(.toolbar))
                    .clipShape(.rect(cornerRadius: 8))
                    
                    //MARK: 發佈按鈕
                    Button
                    {
                        if(!self.signIn)
                        {
                            self.result.showAlert(title: "討厭啦😍\n你還沒「登入」", message: "快去成為小魚唷")
                        }
                        else
                        {
                            //驗證筆記失敗
                            if(self.noteTitle.isEmpty || self.noteText.isEmpty)
                            {
                                self.result.showAlert(title: "無法發佈筆記😥", message: "檢查一下是不是少了什麼唷")
                            }
                            //驗證筆記成功
                            else
                            {
                                //為筆記添加標籤
                                self.showTagOption.toggle()
                            }
                        }
                    }
                    label:
                    {
                        Image(systemName: "paperplane.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .tint(Color(.toolbar))
                    }
                    //MARK: 標籤
                    .popover(isPresented: self.$showTagOption)
                    {
                        VStack(alignment: .leading)
                        {
                            ForEach(self.tag, id: \.self)
                            {index in
                                //添加完標籤 分享筆記
                                Button("# ".appending(index))
                                {
                                    SwiftUI.Task
                                    {
                                        self.showTagOption.toggle()
                                        //儲存標籤
                                        self.noteTag=index
                                        //將筆記存進Firestore Database及Firebase Storage
                                        await self.uploadNote()
                                        {
                                            //上傳及儲存完畢之後再初始化
                                            self.noteTitle=""
                                            self.noteText=""
                                            self.noteTag=""
                                            self.showImageOption=[false]
                                            self.noteImage=[nil]
                                            self.source=[nil]
                                        }
                                        
                                        //等popover關閉之後才能顯示alert
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
                                        {
                                            withAnimation(.easeInOut)
                                            {
                                                self.showLoading=false
                                            }
                                            self.result.showAlert(title: "筆記分享成功🤩", message: "")
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                //最後一個選項後面不需要分隔線
                                if(index != "國外留學")
                                {
                                    Divider()
                                }
                            }
                        }
                        .padding(.vertical)
                        .presentationCompactAdaptation(.popover)
                        .presentationBackground(.ultraThinMaterial)
                    }
                }
                .padding(5)
                
                //MARK: 文字頁面
                if(self.page=="文字")
                {
                    PostTextView(noteTitle: self.$noteTitle, noteText: self.$noteText, noteTag: self.$noteTag)
                        .transition(.opacity.animation(.easeInOut.speed(2)))
                }
                //MARK: 圖片頁面
                else
                {
                    PostImageView(image: self.$noteImage, showOption: self.$showImageOption, source: self.$source)
                        .transition(.opacity.animation(.easeInOut.speed(2)))
                }
            }
            
            //MARK: LoadingView
            if(self.showLoading)
            {
                LoadingView(type: "")
                    .frame(maxHeight: .infinity, alignment: .center)
                    .ignoresSafeArea(.all)
                    .transition(.opacity.animation(.easeInOut))
            }
        }
        //解決BottomBarView背景顏色受到PostImageView影響的問題
        .padding(.bottom, self.page=="文字" ? 0:1)
        //MARK: Alert
        .alert(isPresented: self.$result.show)
        {
            Alert(
                title: Text(self.result.title!),
                message: Text(self.result.message),
                dismissButton: .default(Text("我知道了"))
            )
        }
    }
}
