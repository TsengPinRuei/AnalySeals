//
//  BackgroundCapsule.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/8.
//

import SwiftUI

struct BackgroundCapsule: View
{
    var x: CGFloat = UIScreen.main.bounds.width*0.1
    //負數會讓膠囊在螢幕上側
    var y: CGFloat = -UIScreen.main.bounds.height/2.5
    
    var body: some View
    {
        Color(.background)
            .overlay(
                Capsule()
                    .fill(Color(.capsule))
                    .frame(width: 600, height: 800)
                    .offset(x: self.x, y: self.y)
            )
            .ignoresSafeArea(.all)
    }
}
