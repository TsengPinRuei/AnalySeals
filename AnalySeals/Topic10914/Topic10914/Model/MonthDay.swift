//
//  MonthDay.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/19.
//

import SwiftUI

struct MonthDay: Identifiable
{
    var id: UUID=UUID()
    var symbol: String
    var date: Date
    var ignore: Bool=false
}
