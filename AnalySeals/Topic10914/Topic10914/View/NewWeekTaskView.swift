//
//  NewWeekTaskView.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/11/16.
//

import SwiftUI
import SwiftData

struct NewWeekTaskView: View
{
    @Environment(\.modelContext) private var modelContext
    
    @FocusState private var focusTitle: Bool
    @FocusState private var focusType: Bool
    
    @State private var tint: String="Black"
    @State private var title: String=""
    @State private var type: String=""
    @State private var date: Date=Date()
    @State private var result: (Bool, String)=(false, "")
    
    private let color: [String]=["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading)
            {
                Text("新增進度")
                    .bold()
                    .font(.largeTitle)
                
                VStack(spacing: 5)
                {
                    TextField("標題", text: self.$title)
                        .focused(self.$focusTitle)
                        .font(.title3)
                        .submitLabel(.done)
                    
                    Capsule().frame(height: 1)
                }
                .padding(.top)
            }
            .horizontalSpacing(.leading)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background
            {
                Rectangle()
                    .fill(Color(.systemGray3))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea(.all)
            }
            
            VStack(alignment: .leading, spacing: 30)
            {
                VStack(spacing: 5)
                {
                    TextField("類型", text: self.$type)
                        .focused(self.$focusType)
                        .font(.title3)
                        .submitLabel(.done)
                    
                    Capsule().frame(height: 1)
                }
                
                HStack
                {
                    Text("時間").font(.title2)
                    
                    Spacer()
                    
                    DatePicker("", selection: self.$date).datePickerStyle(.compact)
                }
                
                VStack(alignment: .leading, spacing: 20)
                {
                    Text("顏色").font(.title2)
                    
                    HStack(spacing: 10)
                    {
                        ForEach(self.color, id: \.self)
                        {color in
                            Circle()
                                .fill(WeekTask(title: "", type: "", tint: color).setColor())
                                .background
                                {
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .opacity(self.tint==color ? 1:0)
                                }
                                .horizontalSpacing(.center)
                                .onTapGesture
                                {
                                    withAnimation(.easeInOut.speed(2))
                                    {
                                        self.tint=color
                                    }
                                }
                        }
                    }
                }
            }
            .padding(30)
            .verticalSpacing(.top)
            
            Button
            {
                let task: WeekTask=WeekTask(title: self.title, type: self.type, date: self.date, tint: self.tint)
                
                do
                {
                    self.modelContext.insert(task)
                    try self.modelContext.save()
                    self.result.1=""
                }
                catch
                {
                    self.result.1=error.localizedDescription
                }
                self.result.0.toggle()
            }
            label:
            {
                Text("新增進度")
                    .font(.title3)
                    .foregroundStyle(Color(.backBar))
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(.systemGray3))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal, 30)
                    .opacity(self.title.isEmpty || self.type.isEmpty || self.focusTitle || self.focusType ? 0.5:1)
                    .animation(.smooth, value: self.title.isEmpty || self.type.isEmpty || self.focusTitle || self.focusType)
            }
            .disabled(self.title.isEmpty || self.type.isEmpty || self.focusTitle || self.focusType)
        }
        .verticalSpacing(.top)
        .alert(self.result.1.isEmpty ? "「\(self.title)」已新增到進度表":"發生錯誤\n請稍後再試一次", isPresented: self.$result.0)
        {
            Button("確認", role: .cancel)
            {
                if(self.result.1.isEmpty)
                {
                    withAnimation(.smooth)
                    {
                        self.title=""
                        self.type=""
                        self.tint="Black"
                        self.date=Date()
                        self.result.1=""
                    }
                }
            }
        }
        message:
        {
            Text(self.result.1)
        }
    }
}
