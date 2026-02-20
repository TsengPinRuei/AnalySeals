//
//  SideLink.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/20.
//

import SwiftUI

//SideItem連結的資料
struct SideLink: View
{
    var id: Int
    var icon: String
    var text: String
    
    //設定要切換到哪個View
    private func setDestination(id: Int) -> some View
    {
        switch(id)
        {
            case itemId+1:
                return AnyView(MyNoteView())
            case itemId+2:
                return AnyView(CollectionView())
            case itemId+3:
                return AnyView(SettingView())
            case itemId+4:
                return AnyView(NewsMailView())
            case itemId+5:
                return AnyView(LinkView())
            case itemId+6:
                return AnyView(SchoolRankView())
            case itemId+7:
                return AnyView(OfficialView())
            case itemId+8:
                return AnyView(NoteRankView())
            case itemId+9:
            return AnyView(PrayView())
            default:
                return AnyView(ProgressView())
        }
    }
    
    var body: some View
    {
        //設定每一個項目連結到什麼畫面
        NavigationLink(destination: self.setDestination(id: self.id))
        {
            HStack
            {
                if(self.icon.isEmpty)
                {
                    Image(.seal)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.leading, 10)
                }
                else
                {
                    Image(systemName: self.icon)
                        .resizable()
                        .scaledToFit()
                        //收藏的icon用30會太大
                        .frame(width: id==itemId+2 ? 25:30)
                        .padding(.horizontal, 10)
                }
                
                Text(self.text)
            }
        }
    }
}
