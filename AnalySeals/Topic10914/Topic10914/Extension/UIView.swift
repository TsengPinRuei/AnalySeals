//
//  UIView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/28.
//

import SwiftUI

extension UIView
{
    func image(_ size: CGSize) -> UIImage
    {
        let render=UIGraphicsImageRenderer(size: size)
        return render.image
        {_ in
            drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
