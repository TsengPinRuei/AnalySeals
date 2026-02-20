//
//  LoadingView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/10.
//

import SwiftUI

struct LoadingView: View
{
    @State private var index: Int=0
    
    private let image: [ImageResource]=[._0To25, ._26To50, ._51To75, ._76To100]
    
    let type: String
    
    var body: some View
    {
        switch(self.type)
        {
            default:
                Group
                {
                    Rectangle().fill(.black.opacity(0.5))
                    
                    VStack
                    {
                        Image(self.image[self.index%self.image.count])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                        
                        ProgressView().tint(.white)
                    }
                }
                .onAppear
                {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true)
                    {timer in
                        self.index+=1
                    }
                }
        }
    }
}
