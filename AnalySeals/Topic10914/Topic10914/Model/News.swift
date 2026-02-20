//
//  News.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/5/2.
//

import Foundation

class News: Codable, Identifiable
{
    var title: String
    var text: String
    var date: String
    
    init(title: String, text: String, date: String)
    {
        self.title=title
        self.text=text
        self.date=date
    }
}
