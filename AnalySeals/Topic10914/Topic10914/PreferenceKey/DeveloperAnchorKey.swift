//
//  DeveloperAnchorKey.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/8.
//

import SwiftUI

struct DeveloperAnchorKey: PreferenceKey
{
    static var defaultValue: [String:Anchor<CGRect>]=[:]
    
    static func reduce(value: inout [String:Anchor<CGRect>], nextValue: () -> [String:Anchor<CGRect>])
    {
        value.merge(nextValue()) { $1 }
    }
}
