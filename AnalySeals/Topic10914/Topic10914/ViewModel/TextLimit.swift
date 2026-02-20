//
//  TextLimit.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/20.
//

import SwiftUI

struct TextLimit: ViewModifier
{
    @Binding var text: String
    
    var max: Int
    
    func body(content: Content) -> some View
    {
        content.onReceive(self.text.publisher.collect())
        {
            self.text=String($0.prefix(self.max))
        }
    }
}
