//
//  NoteView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/2.
//

import SwiftUI

struct NoteView: View
{
    //紀錄顯示心情數量
    @AppStorage("activeNumber") private var activeNumber=true
    //紀錄登入狀態
    @AppStorage("signIn") private var signIn: Bool=false
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //顯示筆記作者的狀態(sheet)
    @State private var showFish: Bool=false
    //顯示筆記作者的狀態(NoteView上)
    @State private var showUser: Bool=false
    //顯示作者筆記的狀態
    @State private var showNote: Bool=false
    //作者性別
    @State private var gender: String?
    //作者是否允許偷窺
    @State private var track: String?
    @State private var deleteAlert: Alerter=Alerter(message: "", show: false)
    @State private var reportAlert: Alerter=Alerter(message: "", show: false)
    
    //寬
    var width: CGFloat
    //長
    var height: CGFloat
    //頭像大小
    var headSize: CGFloat
    //標題大小
    var titleSize: Font
    //內容大小
    var textSize: Font
    //標籤大小
    var tagSize: Font
    //互動
    var active: Bool
    var activeSize: CGFloat
    
    @State var note: Note
    
    //重新整理筆記列表
    @Binding var refresh: Bool
    
    //MARK: 刪除筆記及更改筆記數量
    private func deleteNote() async
    {
        //noteID要是上傳該筆記時的ID
        Storager().deleteImage(noteID: self.note.userId)
        
        //從Firestore Database刪除筆記
        Firestorer().deleteNote(id: self.note.userId)
        
        //從Realtime Database更新筆記數量-1 如果count是nil 可能是因為沒有數量 所以1-1=0也符合
        Realtimer().updateData(column: "Note", data: "\(self.user.note-1)")
        {
            self.user.note-=1
        }
        
        self.refresh.toggle()
    }
    private func setLineLimit() -> Int
    {
        switch(self.textSize)
        {
            case .body:
                return 4
            case .subheadline:
                return 3
            default:
                return 5
        }
    }
    //MARK: 新增或刪除Firestore Database中指定欄位陣列的資料
    private func setNoteColumn(delete: Bool, id: String, account: String, column: String)
    {
        //刪除
        if(delete)
        {
            Firestorer().deleteNoteColumn(note: id, column: column, user: account)
        }
        //新增
        else
        {
            Firestorer().updateNoteColumn(note: id, column: column, user: account)
        }
    }
    //MARK: 新增或刪除Firestore Database中指定欄位中的資料
    private func setNoteCountColumn(id: String, column: String, number: Int)
    {
        Firestorer().updateNoteCountColumn(note: id, column: column, number: number)
    }
    
