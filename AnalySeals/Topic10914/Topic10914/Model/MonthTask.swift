//
//  MonthTask.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/19.
//

import SwiftUI
import SwiftData

@Model
class MonthTask: Identifiable
{
    var id: UUID
    var title: String
    var type: String
    var date: Date
    var complete: Bool
    var tint: String
    
    init(id: UUID=UUID(), title: String, type: String, date: Date=Date(), complete: Bool=false, tint: String)
    {
        self.id=id
        self.title=title
        self.type=type
        self.date=date
        self.complete=complete
        self.tint=tint
    }
    
    func setColor() -> Color
    {
        switch(self.tint)
        {
            case "Red":
                return .red
            case "Orange":
                return .orange
            case "Yellow":
                return .yellow
            case "Green":
                return .green
            case "Blue":
                return .blue
            case "Purple":
                return .purple
            default:
                return .black
        }
    }
}
