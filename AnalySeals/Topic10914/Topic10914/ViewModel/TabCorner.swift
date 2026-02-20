//
//  Corner.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/19.
//

import SwiftUI
import Foundation

struct TabCorner: Shape
{
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path
    {
        let path=UIBezierPath(roundedRect: rect, byRoundingCorners: self.corner, cornerRadii: CGSize(width: self.radius, height: self.radius))
        return Path(path.cgPath)
    }
}
