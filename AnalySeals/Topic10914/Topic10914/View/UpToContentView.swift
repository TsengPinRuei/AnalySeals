//
//  UpToInView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/17.
//

import SwiftUI

struct UpToContentView: View
{
    @AppStorage("signIn") var signIn=true
    
    @State private var showIn: Bool=false
    
    var body: some View
    {
        ZStack
        {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            if(showIn)
            {
                ContentView(signIn: self.signIn).transition(.opacity)
            }
        }
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now()+1)
            {
                withAnimation(.spring())
                {
                    self.showIn=true
                }
            }
        }
    }
}

struct UpToInView_Previews: PreviewProvider
{
    static var previews: some View
    {
        UpToContentView()
    }
}
