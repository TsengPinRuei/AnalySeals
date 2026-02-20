//
//  UIApplication.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/27.
//

import SwiftUI

//擴充UIApplication方法
extension UIApplication
{
    //收回鍵盤
    func dismissKeyboard()
    {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
