//
//  TasksOffsetKey.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/16.
//

import SwiftUI

struct TasksOffsetKey: PreferenceKey
{
    static let defaultValue: CGFloat=0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat)
    {
        value=nextValue()
    }
}
