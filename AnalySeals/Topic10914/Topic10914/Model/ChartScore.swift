//
//  ChartScore.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/7/4.
//

import Foundation

struct ChartScore: Hashable, Identifiable
{
    var id: UUID=UUID()
    var title: String="總級分"
    let score: Double
    let year: Int
}
