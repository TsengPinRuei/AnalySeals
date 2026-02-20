//
//  MonthTaskItemView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/19.
//

import SwiftUI

struct MonthTaskItemView: View
{
    @Bindable var task: MonthTask
    
    var indicatorColor: Color
    {
        if(self.task.complete)
        {
            return .green
        }
        else if(self.task.date.isSameHour)
        {
            return .blue
        }
        else if(self.task.date.isPast)
        {
            return .red
        }
        else
        {
            return Color(.backBar)
        }
    }
    
    var body: some View
    {
        HStack(alignment: .center, spacing: 10)
        {
            Circle()
                .fill(self.indicatorColor)
                .frame(width: 15, height: 15)
                .onTapGesture
                {
                    withAnimation(.smooth)
                    {
                        self.task.complete.toggle()
                    }
                }
            
            VStack(alignment: .leading, spacing: 10)
            {
                HStack
                {
                    Text(self.task.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Label("\(self.task.date.format("hh:mm a"))", systemImage: "clock").font(.callout)
                }
                .horizontalSpacing(.leading)
                
                Text(self.task.type).font(.callout)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(self.task.setColor().opacity(0.5))
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal)
    }
}
