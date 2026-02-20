//
//  Firestorer.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/26.
//

import SwiftUI
import FirebaseDatabase
import FirebaseFirestore

struct Firestorer
{
    @State private var realtime: Realtimer
    
    private let firestore: Firestore
    
    init()
    {
        self.realtime=Realtimer()
        self.firestore=Firestore.firestore()
    }
    
    //MARK: 將最新消息存進Firestore
    func addNews(news: News, number: String)
    {
        do
        {
            try self.firestore
                //News集合中的文件
                .collection("News")
                //相同的document ID會覆蓋住 所以要分開
                .document(number)
                .setData(from: news)
                {error in
                    //發生錯誤
                    if let error=error
                    {
                        print("Firestore Databaser addNews() Error: \(error.localizedDescription)")
                    }
                }
        }
        catch
        {
            print("Firestorer addNews() Error")
        }
    }
    //MARK: 從Firestore刪除筆記
    func deleteNote(id: String)
    {
        self.firestore
            //Note集合中的文件
            .collection("Note")
            //文件中的id欄位資料
            .document(id)
            .delete()
            {error in
                //發生錯誤
                if let error=error
                {
                    print("Firestorer deleteNote() Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 從Firestore刪除指定使用者的所有筆記
    func deleteUserNote(user: String, completion: @escaping () -> Void)
    {
        self.firestore
            .collection("Note")
            //比對指定使用者
            .whereField("user", isEqualTo: user)
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer deleteUserNote(\(user)) Error: \(error.localizedDescription)")
                    completion()
                }
                else if let result=result
                {
                    for i in result.documents
                    {
                        self.deleteNote(id: i.documentID)
                    }
                    
                    completion()
                }
            }
    }
    //MARK: 從Firestore刪除筆記指定欄位的值
    func deleteNoteColumn(note: String, column: String, user: String)
    {
        self.firestore
            //Note集合中的文件
            .collection("Note")
            .document(note)
            //移除陣列中的指定資料
            .updateData([column: FieldValue.arrayRemove([user])])
            {error in
                //發生錯誤
                if let error=error
                {
                    print("Firestorer deleteNoteColumn(\(column)) Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 從Firestore過濾標籤
    func filterNote(tag: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            //Note集合中的文件
            .collection("Note")
            //比對指定標籤
            .whereField("tag", isEqualTo: tag)
            //取得指定標籤文件中的所有資料
            .getDocuments()
            {(result, error) in
                //發生錯誤
                if let error=error
                {
                    print("Firestorer filterNote(\(tag)) Error: \(error.localizedDescription)")
                    //存取空陣列
                    completion([])
                }
                //取得資料
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    //遍歷資料
                    for i in result.documents
                    {
                        //將資料轉成檔案
                        let data=i.data()
                        
                        //將檔案轉成Note格式
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        //存進陣列
                        noteResult.append(note)
                    }
                    
                    //存取陣列結果
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore搜尋收藏的筆記
    func filterCollectionNote(user: String, tag: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            //比對指定使用者
            .whereField("collect", arrayContains: user)
            //比對指定標籤
            .whereField("tag", isEqualTo: tag)
            //取得指定標籤文件中的所有資料
            .getDocuments()
            {(result, error) in
                //發生錯誤
                if let error=error
                {
                    print("Firestorer filterCollectionNote(\(user), \(tag)) Error: \(error.localizedDescription)")
                    //存取空陣列
                    completion([])
                }
                //取得資料
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    //遍歷資料
                    for i in result.documents
                    {
                        //將資料轉成檔案
                        let data=i.data()
                        
                        //將檔案轉成Note格式
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        //存進陣列
                        noteResult.append(note)
                    }
                    
                    //存取陣列結果
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore搜尋指定使用者的筆記
    func filterUserNote(user: String, tag: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            //比對指定使用者
            .whereField("user", isEqualTo: user)
            //比對指定標籤
            .whereField("tag", isEqualTo: tag)
            //取得指定標籤文件中的所有資料
            .getDocuments()
            {(result, error) in
                //發生錯誤
                if let error=error
                {
                    print("Firestorer filterUserNote(\(user), \(tag)) Error: \(error.localizedDescription)")
                    completion([])
                }
                //取得資料
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    //遍歷資料
                    for i in result.documents
                    {
                        //將資料轉成檔案
                        let data=i.data()
                        
                        //將檔案轉成Note格式
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        //存進陣列
                        noteResult.append(note)
                    }
                    
                    //存取陣列結果
                    completion(noteResult)
                }
            }
    }
    //MARK: 抓取收藏的筆記
    func getCollectionNote(user: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            //比對指定使用者
            .whereField("collect", arrayContains: user)
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer getCollectionNote(\(user)) Error: \(error.localizedDescription)")
                    completion([])
                }
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    for i in result.documents
                    {
                        let data=i.data()
                        
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        noteResult.append(note)
                    }
                    
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore抓取最新消息
    func getNews(completion: @escaping ([News]) -> Void)
    {
        self.firestore
            .collection("News")
            //取得所有的筆記 並依照標題排序
            .order(by: "title", descending: true)
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer getNews() Error: \(error.localizedDescription)")
                    completion([])
                }
                else if let result=result
                {
                    var newsResult: [News]=[]
                    
                    for i in result.documents
                    {
                        let data=i.data()
                        let news=News(title: data["title"] as! String, text: data["text"] as! String, date: data["date"] as! String)
                        
                        newsResult.append(news)
                    }
                    
                    completion(newsResult)
                }
            }
    }
    //MARK: 從Firestore抓取筆記
    func getNote(order: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            //取得所有的筆記 並依照order排序
            .order(by: order, descending: true)
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer getNote() Error: \(error.localizedDescription)")
                    completion([])
                }
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    for i in result.documents
                    {
                        let data=i.data()
                        
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        noteResult.append(note)
                    }
                    
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore取得Realtime指定欄位
    func getNoteUserColumn(noteID: String, column: String, completion: @escaping (String?) -> Void)
    {
        self.firestore
            //筆記集合
            .collection("Note")
            //取得筆記集合中的所有筆記
            .getDocuments
            {(result, error) in
                //取得失敗
                if let error=error
                {
                    print("Firestore Get Column \(column) Error: \(error.localizedDescription)")
                    completion(nil)
                }
                else if let result=result
                {
                    //遍歷所有筆記
                    for document in result.documents
                    {
                        var id=document.documentID
                        id=String(id[id.startIndex..<id.firstIndex(of: " ")!])
                        //將所有筆記ID跟Realtime Database中的User ID做比對
                        let reference=Database.database().reference().child("User").child(id).child(column)
                        
                        reference.observeSingleEvent(of: .value)
                        {result in
                            if let data=result.value as? String
                            {
                                //利用作者ID尋找作者本人
                                if(id==String(noteID[noteID.startIndex..<noteID.firstIndex(of: " ")!]))
                                {
                                    //找到資料 存起來
                                    completion(data)
                                }
                            }
                        }
                    }
                }
            }
    }
    //MARK: 抓取指定使用者的筆記
    func getUserNote(user: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            //比對指定使用者
            .whereField("user", isEqualTo: user)
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer getUserNote(\(user)) Error: \(error.localizedDescription)")
                    completion([])
                }
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    for i in result.documents
                    {
                        let data=i.data()
                        
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        noteResult.append(note)
                    }
                    
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore搜尋筆記
    func searchNote(column: String, text: String, completion: @escaping ([Note]) -> Void)
    {
        self.firestore
            .collection("Note")
            .whereField(column, isGreaterThanOrEqualTo: text)
            .whereField(column, isLessThanOrEqualTo: text+"\u{f8ff}")
            .getDocuments()
            {(result, error) in
                if let error=error
                {
                    print("Firestorer searchNote() Error: \(error.localizedDescription)")
                    completion([])
                }
                else if let result=result
                {
                    var noteResult: [Note]=[]
                    
                    for i in result.documents
                    {
                        let data=i.data()
                        
                        let note=Note(
                            userId: data["userId"] as? String ?? "NULL",
                            user: data["user"] as? String ?? "NULL",
                            title: data["title"] as? String ?? "NULL",
                            text: data["text"] as? String ?? "NULL",
                            tag: data["tag"] as? String ?? "NULL",
                            collect: data["collect"] as? [String] ?? [],
                            collectCount: data["collectCount"] as? Int ?? 0,
                            like: data["like"] as? [String] ?? [],
                            likeCount: data["likeCount"] as? Int ?? 0,
                            dislike: data["dislike"] as? [String] ?? [],
                            dislikeCount: data["dislikeCount"] as? Int ?? 0,
                            date: data["date"] as? String ?? "NULL"
                        )
                        
                        noteResult.append(note)
                    }
                    
                    completion(noteResult)
                }
            }
    }
    //MARK: 從Firestore更新筆記指定Count的值
    func updateNoteCountColumn(note: String, column: String, number: Int)
    {
        self.firestore
            .collection("Note")
            .document(note)
            .updateData([column: FieldValue.increment(Int64(number))])
            {error in
                if let error=error
                {
                    print("Firestorer updateNoteCountColumn(\(column), \(number)) Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 從Firestore更新筆記指定欄位中陣列的值
    func updateNoteColumn(note: String, column: String, user: String)
    {
        self.firestore
            .collection("Note")
            .document(note)
            .updateData([column: FieldValue.arrayUnion([user])])
            {error in
                if let error=error
                {
                    print("Firestorer updateNoteCountColumn(\(column), \(user)) Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 從Firestore更新筆記中指定欄位的值
    func updateNoteColumn(note: String, column: String, title: String, text: String, tag: String="")
    {
        self.firestore
            .collection("Note")
            .document(note)
            //修改title及text欄位的值
            .updateData(tag.isEmpty ? ["title": title, "text": text]:["title": title, "text": text, "tag": tag])
            {error in
                if let error=error
                {
                    print("Firestorer updateNoteCountColumn(\(column), \(title), \(text), \(tag)) Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 將筆記存進Firestore
    func uploadNote(note: Note, user: User, completion: @escaping () -> Void)
    {
        //確認是否登入
        guard let id=Authenticationer().getID() else { return }
        
        //取得Realtime Database中的指定資料名稱
        self.realtime.getData(column: "Note")
        {data in
            if let data=data, let number=Int(data)
            {
                //取得資料成功
                user.note=number
            }
        }
        
        //更新Realtime Database中的指定資料及user中的指定資料
        self.realtime.updateData(column: "Note", data: "\(user.note+1)")
        {
            do
            {
                try self.firestore
                    .collection("Note")
                    //相同的document ID會覆蓋住 所以要分開 因為剛剛先把Realtime Database的筆記數量+1 所以現在要-1
                    .document(id.appending(" \(user.note-1)"))
                    .setData(from: note)
                    {error in
                        if let error=error
                        {
                            print("Firestorer uploadNote() Error: \(error.localizedDescription)")
                        }
                        
                        completion()
                    }
            }
            catch
            {
                print("Firestorer uploadNote() Error")
            }
        }
    }
}
