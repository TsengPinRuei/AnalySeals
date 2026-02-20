//
//  CalendarScroll.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/19.
//

import SwiftUI

struct CalendarScroll: ScrollTargetBehavior
{
    var height: CGFloat
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext)
    {
        if(target.rect.minY<self.height)
        {
            target.rect = .zero
        }
    }
}
