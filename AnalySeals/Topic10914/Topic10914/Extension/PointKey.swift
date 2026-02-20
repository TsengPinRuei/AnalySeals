//
//  PointKey.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/28.
//

import SwiftUI

struct PointKey: PreferenceKey
{
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
    {
        value=nextValue()
    }
}
