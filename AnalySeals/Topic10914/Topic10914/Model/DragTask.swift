//
//  DragTask.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/7/18.
//

import Foundation

enum Status: Codable
{
    case toDo
    case working
    case completed
}

struct DragTask: Codable, Hashable, Identifiable
{
    var id: UUID=UUID()
    var title: String
    var status: Status
}
