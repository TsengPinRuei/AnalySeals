//
//  UIImage.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/15.
//

import Foundation
import SwiftUI

//擴充UIImage方法
extension UIImage
{
    //設定UIImage大小
    func setSize(_ size: CGSize) -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer
        {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(renderingMode)
    }
}
