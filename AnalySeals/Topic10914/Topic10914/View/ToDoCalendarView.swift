//
//  ToDoCalendarView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/9.
//

import SwiftUI

struct ToDoCalendarView: View
{
    //紀錄淺深模式
    @AppStorage("activateDark") private var activateDark: Bool=false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) private var environment
    
    //展開未完成進度的狀態
    @State private var showPending: Bool=true
    //展開完成進度的狀態
    @State private var showComplete: Bool=true
    //預設今天日期
    @State private var filterDate: Date = .init()
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                //MARK: DatePicker
                DatePicker(selection: self.$filterDate, displayedComponents: [.date]) {}
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .tint(Color(.capsule))
                    .background(Color(.rectangle))
                    .overlay
                    {
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10))
                            .stroke(.gray, lineWidth: self.activateDark ? 0:3)
                    }
                    .listRowBackground(Color(.rectangle))
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                //MARK: FilterView
                FilterView(filterDate: self.$filterDate)
                {(pending, complete) in
                    DisclosureGroup(isExpanded: self.$showPending)
                    {
                        //MARK: 無未完成進度
                        if(pending.isEmpty)
                        {
                            Text("假裝自己是一隻海豹慵懶的躺在冰原上")
                                .font(.body)
                                .foregroundStyle(.gray)
                        }
                        //MARK: 顯示未完成進度
                        else
                        {
                            ForEach(pending)
                            {
                                TaskRow(task: $0, isPending: true)
                            }
                        }
                    }
                    label:
                    {
                        Text("還在努力的進度：\(pending.count)")
                            .bold()
                            .font(.callout)
                            .foregroundStyle(Color(.toolbar))
                            .contentTransition(.numericText())
                    }
                    .listRowSeparatorTint(.black)
                    
                    DisclosureGroup(isExpanded: self.$showComplete)
                    {
                        //MARK: 無完成進度
                        if(complete.isEmpty)
                        {
                            Text("一事無成")
                                .font(.body)
                                .foregroundStyle(.gray)
                        }
                        //MARK: 顯示完成進度
                        else
                        {
                            ForEach(complete)
                            {
                                TaskRow(task: $0, isPending: false)
                            }
                        }
                    }
                    label:
                    {
                        Text("完成的進度：\(complete.count)")
                            .bold()
                            .font(.callout)
                            .foregroundStyle(Color(.toolbar))
                            .contentTransition(.numericText())
                    }
                    .listRowSeparatorTint(.black)
                }
                .listRowBackground(Color(.backBar).colorInvert().opacity(0.5))
            }
            //List的主要顏色
            .tint(Color(.toolbar))
            .scrollContentBackground(.hidden)
            .background(Color(.background))
            .navigationTitle("我的進度表")
            .toolbar
            {
                //MARK: X
                ToolbarItem(placement: .cancellationAction)
                {
                    Button
                    {
                        self.dismiss()
                    }
                    label:
                    {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                }
                
                ToolbarItem(placement: .bottomBar)
                {
                    HStack
                    {
                        //MARK: 新增進度按鈕
                        Button
                        {
                            do
                            {
                                let task=Task(context: self.environment.managedObjectContext)
                                
                                //初始化進度
                                task.id = .init()
                                task.date=self.filterDate
                                task.title=""
                                task.isComplete=false
                                
                                //將該進度儲存進CoreData
                                try self.environment.managedObjectContext.save()
                                //調整為未完成
                                self.showPending=true
                            }
                            catch
                            {
                                print("ToDoView Error: \(error.localizedDescription)")
                            }
                        }
                        label:
                        {
                            HStack
                            {
                                Image(systemName: "plus.circle.fill")
                                
                                Text("新增進度")
                            }
                        }
                        
                        Spacer()
                        
                        //MARK: ToDoAreaView
                        NavigationLink(destination: ToDoAreaView())
                        {
                            HStack
                            {
                                Image(systemName: "square.stack.3d.down.forward.fill")
                                
                                Text("待辦事項")
                            }
                        }
                    }
                    .bold()
                    .font(.title3)
                    .foregroundStyle(Color(.toolbar))
                }
            }
        }
    }
}
