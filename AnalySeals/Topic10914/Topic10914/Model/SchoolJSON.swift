//
//  SchoolJSON.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/10.
//

import Foundation

//網路爬蟲 JSON檔案要轉換的模型
struct SchoolJSON: Codable
{
    var result: [String:String]
    //var levelLow: [String:[[String:String]]]
    var levelDream: [String:[[String:String]]]
    var levelTry: [String:[[String:String]]]
    var levelFit: [String:[[String:String]]]
    var levelCareful: [String:[[String:String]]]
    var levelSafe: [String:[[String:String]]]
    var levelHigh: [String:[[String:String]]]
    var levelOther: [String:[[String:String]]]
}
