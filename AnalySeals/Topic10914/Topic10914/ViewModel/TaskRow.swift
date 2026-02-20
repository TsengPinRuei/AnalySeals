//
//  TaskRow.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/6/9.
//

import SwiftUI

struct TaskRow: View
{
    @Environment(\.self) private var environment
    
    //注意輸入狀態
    @FocusState private var showKeyboard: Bool
    
    @ObservedObject var task: Task
    
    var isPending: Bool
    
    //MARK: 移除空的進度
    func removeEmpty()
    {
        if((self.task.title ?? "").isEmpty)
        {
            self.environment.managedObjectContext.delete(self.task)
        }
    }
    //MARK: 儲存進度
    func save()
    {
        do
        {
            try self.environment.managedObjectContext.save()
        }
        catch
        {
            print("TaskRow Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View
    {
        HStack(spacing: 12)
        {
            //MARK: 進度事項
            Button
            {
                self.task.isComplete.toggle()
                self.save()
            }
            label:
            {
                Image(systemName: self.task.isComplete ? "checkmark.circle.fill":"circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(self.isPending ? .indigo:.gray)
                    .frame(height: 25)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4)
            {
                //MARK: 輸入進度
                TextField("", text: .init(get: { return self.task.title ?? "" }, set:
                {value in
                    self.task.title=value
                }))
                //鍵盤狀態
                .focused(self.$showKeyboard)
                .submitLabel(.done)
                .onSubmit
                {
                    //如果是空的進度則直接刪除
                    self.removeEmpty()
                    //儲存進度進CoreData
                    self.save()
                }
                //已經完成的進度之灰色字體
                .foregroundColor(self.isPending ? .primary:.gray)
                //已經完成的進度之字劃線
                .strikethrough(!self.isPending, pattern: .solid, color: .primary)
                
                //使用者可以調整日期及時間
                Text((self.task.date ?? .init()).formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .foregroundStyle(.gray)
                    //MARK: 日期選擇
                    .overlay
                    {
                        DatePicker(selection: .init(get: { return self.task.date ?? .init() }, set:
                        {value in
                            //設定進度日期
                            self.task.date=value
                            //儲存進度日期進CoreData
                            self.save()
                        }), displayedComponents: [.hourAndMinute])
                        {
                            
                        }
                        .labelsHidden()
                        .blendMode(.destinationOver)
                    }
            }
            //已經完成的進度之字體斜體
            .italic(!self.isPending)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.body)
        //完成的進度不可以再操作
        .disabled(!self.isPending)
        .onAppear
        {
            if((self.task.title ?? "").isEmpty)
            {
                self.showKeyboard=true
            }
        }
        .onDisappear
        {
            self.removeEmpty()
            self.save()
        }
        .onChange(of: self.environment.scenePhase)
        {(_, new) in
            if(new != .active)
            {
                self.showKeyboard=false
                DispatchQueue.main.async
                {
                    self.removeEmpty()
                    self.save()
                }
            }
        }
        //MARK: 刪除進度
        .swipeActions(edge: .trailing, allowsFullSwipe: true)
        {
            Button
            {
                self.environment.managedObjectContext.delete(self.task)
                self.save()
            }
            label:
            {
                Image(systemName: "trash.fill")
            }
            .tint(.red)
        }
    }
}
