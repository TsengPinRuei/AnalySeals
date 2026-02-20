//
//  BottomBarView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/6.
//

import SwiftUI

struct BottomBarView: View
{
    @State private var selection: Int=0
    
    var body: some View
    {
        TabView(selection: self.$selection)
        {
            HomeView(selection: self.$selection).tag(0)
            
            PreferView(selection: self.$selection).tag(1)
            
            //避免鍵盤擠壓到畫面
            PostView(selection: self.$selection).ignoresSafeArea(.keyboard).tag(2)
            
            //避免鍵盤擠壓到畫面
            PointView(selection: self.$selection).ignoresSafeArea(.keyboard).tag(3)
            
            TestView(selection: self.$selection).tag(4)
        }
        //利用Github的套件讓SwiftUI更方便使用UIKit的功能
        .introspect(.tabView, on: .iOS(.v13, .v14, .v15, .v16, .v17))
        {tab in
            //TabView背景顏色
            tab.tabBar.backgroundColor=UIColor(named: "BottomBarColor")
            //TabView未選取的顏色
            tab.tabBar.unselectedItemTintColor=UIColor.black
        }
        .overlay(alignment: .bottom)
        {
            BottomBar(selection: self.$selection)
        }
    }
}
