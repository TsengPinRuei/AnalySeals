//
//  ProgressBar.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/21.
//

import SwiftUI

struct ProgressBar: View
{
    @Binding var page: Int
    @Binding var progress: CGFloat
    
    var body: some View
    {
        //根據頁面決定最大值 -> 頁面*10
        Gauge(value: self.progress, in: 0...70)
        {
        }
        .tint(
            LinearGradient(
                gradient: Gradient(colors: [Color(hexa: "66B5F6"), Color(hexa: "BFE299"), Color(hexa: "9DFBC8")]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .overlay(Capsule().stroke(Color(.toolbar), lineWidth: 2))
        //切換UpView中的TabView頁面時 改變進度條
        .onChange(of: self.page)
        {(_, new) in
            self.progress=CGFloat(new)*10
        }
        .animation(.easeInOut, value: self.progress)
    }
}
