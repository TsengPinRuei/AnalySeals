//
//  RegionData.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/22.
//

import Foundation

class City: ObservableObject
{
    @Published var region: String
    
    init(region: String)
    {
        self.region=region
    }
    
    func setCity() -> [String]
    {
        switch(self.region)
        {
            case "北":
                return ["縣市", "臺北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣"]
            case "中":
                return ["縣市", "苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣"]
            case "南":
                return ["縣市", "嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣"]
            case "東":
                return ["縣市", "宜蘭縣", "花蓮縣", "臺東縣"]
            case "外島":
                return ["縣市", "金門縣", "連江縣", "澎湖縣"]
            default:
                return ["縣市"]
        }
    }
}
