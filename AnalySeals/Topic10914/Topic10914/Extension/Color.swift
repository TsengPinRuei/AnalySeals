//
//  Color.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/9.
//

import SwiftUI

//擴充Color方法 使其可以以十六進制方式顯示顏色
extension Color
{
    init(hexa: String)
    {
        let hexa=hexa.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64=0
        
        Scanner(string: hexa).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch(hexa.count)
        {
            //RGB (12-bit)
            case 3:
                (a, r, g, b)=(255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            //RGB (24-bit)
            case 6:
                (a, r, g, b)=(255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            //ARGB (32-bit)
            case 8:
                (a, r, g, b)=(int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b)=(1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
