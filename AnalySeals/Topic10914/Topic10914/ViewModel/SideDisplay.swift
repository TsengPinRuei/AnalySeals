//
//  SideDisplay.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/5/2.
//

import SwiftUI

//SideBar展示的方式
struct SideDisplay: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    
    var item: [SideItem]
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 30)
        {
            ForEach(self.item)
            {index in
                SideLink(id: index.id, icon: index.icon, text: index.text)
            }
        }
        .foregroundStyle(self.activateDark ? .white:Color(.sideText))
        .padding(.vertical, 15)
        .padding(.leading, 10)
    }
}
