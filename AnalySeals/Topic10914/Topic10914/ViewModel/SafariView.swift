//
//  SafariView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/9.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable
{
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController
    {
        return SFSafariViewController(url: self.url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context)
    {
    }
}
