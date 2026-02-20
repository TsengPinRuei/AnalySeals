//
//  Array.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/13.
//

import Foundation

//擴充Array初始化 才能用在AppStorage
extension Array: RawRepresentable where Element: Codable
{
    public var rawValue: String
    {
        guard let data=try? JSONEncoder().encode(self),
              let result=String(data: data, encoding: .utf8)
        else
        {
            return "[]"
        }
        return result
    }
    
    public init?(rawValue: String)
    {
        guard let data=rawValue.data(using: .utf8),
              let result=try? JSONDecoder().decode([Element].self, from: data)
        else
        {
            return nil
        }
        
        self = result
    }
}
