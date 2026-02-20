//
//  Alerter.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/24.
//

import Foundation

struct Alerter
{
    var title: String?
    var message: String
    var show: Bool
    
    //表示該function是可以修改結構的function
    mutating func showAlert(title: String? = nil, message: String)
    {
        self.title=title
        self.message=message
        self.show.toggle()
    }
    //表示該function是可以修改結構的function
    mutating func showAlert(message: String)
    {
        self.message=message
        self.show.toggle()
    }
}
