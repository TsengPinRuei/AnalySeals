//
//  PhotoSource.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/10.
//

import Foundation

//NotePostImageView圖片來源
enum PhotoSource: Identifiable
{
    case camera
    //一定要用photoLibrary 因為跟UIKit有相關
    case photoLibrary
    
    var id: Int
    {
        hashValue
    }
}
