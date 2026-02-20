//
//  ClearTextEditor.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/1.
//

import SwiftUI

struct ClearTextEditor: UIViewRepresentable
{
    @Binding var text: String
    
    let textColor: UIColor
    let textSize: UIFont.TextStyle
    
    //字數限制
    var max: Int
    
    func makeCoordinator() -> Coordinator
    {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> UITextView
    {
        let textUI = UITextView()
        
        //設定透明背景
        textUI.backgroundColor = .clear
        //設定字體顏色
        textUI.textColor = self.textColor
        //設定字體
        textUI.font=UIFont.preferredFont(forTextStyle: self.textSize)
        textUI.isEditable=true
        textUI.isUserInteractionEnabled=true
        textUI.delegate=context.coordinator
        
        return textUI
    }
    func updateUIView(_ uiView: UITextView, context: Context)
    {
        uiView.text=text
        checkCharacterCount(uiView)
    }
    
    class Coordinator: NSObject, UITextViewDelegate
    {
        var parent: ClearTextEditor
        
        init(_ parent: ClearTextEditor)
        {
            self.parent=parent
        }
        
        func textViewDidChange(_ textView: UITextView)
        {
            parent.text=textView.text
            parent.checkCharacterCount(textView)
        }
    }
    
    func checkCharacterCount(_ textView: UITextView)
    {
        let currentCount=textView.text.count
        
        if(currentCount>max)
        {
            textView.deleteBackward()
        }
    }
}