    var body: some View
    {
        //MARK: 還在從Firestore抓取資料
        if(self.gender==nil)
        {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: self.width)
                .frame(height: self.height)
                //載入中動畫
                .shimmer(
                    ShimmerConfiguration(
                        tint: Color(red: 225/255, green: 225/255, blue: 225/255),
                        highlight: Color(red: 30/255, green: 30/255, blue: 30/255).opacity(0.5),
                        blur: 10
                    )
                )
                //筆記框線
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 1))
                //筆記背景陰影
                .background(RoundedRectangle(cornerRadius: 20).fill(.black.shadow(.drop(radius: 5))))
                .onAppear
                {
                    //取得作者性別
                    Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Gender")
                    {data in
                        self.gender=data
                    }
                }
        }
        //MARK: 抓取Firestore資料完成
        else
        {
            //筆記背景
            Image(.notePaper)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: self.width)
                .frame(height: self.height)
                //筆記形狀
                .clipShape(.rect(cornerRadius: 20))
                //筆記框線
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.backBar), lineWidth: 1))
                //筆記背景陰影
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.backBar).shadow(.drop(radius: 5))))
                //MARK: 頭像 標題 內容
                .overlay(alignment: .topLeading)
                {
                    if(!self.showUser)
                    {
                        VStack(alignment: .leading)
                        {
                            HStack
                            {
                                Image(self.note.user=="topicgood123@gmail.com" ? "seal":(self.gender=="男生" ? "male":"female"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.headSize)
                                    .aspectRatio(3/2, contentMode: .fill)
                                    .shadow(color: .black,radius: 2)
                                    //在PlainList中Button會失效 所以用onTapGesture
                                    .onTapGesture
                                    {
                                        //顯示作者資訊
                                        withAnimation(.smooth)
                                        {
                                            self.showUser.toggle()
                                        }
                                    }
                                
                                Text(self.note.title)
                                    .bold()
                                    .font(self.titleSize)
                                    .lineLimit(1)
                                
                                //MARK: NotePaperView
                                NavigationLink(destination: NotePaperView(note: self.$note))
                                {
                                    EmptyView()
                                }
                                //避免擠壓到標題
                                .frame(width: 0, height: 0)
                            }
                            
                            //避免字數太多超出筆記範圍
                            Text(self.note.text).font(self.textSize).lineLimit(self.setLineLimit())
                        }
                        .padding(10)
                        .transition(.opacity)
                    }
                }
                //MARK: 收藏 標籤 喜歡 不喜歡 互動
                .overlay(alignment: .bottom)
                {
                    VStack
                    {
                        Capsule()
                            .fill(.black)
                            .frame(height: 1)
                        
                        HStack(spacing: 15)
                        {
                            //MARK: 收藏
                            HStack(spacing: 5)
                            {
                                Image(systemName: self.note.collect.contains(self.user.account) ? "bookmark.fill":"bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: self.activeSize)
                                    .foregroundStyle(.blue)
                                    //在PlainList中Button會失效 所以用onTapGesture
                                    .onTapGesture
                                    {
                                        //登入狀態
                                        if(self.signIn)
                                        {
                                            //MARK: 取消收藏
                                            if(self.note.collect.contains(self.user.account))
                                            {
                                                self.note.collect.remove(at: self.note.collect.firstIndex(of: self.user.account) ?? -1)
                                                
                                                //從Firestore Database的collect欄位陣列中移除該帳號
                                                self.setNoteColumn(
                                                    delete: true,
                                                    id: self.note.userId,
                                                    account: self.user.account,
                                                    column: "collect"
                                                )
                                                
                                                //從Firestore Database的collectCount欄位中-1
                                                self.setNoteCountColumn(id: self.note.userId, column: "collectCount", number: -1)
                                            }
                                            //MARK: 收藏
                                            else
                                            {
                                                self.note.collect.append(self.user.account)
                                                
                                                //從Firestore Database的collect欄位陣列中新增該帳號
                                                self.setNoteColumn(
                                                    delete: false,
                                                    id: self.note.userId,
                                                    account: self.user.account,
                                                    column: "collect"
                                                )
                                                
                                                //從Firestore Database的collectCount欄位中+1
                                                self.setNoteCountColumn(id: self.note.userId, column: "collectCount", number: 1)
                                            }
                                        }
                                        //未登入狀態
                                        else
                                        {
                                            self.deleteAlert.showAlert(title: "討厭啦😍\n你還沒「登入」", message: "快去成為小魚唷")
                                        }
                                    }
                                    .animation(.easeInOut, value: self.note.collect)
                                
                                //MARK: 顯示心情數量
                                if(self.activeNumber)
                                {
                                    Text("\(self.note.collect.count)")
                                        .font(.body)
                                        .foregroundStyle(.blue)
                                        .animation(.bouncy, value: self.note.collect.count)
                                        .contentTransition(.numericText())
                                }
                            }
                            
                            Text("# \(self.note.tag)")
                                .bold()
                                .font(self.tagSize)
                                .foregroundStyle(.white)
                                .padding(6)
                                .background(Capsule(style: .continuous).fill(Color(.fieldText)))
                                .opacity(self.tagSize == .system(size: 0.01) ? 0:1)
                            
                            Spacer()
                            
                            if(self.active)
                            {
                                //MARK: 喜歡
                                HStack(spacing: 5)
                                {
                                    Image(self.note.like.contains(self.user.account) ? "likeR":"likeW")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: self.activeSize)
                                        //在PlainList中Button會失效 所以用onTapGesture
                                        .onTapGesture
                                        {
                                            //登入狀態
                                            if(self.signIn)
                                            {
                                                //MARK: 取消喜歡
                                                if(self.note.like.contains(self.user.account))
                                                {
                                                    self.note.like.remove(at: self.note.like.firstIndex(of: self.user.account) ?? -1)
                                                    
                                                    //從Firestore Database的like欄位陣列中移除該帳號
                                                    self.setNoteColumn(
                                                        delete: true,
                                                        id: self.note.userId,
                                                        account: self.user.account,
                                                        column: "like"
                                                    )
                                                    
                                                    //從Firestore Database的likeCount欄位中-1
                                                    self.setNoteCountColumn(id: self.note.userId, column: "likeCount", number: -1)
                                                }
                                                //MARK: 喜歡
                                                else
                                                {
                                                    self.note.like.append(self.user.account)
                                                    
                                                    //從Firestore Database的like欄位陣列中新增該帳號
                                                    self.setNoteColumn(
                                                        delete: false,
                                                        id: self.note.userId,
                                                        account: self.user.account,
                                                        column: "like"
                                                    )
                                                    
                                                    //從Firestore Database的likeCount欄位中+1
                                                    self.setNoteCountColumn(id: self.note.userId, column: "likeCount", number: 1)
                                                }
                                            }
                                            //未登入狀態
                                            else
                                            {
                                                self.deleteAlert.showAlert(title: "討厭啦😍\n你還沒「登入」", message: "快去成為小魚唷")
                                            }
                                        }
                                    
                                    if(self.activeNumber)
                                    {
                                        Text("\(self.note.like.count)")
                                            .font(.body)
                                            .animation(.bouncy, value: self.note.like.count)
                                            .contentTransition(.numericText())
                                    }
                                }
                                
                                //MARK: 不喜歡
                                HStack(spacing: 5)
                                {
                                    Image(self.note.dislike.contains(self.user.account) ? "dislikeG":"dislikeW")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: self.activeSize)
                                        //在PlainList中Button會失效 所以用onTapGesture
                                        .onTapGesture
                                        {
                                            //登入狀態
                                            if(self.signIn)
                                            {
                                                //MARK: 取消不喜歡
                                                if(self.note.dislike.contains(self.user.account))
                                                {
                                                    self.note.dislike.remove(at: self.note.dislike.firstIndex(of: self.user.account) ?? -1)
                                                    
                                                    //從Firestore Database的dislike欄位陣列中移除該帳號
                                                    self.setNoteColumn(
                                                        delete: true,
                                                        id: self.note.userId,
                                                        account: self.user.account,
                                                        column: "dislike"
                                                    )
                                                    
                                                    //從Firestore Database的dislikeCount欄位中-1
                                                    self.setNoteCountColumn(id: self.note.userId, column: "dislikeCount", number: -1)
                                                }
                                                //MARK: 不喜歡
                                                else
                                                {
                                                    self.note.dislike.append(self.user.account)
                                                    
                                                    //從Firestore Database的dislike欄位陣列中新增該帳號
                                                    self.setNoteColumn(
                                                        delete: false,
                                                        id: self.note.userId,
                                                        account: self.user.account,
                                                        column: "dislike"
                                                    )
                                                    
                                                    //從Firestore Database的dislikeCount欄位中+1
                                                    self.setNoteCountColumn(id: self.note.userId, column: "dislikeCount", number: 1)
                                                }
                                            }
                                            //未登入狀態
                                            else
                                            {
                                                self.deleteAlert.showAlert(title: "討厭啦😍\n你還沒「登入」", message: "快去成為小魚唷")
                                            }
                                        }
                                    
                                    if(self.activeNumber)
                                    {
                                        Text("\(self.note.dislike.count)")
                                            .font(.body)
                                            .animation(.bouncy, value: self.note.dislike.count)
                                            .contentTransition(.numericText())
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                }
                .overlay(alignment: .top)
                {
                    if(self.showUser)
                    {
                        //MARK: 作者資訊
                        UserView(
                            note: self.note,
                            headSize: self.headSize,
                            nameSize: self.titleSize,
                            bioSize: self.tagSize,
                            textSize: self.textSize
                        )
                        //增加點擊範圍
                        .background(.white.opacity(0.01))
                        .onTapGesture
                        {
                            //顯示作者資訊
                            withAnimation(.smooth)
                            {
                                self.showUser.toggle()
                            }
                        }
                        .transition(.scale)
                    }
                }
                .foregroundStyle(Color(.fieldText))
                //不能跟抓取gender資料一起執行
                .onAppear
                {
                    //MARK: 偷窺允許
                    //取得作者是否允許偷窺 取作者帳號ID 所以最後筆記數量要去掉
                    Realtimer()
                        .getTrack(userID: String(self.note.userId[self.note.userId.startIndex..<self.note.userId.firstIndex(of: " ")!]))
                        {data in
                            self.track=data
                        }
                }
                //MARK: ContextMenu
                .contextMenu
                {
                    Button
                    {
                        self.showFish.toggle()
                    }
                    label:
                    {
                        HStack
                        {
                            Text("這是什麼魚")
                            Spacer()
                            Image(systemName: "fish")
                        }
                    }
                    
                    Button
                    {
                        self.showNote.toggle()
                    }
                    label:
                    {
                        //MARK: 作者允許偷窺
                        if(self.track=="true")
                        {
                            HStack
                            {
                                Text("偷窺一下🤫")
                                
                                Spacer()
                                
                                Image(systemName: "eyes")
                            }
                        }
                        //MARK: 作者不允許偷窺
                        else
                        {
                            HStack
                            {
                                Text("這隻小魚很害羞🫥")
                                
                                Spacer()
                                
                                Image(systemName: "eye.slash")
                            }
                        }
                    }
                    .disabled(self.track=="false")
                    
                    //MARK: 編輯筆記
                    if(self.note.user==self.user.account)
                    {
                        NavigationLink(destination: NoteEditView(note: self.$note))
                        {
                            HStack
                            {
                                Text("編輯筆記")
                                
                                Spacer()
                                
                                Image(systemName: "pencil.circle")
                            }
                        }
                    }
                    
                    //MARK: 刪除筆記
                    //使用者就是作者 可以刪除筆記
                    if(self.note.user==self.user.account)
                    {
                        Button(role: .destructive)
                        {
                            self.deleteAlert.showAlert(title: "這項操作不會還原！", message: "可能有某隻魚正收藏著你的筆記呢😢")
                        }
                        label:
                        {
                            HStack
                            {
                                Text("撕掉筆記")
                                
                                Spacer()
                                
                                Image(systemName: "trash")
                            }
                        }
                    }
                    //MARK: 檢舉
                    //使用者不是作者 可以舉報作者
                    else
                    {
                        Button(role: .destructive)
                        {
                            self.reportAlert.showAlert(title: "確定要舉報嗎", message: "若舉報通過 本豹會把它吃掉🤤")
                        }
                        label:
                        {
                            HStack
                            {
                                Text("檢舉🤯")
                                
                                Spacer()
                                
                                Image(systemName: "person.crop.circle.badge.exclamationmark")
                            }
                        }
                    }
                }
                //MARK: 舉報Alert
                .alert(self.reportAlert.title ?? "", isPresented: self.$reportAlert.show)
                {
                    TextField("舉報原因...", text: .constant("")).foregroundStyle(.orange)
                    
                    Button("取消", role: .cancel)
                    {
                    }
                    
                    Button("確定舉報", role: .destructive)
                    {
                    }
                }
                message:
                {
                    Text("確定舉報後 本豹會拿起放大鏡檢查\n".appending(self.reportAlert.message))
                }
                //MARK: 刪除筆記Alert
                .alert(isPresented: self.$deleteAlert.show)
                {
                    if(!self.signIn)
                    {
                        return Alert(
                            title: Text(self.deleteAlert.title!),
                            message: Text(self.deleteAlert.message),
                            dismissButton: .default(Text("我知道了"))
                        )
                    }
                    else
                    {
                        return Alert(
                            title: Text(self.deleteAlert.title!),
                            message: Text(self.deleteAlert.message),
                            primaryButton: .default(Text("取消"), action: {}),
                            secondaryButton: .destructive(Text("確定撕掉"))
                            {
                                //因為CoreData有Task屬性 所以要指定SwiftUI中的Task
                                SwiftUI.Task
                                {
                                    await self.deleteNote()
                                }
                            }
                        )
                    }
                }
                .sheet(isPresented: self.$showFish)
                {
                    //MARK: 作者完整資訊
                    UserInformationView(note: self.note)
                        .presentationBackground(.thinMaterial)
                        .presentationDetents([.medium, .large])
                        .presentationContentInteraction(.scrolls)
                }
                .fullScreenCover(isPresented: self.$showNote)
                {
                    //MARK: 作者筆記資訊
                    UserNoteView(note: self.$note)
                }
        }
    }
}
