//
//  User.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/23.
//

import Foundation
import SwiftUI

//ObservableObject讓User能夠在 屬性發生變化時通知其他View
class User: ObservableObject
{
    @Published var account: String
    @Published var password: String
    @Published var name: String
    @Published var gender: String
    @Published var region: String
    @Published var city: String
    @Published var degree: String
    @Published var school: String
    //使用者可以不寫個性簽名 所以用可選型別
    @Published var bio: String?
    @Published var note: Int
    @Published var track: Bool
    @Published var meTag: String?
    
    init()
    {
        self.account=""
        self.password=""
        self.name=""
        self.gender=""
        self.region=""
        self.city=""
        self.degree=""
        self.school=""
        self.bio=nil
        self.note=0
        self.track=true
        self.meTag=nil
    }
    
    func clearAll()
    {
        self.account=""
        self.password=""
        self.name=""
        self.gender=""
        self.region=""
        self.city=""
        self.degree=""
        self.school=""
        self.bio=nil
        self.note=0
        self.track=true
        self.meTag=nil
    }
}
