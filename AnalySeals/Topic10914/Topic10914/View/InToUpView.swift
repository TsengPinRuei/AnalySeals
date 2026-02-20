//
//  InToUpView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/14.
//

import SwiftUI

struct InToUpView: View
{
    @State private var showUp: Bool=false
    
    var body: some View
    {
        ZStack
        {
            Color(.background).ignoresSafeArea(.all)
            
            if(self.showUp)
            {
                //透明式切換
                UpView().transition(.opacity)
            }
        }
        .onAppear
        {
            //延遲一秒之後執行
            DispatchQueue.main.asyncAfter(deadline: .now()+1)
            {
                withAnimation(.easeInOut)
                {
                    self.showUp.toggle()
                }
            }
        }
    }
}
