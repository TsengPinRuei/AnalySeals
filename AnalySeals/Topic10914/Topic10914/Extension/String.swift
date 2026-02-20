//
//  String.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/26.
//

import Foundation

//擴充String方法
extension String
{
    func index(from: Int) -> Index
    {
        return self.index(startIndex, offsetBy: from)
    }
    //MARK: character在string中index的下一個索引值
    func nextIndex(of character: Character, in string: String, after index: String.Index) -> String.Index?
    {
        guard let range=string.range(of: String(character), options: .literal, range: index..<string.endIndex)
        else
        {
            return nil
        }
        
        return string.index(after: range.lowerBound)
    }
    //MARK: 從from索引值開始 -> from...最後索引值
    func substringFrom(from: Int) -> String
    {
        return String(self[index(from: from)...])
    }
    //MARK: 到to結束 -> 起始索引值..<to
    func substringTo(to: Int) -> String
    {
        return String(self[..<index(from: to)])
    }
    //MARK: 區間內的子字串 EX: 0...10 0..<11
    func substringWith(with r: Range<Int>) -> String
    {
        return String(self[index(from: r.lowerBound)..<index(from: r.upperBound)])
    }
    
    subscript(_ i: Int) -> String
    {
        let idx1=index(startIndex, offsetBy: i)
        let idx2=index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    subscript (r: CountableClosedRange<Int>) -> String
    {
        let startIndex=self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex=self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
    subscript (r: Range<Int>) -> String
    {
        let start=index(startIndex, offsetBy: r.lowerBound)
        let end=index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
}
