//
//  NoteToImageView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/4/25.
//

import SwiftUI

struct NoteToImageView: View
{
    let note: Note
    let text: String
    let textSize: CGFloat
    let page: String
    
    var body: some View
    {
        ZStack
        {
            Image(.notePaper)
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 30)
            {
                Text(self.note.title)
                    .bold()
                    //標題太長會導致圖片無法輸出 所以降低字型
                    .font(.system(size: self.note.title.count<10 ? 100:75))
                
                Capsule(style: .continuous)
                    .fill(.black)
                    .frame(height: 10)
                
                Text(self.text.isEmpty ? self.note.text:self.text)
                    .font(.system(size: self.textSize))
                    //寬度太長會導致圖片無法輸出 所以限制寬度
                    .frame(maxWidth: 1500)
                    //因為maxWidth是獨立出來的 所以設定對齊
                    .multilineTextAlignment(.leading)
                    .lineLimit(25)
                
                Spacer()
                
                Capsule(style: .continuous)
                    .fill(.black)
                    .frame(height: 10)
                
                HStack
                {
                    Text("# \(self.note.tag)")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(.fieldText))
                        .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    
                    Text(self.page).fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(self.note.date)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(.fieldText))
                        .clipShape(.rect(cornerRadius: 20))
                }
                .font(.system(size: 75))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(50)
        }
        .foregroundStyle(Color(.fieldText))
    }
}
