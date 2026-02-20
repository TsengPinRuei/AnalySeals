//
//  ContentView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/4.
//

import SwiftUI

struct ContentView: View
{
    //紀錄登入狀態
    @AppStorage("signIn") var signIn=false
    
    //顯示SideView的狀態
    @State private var showSide: Bool=false
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                VStack(spacing: 0)
                {
                    TopBarView(showSide: $showSide)
                    BottomBarView()
                }
                //避免叫出鍵盤擠壓到畫面
                .ignoresSafeArea(.keyboard)
            }
            //用overlay 而不是將SideView放在ZStack內是因為如此叫出鍵盤時 不會擠壓到其他畫面
            .overlay
            {
                //登入之後才可以顯示SideView
                if(self.signIn)
                {
                    //避免叫出鍵盤擠壓到畫面
                    SideView(showSide: $showSide).ignoresSafeArea(.keyboard)
                }
            }
            //讓其他畫面的NavigationLink能夠順暢動畫切換
            .navigationTitle("")
            .toolbarTitleDisplayMode(.inline)
        }
        //控制APP主要顏色
        .tint(Color(.toolbar))
    }
}
