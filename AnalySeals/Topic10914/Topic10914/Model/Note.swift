//
//  Note.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/26.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable, Hashable
{
    @DocumentID var id: String?
    
    //DocumentID沒辦法做比對 NoteView要透過比對ID找出作者性別 所以額外複製出一個ID -> "user.id"+" "+"user.note"
    var userId: String
    var user: String
    var title: String
    var text: String
    var tag: String
    var collect: [String]
    var collectCount: Int
    var like: [String]
    var likeCount: Int
    var dislike: [String]
    var dislikeCount: Int
    var date: String
    
    enum NoteKeys: CodingKey
    {
        case id
        case userId
        case user
        case title
        case text
        case tag
        case collect
        case collectCount
        case like
        case likeCount
        case dislike
        case dislikeCount
        case date
    }
}
