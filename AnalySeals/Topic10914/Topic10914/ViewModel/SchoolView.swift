//
//  SchoolView.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/5/2.
//

import SwiftUI

struct SchoolView: View
{
    @Binding var showLogo: Bool
    
    let school: SchoolInformation
    
    var body: some View
    {
        ZStack
        {
            if(self.showLogo)
            {
                Image(self.school.logo)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    //放大出現 淡出消失
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            else
            {
                Text(self.school.name)
                    .bold()
                    //放大出現 淡出消失
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        .foregroundStyle(Color(.backBar))
    }
}
