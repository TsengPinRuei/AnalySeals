//
//  UserInformationView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/23.
//

import SwiftUI

struct UserInformationView: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    
    //從資料庫取得的使用者資料
    @EnvironmentObject var user: User
    
    //顯示選擇標籤視窗的狀態
    @State private var showTag: Bool=false
    @State private var account: String=""
    //標籤 名字 個性簽名 性別 城市 最高學歷 學校 筆記數量
    @State private var data: [String?]=[nil, nil, nil, nil, nil, nil, nil, nil]
    
    //資訊圖示
    private let image: [String]=["mappin.and.ellipse", "graduationcap.fill", "house.lodge"]
    //資訊欄位
    private let study: [String]=["位居城市", "最高學歷", "就讀學校"]
    private let tag: [String]=["最耀眼的繁星", "天選之人", "考試機器", "特選天才", "登登登登", "推甄大師", "IMㄟ嗶西", "沙發馬鈴薯", "只會呼吸吐氣的肉", "+365"]
    
    let note: Note
    
    var body: some View
    {
        //因為標籤選擇視窗要覆蓋所有畫面
        ZStack
        {
            VStack(alignment: .leading)
            {
                HStack(spacing: 30)
                {
                    //MARK: 頭像
                    Image(self.account.isEmpty ? "load":(self.account=="topicgood123@gmail.com" ? "seal":(self.data[3]=="男生" ? "male":"female")))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .overlay(Circle().stroke(.black, lineWidth: 1))
                    
                    //MARK: 筆記數量
                    VStack
                    {
                        Text(self.data[7] ?? "0").fontWeight(.semibold)
                        Text("筆記")
                    }
                    .font(.body)
                    
                    //MARK: 官方標籤
                    if(self.account=="topicgood123@gmail.com")
                    {
                        //配合手機螢幕大小
                        HStack(spacing: 6)
                        {
                            Text("豹讀詩書")
                                .padding(10)
                                .background(Color(.side))
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                            
                            Text("豹團取暖")
                                .padding(10)
                                .background(Color(.side))
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                        }
                        .font(.body)
                        .foregroundStyle(Color(.sideText))
                    }
                    else
                    {
                        Button
                        {
                            //動畫顯示選擇標籤視窗
                            withAnimation(.easeInOut)
                            {
                                self.showTag.toggle()
                            }
                        }
                        label:
                        {
                            //MARK: 標籤
                            if let userTag=self.data[0]
                            {
                                Text(userTag)
                                    .font(.body)
                                    .foregroundStyle(Color(.sideText))
                                    .padding(10)
                                    .background(Color(.side))
                                    .clipShape(.rect(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                            }
                            //MARK: 無標籤
                            else
                            {
                                Text("這隻小魚沒有鱗片😢")
                                    .font(.body)
                                    .foregroundStyle(Color(.sideText))
                                    .padding(10)
                                    .background(Color(.systemGray3))
                                    .clipShape(.rect(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(self.account != self.user.account || self.account=="topicgood123@gmail.com")
                    }
                }
                
                //MARK: 名字
                Text(self.data[1] ?? "還在游...")
                    .bold()
                    .font(.title)
                
                //MARK: 個性簽名
                List
                {
                    Text(self.data[2] ?? "啵啵啵...啵啵")
                        //與背景融為一體
                        .listRowBackground(self.activateDark ? Color(.systemGray6):Color.white)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
                .scrollIndicators(.hidden)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                
                //MARK: 帳號
                Text(self.account=="topicgood123@gmail.com" ? "這隻海豹何方神獸...":"這隻魚什麼來頭...")
                    .font(.headline)
                    .padding(.top)
                
                Capsule(style: .continuous)
                    .fill(.gray)
                    .frame(width: 150, height: 1)
                
                //MARK: 最高學歷
                ForEach(self.study.indices, id: \.self)
                {index in
                    HStack
                    {
                        Image(systemName: "\(self.image[index])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.gray)
                        
                        Text(self.study[index].appending("：")).bold()
                        
                        Text(self.data[index+4] ?? "")
                    }
                    .font(.body)
                }
            }
            .padding()
            
            Color.black
                .ignoresSafeArea(.all)
                .opacity(self.showTag ? 0.5:0)
                .clipShape(.rect(cornerRadius: 10))
                //MARK: 更新標籤
                .onTapGesture
                {
                    //有選擇標籤 將標籤更新進資料庫
                    if let userTag=self.data[0]
                    {
                        Realtimer().updateData(column: "MeTag", data: userTag)
                        {
                            self.user.meTag=userTag
                        }
                    }
                    
                    //關閉標籤顯示視窗
                    withAnimation(.smooth)
                    {
                        self.showTag.toggle()
                    }
                }
            
            //MARK: 標籤選擇視窗
            if(self.showTag)
            {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.rectangle))
                    .frame(height: 300)
                    .overlay(alignment: .topLeading)
                    {
                        VStack(alignment: .leading)
                        {
                            ForEach([0, 2, 4, 6, 8], id: \.self)
                            {index in
                                HStack
                                {
                                    ForEach(index...index+1, id: \.self)
                                    {indexx in
                                        Button
                                        {
                                            //動畫式切換標籤
                                            withAnimation(.easeInOut.speed(1.5))
                                            {
                                                self.data[0]=self.tag[indexx]
                                            }
                                        }
                                        label:
                                        {
                                            Text(self.tag[indexx])
                                                .foregroundStyle(Color(.sideText))
                                                .padding(10)
                                                .background(Color(.side))
                                                .clipShape(.rect(cornerRadius: 10))
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    .transition(.scale)
            }
        }
        //MARK: Realtime Database
        .onAppear
        {
            let userID: String=String(self.note.userId[self.note.userId.startIndex..<self.note.userId.firstIndex(of: " ")!])
            
            //MARK: 帳號
            Realtimer().getUserData(userID: userID, column: "Account")
            {data in
                self.account=data!
            }
            
            //MARK: 標籤
            Realtimer().getUserData(userID: userID, column: "MeTag")
            {data in
                self.data[0]=data
            }
            
            //MARK: 名字
            Realtimer().getUserData(userID: userID, column: "Name")
            {data in
                self.data[1]=data
            }
            
            //MARK: 個性簽名
            Realtimer().getUserData(userID: userID, column: "Bio")
            {data in
                self.data[2]=data
            }
            
            //MARK: 性別
            Realtimer().getUserData(userID: userID, column: "Gender")
            {data in
                self.data[3]=data
            }
            
            //MARK: 城市
            Realtimer().getUserData(userID: userID, column: "City")
            {data in
                self.data[4]=data
            }
            
            //MARK: 最高學歷
            Realtimer().getUserData(userID: userID, column: "Degree")
            {data in
                self.data[5]=data
            }
            
            //MARK: 學校
            Realtimer().getUserData(userID: userID, column: "School")
            {data in
                self.data[6]=data
            }
            
            //MARK: 筆記數量
            Realtimer().getUserData(userID: userID, column: "Note")
            {data in
                self.data[7]=data
            }
        }
    }
}
