//
//  ToDoAreaView.swift
//  Topic10914
//
//  Created by 口口口瑞 on 2023/7/18.
//

import SwiftUI

struct ToDoAreaView: View
{
    //已經完成的事項表
    @AppStorage("completedTask") private var completed: [DragTask]=[]
    //尚未完成的事項表
    @AppStorage("toDoTask") private var toDo: [DragTask]=[]
    //正在進行的事項表
    @AppStorage("workingTask") private var working: [DragTask]=[]
    
    //返回ToDoCalendarView的狀態
    @Environment(\.dismiss) private var dismiss
    
    //新增事項畫面的狀態
    @State private var showAppend: Bool=false
    //顯示事項內容的狀態
    @State private var showText: Bool=false
    //新增的事項
    @State private var text: String=""
    //當前點選或拖曳的事項
    @State private var current: DragTask?
    
    //MARK: 已經完成的事項畫面
    @ViewBuilder
    private func DragCompletedView() -> some View
    {
        NavigationStack
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                DragTaskView(self.completed)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .contentShape(.rect(cornerRadius: 10))
            .dropDestination(for: String.self)
            {(item, location) in
                withAnimation(.snappy)
                {
                    self.appendDragTask(.completed)
                }
                return true
            }
            isTargeted:
            {_ in
            }
        }
    }
    //MARK: 事項畫面
    @ViewBuilder
    private func DragTaskRow(_ task: DragTask, _ size: CGSize) -> some View
    {
        Text(task.title)
            .font(.body)
            .foregroundStyle(.black)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: size.height)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            //拖曳時也是RoundedRectangle
            .contentShape(.dragPreview, .rect(cornerRadius: 10))
            .onTapGesture
            {
                //當前點選的事項
                self.current=task
                //當前事項的內容
                self.text=task.title
                //顯示完整內容
                self.showText.toggle()
            }
            //該事項為可拖曳狀態
            .draggable(task.id.uuidString)
            {
                Text(task.title)
                    .font(.body)
                    .foregroundStyle(.black)
                    .padding(10)
                    .frame(width: size.width, height: size.height, alignment: .leading)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    //拖曳時也是RoundedRectangle
                    .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    .onAppear
                    {
                        //當前拖曳的事項
                        self.current=task
                    }
            }
            //拖曳目標位置
            .dropDestination(for: String.self)
            {(item, location) in
                //拖曳完畢 當前事項設為空值
                self.current=nil
                return false
            }
            isTargeted:
            {status in
                if let current, status, current.id != task.id
                {
                    withAnimation(.snappy)
                    {
                        self.appendDragTask(task.status)
                        switch(task.status)
                        {
                            case .toDo:
                                self.replaceDragTask(task: &toDo, drop: task, status: .toDo)
                            case .working:
                                self.replaceDragTask(task: &working, drop: task, status: .working)
                            case .completed:
                                self.replaceDragTask(task: &completed, drop: task, status: .completed)
                        }
                    }
                }
            }
    }
    //MARK: 存放事項的畫面
    @ViewBuilder
    private func DragTaskView(_ task: [DragTask]) -> some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            ForEach(task)
            {index in
                GeometryReader
                {
                    DragTaskRow(index, $0.size)
                }
                .frame(height: 40)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    //MARK: 尚未完成的事項畫面
    @ViewBuilder
    private func DragToDoView() -> some View
    {
        NavigationStack
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                DragTaskView(self.toDo)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .contentShape(.rect(cornerRadius: 10))
            .dropDestination(for: String.self)
            {(item, location) in
                withAnimation(.snappy)
                {
                    self.appendDragTask(.toDo)
                }
                return true
            }
            isTargeted:
            {_ in
            }
        }
    }
    //MARK: 正在進行的事項畫面
    @ViewBuilder
    private func DragWorkingView() -> some View
    {
        NavigationStack
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                DragTaskView(self.working)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .contentShape(.rect(cornerRadius: 10))
            .dropDestination(for: String.self)
            {(item, location) in
                withAnimation(.snappy)
                {
                    self.appendDragTask(.working)
                }
                return true
            }
            isTargeted:
            {_ in
            }
        }
    }
    
    //MARK: 新增事項
    private func appendDragTask(_ status: Status)
    {
        if let current=self.current
        {
            switch(status)
            {
                case .toDo:
                    if(!self.toDo.contains(where: { $0.id==current.id }))
                    {
                        var update=current
                        update.status = .toDo
                        self.toDo.append(update)
                        self.working.removeAll(where: { $0.id==current.id })
                        self.completed.removeAll(where: { $0.id==current.id })
                    }
                case .working:
                    if(!self.working.contains(where: { $0.id==current.id }))
                    {
                        var update=current
                        update.status = .working
                        self.working.append(update)
                        self.toDo.removeAll(where: { $0.id==current.id })
                        self.completed.removeAll(where: { $0.id==current.id })
                    }
                case .completed:
                    if(!self.completed.contains(where: { $0.id==current.id }))
                    {
                        var update=current
                        update.status = .completed
                        self.completed.append(update)
                        self.toDo.removeAll(where: { $0.id==current.id })
                        self.working.removeAll(where: { $0.id==current.id })
                    }
            }
        }
    }
    //MARK: 移除事項
    private func removeDragTask(task: inout [DragTask])
    {
        if let current=self.current
        {
            if let index=task.firstIndex(where: { $0.id==current.id })
            {
                task.remove(at: index)
            }
        }
    }
    //MARK: 移動事項
    private func replaceDragTask(task: inout [DragTask], drop: DragTask, status: Status)
    {
        if let current=self.current
        {
            if let start=task.firstIndex(where: { $0.id==current.id }),
               let end=task.firstIndex(where: { $0.id==drop.id })
            {
                var item=task.remove(at: start)
                item.status=status
                task.insert(item, at: end)
            }
        }
    }
    
    var body: some View
    {
        ZStack
        {
            HStack(spacing: 5)
            {
                //MARK: 尚未完成
                VStack(spacing: 0)
                {
                    Text("尚未完成")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                    
                    DragToDoView().background(.red.gradient)
                }
                .background(.white)
                
                //MARK: 正在進行
                VStack(spacing: 0)
                {
                    Text("正在進行")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                        //讓黑線可以連接起來
                        .padding(.horizontal, -5)
                    
                    DragWorkingView().background(.blue.gradient)
                }
                .background(.white)
                
                //MARK: 已經完成
                VStack(spacing: 0)
                {
                    Text("已經完成")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                    
                    DragCompletedView().background(.green.gradient)
                }
                .background(.white)
            }
            
            //MARK: 事項完整內容
            if(self.showText)
            {
                ZStack
                {
                    Color.black.opacity(0.5)
                    
                    Text(self.text)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                }
                .onTapGesture
                {
                    self.showText.toggle()
                }
                .transition(.opacity.animation(.easeInOut))
                .ignoresSafeArea(.all)
            }
        }
        //MARK: 新增事項Sheet
        .sheet(isPresented: self.$showAppend)
        {
            ZStack
            {
                VStack(alignment: .leading)
                {
                    HStack(alignment: .top)
                    {
                        Text("新增待辦事項")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color(.backBar))
                        
                        Spacer()
                        
                        Button
                        {
                            withAnimation(.easeInOut)
                            {
                                self.toDo.append(DragTask(title: self.text, status: .toDo))
                            }
                            self.text=""
                        }
                        label:
                        {
                            Text("確定")
                                .bold()
                                .font(.body)
                                .foregroundStyle(Color(.backBar))
                        }
                        .disabled(self.text.isEmpty)
                        .opacity(self.text.isEmpty ? 0:1)
                        .animation(.easeInOut, value: self.text)
                    }
                    
                    TextEditor(text: self.$text)
                        .font(.body)
                        .foregroundStyle(Color(.backBar))
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.backBar), lineWidth: 1))
                }
                .padding()
                .background(.ultraThickMaterial)
            }
            .presentationDetents([.fraction(0.3)])
        }
        .navigationTitle("待辦事項")
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemGray6), for: .navigationBar)
        .navigationBarBackButtonHidden()
        .toolbar
        {
            //MARK: ToDoCalendarView
            ToolbarItem(placement: .cancellationAction)
            {
                Button
                {
                    self.dismiss()
                }
                label:
                {
                    HStack(spacing: 3)
                    {
                        Image(systemName: "chevron.left").bold()
                        
                        Text("我的進度表")
                    }
                    .font(.body)
                }
            }
            
            //MARK: 新增或刪除事項
            ToolbarItem(placement: .topBarTrailing)
            {
                Button(self.showText ? "刪除":"新增")
                {
                    //刪除當前事項
                    if(self.showText)
                    {
                        self.removeDragTask(task: &toDo)
                        self.removeDragTask(task: &working)
                        self.removeDragTask(task: &completed)
                        
                        //刪除完畢 當前內容初始化
                        self.text=""
                        //刪除完畢 當前事項設為空值
                        self.current=nil
                        self.showText.toggle()
                    }
                    //新增當前事項
                    else
                    {
                        //新增完畢 當前內容初始化
                        self.text=""
                        self.showAppend.toggle()
                    }
                }
                .font(.body)
                .disabled(self.showAppend)
            }
            
            //MARK: 收回鍵盤
            ToolbarItem(placement: .keyboard)
            {
                Button("確認")
                {
                    UIApplication.shared.dismissKeyboard()
                }
                .font(.body)
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
