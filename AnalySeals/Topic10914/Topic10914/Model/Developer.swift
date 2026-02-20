//
//  Developer.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/8/8.
//

import SwiftUI

struct Developer: Identifiable
{
    let id: String
    let name: String
    let job: [String]
    let image: ImageResource
}

//開發者列表
let developer: [Developer] =
[
    Developer(
        id: "10914102",
        name: "組長\n蕭能陽",
        job:
            [
                "資料蒐集",
                "軟體設計說明書",
                "軟體使用手冊",
                "軟體需求說明"
            ].sorted(),
        image: .xiao
    ),
    Developer(
        id: "10914054",
        name: "副組長\n曾品瑞",
        job:
            [
                "資料蒐集",
                "資訊整合",
                "版面設計",
                "系統開發",
                "資料庫設計",
                "資料庫開發",
                "網路爬蟲",
                "軟體設計說明書",
                "軟體使用手冊",
                "軟體需求說明"
            ].sorted(),
        image: .tseng
    ),
    Developer(
        id: "10914150",
        name: "毛淑娟",
        job:
            [
                "資料蒐集",
                "資訊整合",
                "資料庫設計",
                "網路爬蟲"
            ].sorted(),
        image: .mao
    ),
    Developer(
        id: "10914009",
        name: "黃彥廷",
        job:
            [
                "資料蒐集",
                "軟體設計說明書",
                "軟體使用手冊",
                "軟體需求說明"
            ].sorted(),
        image: .huang
    ),
    Developer(
        id: "10914003",
        name: "許云瀞",
        job:
            [
                "美術",
                "版面設計",
                "海報設計",
                "Line官方帳號"
            ].sorted(),
        image: .hsu
    ),
    Developer(
        id: "10914036",
        name: "朱芩穎",
        job:
            [
                "美術",
                "小編",
                "Line官方帳號"
            ].sorted(),
        image: .zhu
    )
]
