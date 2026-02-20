//
//  RoundedCorner.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/8.
//

import SwiftUI

struct RoundedCorner: Shape
{
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path
    {
        let path=UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: self.corners,
            cornerRadii: CGSize(width: self.radius, height: self.radius)
        )
        
        return Path(path.cgPath)
    }
}
