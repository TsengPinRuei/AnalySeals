//
//  UserView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/28.
//

import SwiftUI

struct UserView: View
{
    @State private var gender: String?
    @State private var name: String?
    @State private var bio: String?
    @State private var degree: String?
    @State private var school: String?
    
    let note: Note
    
    var headSize: CGFloat
    //名字大小
    var nameSize: Font
    //個性簽名大小
    var bioSize: Font
    //內容大小
    var textSize: Font
    
    private func setFont(size: Font) -> Font
    {
        switch(size)
        {
            case .title:
                return .title2
            case .title2:
                return .title3
            case .title3:
                return .body
            default :
                return size
        }
    }
    private func setSpacing() -> CGFloat
    {
        switch(self.textSize)
        {
            case .title3:
                return 18
            case .body:
                return 8
            default:
                return 10;
        }
    }
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: self.setSpacing())
        {
            HStack
            {
                //MARK: 作者性別
                if(self.gender==nil)
                {
                    Image(.load)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.headSize)
                        .overlay(Circle().stroke(.black, lineWidth: 1))
                        .onAppear
                        {
                            //取得作者性別
                            Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Gender")
                            {data in
                                self.gender=data
                            }
                        }
                }
                else
                {
                    Image(self.note.user=="topicgood123@gmail.com" ? "seal":(self.gender=="男生" ? "male":"female"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.headSize)
                        .overlay(Circle().stroke(.black, lineWidth: 1))
                }
                
                VStack(alignment: .leading)
                {
                    //MARK: 作者名字
                    Text(self.name ?? "")
                        .bold()
                        .font(self.setFont(size: self.nameSize))
                        .onAppear
                        {
                            //取得作者名字
                            Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Name")
                            {data in
                                self.name=data
                            }
                        }
                    
                    //MARK: 個性簽名
                    //有個性簽名 及 個性簽名非空值
                    if let bio=self.bio, !bio.isEmpty
                    {
                        Text(bio)
                            .font(self.setFont(size: self.bioSize))
                            .foregroundStyle(.gray)
                            .lineLimit(self.bioSize == .body ? 2:1)
                            .onAppear
                            {
                                //取得作者個性簽名
                                Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Bio")
                                {data in
                                    //避免被nil覆蓋
                                    if(self.bio==nil)
                                    {
                                        self.bio=data
                                    }
                                }
                            }
                    }
                    else
                    {
                        Text("啵啵啵...啵啵")
                            .font(self.setFont(size: self.bioSize))
                            .foregroundStyle(.gray)
                            .lineLimit(self.bioSize == .body ? 2:1)
                            .onAppear
                            {
                                //取得作者個性簽名
                                Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Bio")
                                {data in
                                    //避免被nil覆蓋
                                    if(self.bio==nil)
                                    {
                                        self.bio=data
                                    }
                                }
                            }
                    }
                }
            }
            
            if(self.bioSize != .system(size: 0.01))
            {
                Divider()
            }
            
            //MARK: 筆記日期
            HStack(spacing: 0)
            {
                Text("筆記生日：").bold()
                
                Text(self.note.date)
            }
            .font(self.setFont(size: self.textSize))
            
            //MARK: 最高學歷
            HStack(spacing: 0)
            {
                Text("最高學歷：").bold()
                
                Text(self.degree ?? "")
                    .onAppear
                    {
                        //取得作者學歷
                        Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "Degree")
                        {data in
                            self.degree=data
                        }
                    }
            }
            .font(self.setFont(size: self.textSize))
            
            //MARK: 就讀學校
            HStack(spacing: 0)
            {
                if(self.bioSize != .system(size: 0.01))
                {
                    Text("目前就讀學校：").bold()
                }
                
                Text(self.school ?? "")
                    .frame(maxWidth: .infinity,alignment: self.bioSize == .system(size: 0.01) ? .center:.leading)
                    .onAppear
                    {
                        //取得作者學校
                        Firestorer().getNoteUserColumn(noteID: self.note.userId, column: "School")
                        {data in
                            self.school=data
                        }
                    }
            }
            .font(self.setFont(size: self.textSize))
        }
        .foregroundStyle(Color(.fieldText))
        .padding(self.bioSize == .system(size: 0.01) ? 5:10)
    }
}
