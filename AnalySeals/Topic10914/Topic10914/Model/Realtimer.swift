//
//  Realtimer.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/6.
//

import FirebaseDatabase

//Firebase Realtime Database
struct Realtimer
{
    private let authentication: Authenticationer
    private let reference: DatabaseReference
    
    init()
    {
        self.authentication=Authenticationer()
        self.reference=Database.database().reference().child("User")
    }
    
    //MARK: 刪除使用者在Realtime Database中的資料
    func deleteData(completion: @escaping () -> Void)
    {
        //確認是否登入
        guard let id=self.authentication.getID() else { return }
        
        //刪除User節點中的id節點中的所有資料
        self.reference
            .child(id)
            .removeValue
            {(error, _) in
                if let error=error
                {
                    print("Realtimer deleteData() Error: \(error.localizedDescription)")
                }
                
                completion()
            }
    }
    //MARK: 查詢資料 column要用當初創建Realtime使用的欄位名稱
    func getData(column: String, completion: @escaping (String?) -> Void)
    {
        //確認是否登入
        guard let id=self.authentication.getID() else { return }
        
        self.reference
            .child(id)
            .child(column)
            .observeSingleEvent(of: .value)
            {result in
                if let data=result.value as? String
                {
                    completion(data)
                }
                else
                {
                    completion(nil)
                }
            }
            withCancel:
            {error in
                print("Realtimer getData(\(column)) Error: \(error.localizedDescription)")
                completion(nil)
            }
    }
    //MARK: 查詢Realtime Database中的Track欄位資料
    func getTrack(completion: @escaping (String?) -> Void)
    {
        //確認是否登入
        guard let id=self.authentication.getID() else { return }
        
        self.reference
            .child(id)
            .child("Track")
            .observeSingleEvent(of: .value)
            {result in
                if let data=result.value as? Bool
                {
                    //儲存Bool不會成功傳遞 改用String
                    completion(String(data))
                }
                else
                {
                    completion(nil)
                }
            }
            withCancel:
            {error in
                print("Realtimer getTrack() Error: \(error.localizedDescription)")
                completion(nil)
            }
    }
    //MARK: 查詢Realtime Database中指定userID的Track欄位資料
    func getTrack(userID: String, completion: @escaping (String?) -> Void)
    {
        self.reference
            .child(userID)
            .child("Track")
            .observeSingleEvent(of: .value)
            {result in
                if let data=result.value as? Bool
                {
                    //儲存Bool不會成功傳遞 改用String
                    completion(String(data))
                }
                else
                {
                    completion(nil)
                }
            }
            withCancel:
            {error in
                print("Realtimer getTrack(\(userID)) Error: \(error.localizedDescription)")
            }
    }
    //MARK: 查詢資料 column要用當初創建Realtime使用的欄位名稱
    func getUserData(userID: String, column: String, completion: @escaping (String?) -> Void)
    {
        self.reference
            .child(userID)
            .child(column)
            .observeSingleEvent(of: .value)
            {result in
                if let data=result.value as? String
                {
                    completion(data)
                }
                else
                {
                    completion(nil)
                }
            }
            withCancel:
            {error in
                print("Realtimer getUserData(\(userID), \(column)) Error: \(error.localizedDescription)")
            }
    }
    func putData(account: String, completion: @escaping ([String:Any]) -> Void)
    {
        self.reference
            .queryOrdered(byChild: "Account")
            .queryEqual(toValue: account)
            .observeSingleEvent(of: .value)
            {result in
                if let value=result.value as? [String: Any]
                {
                    completion(value.first!.value as! [String: Any])
                }
            }
    }
    //MARK: 更新資料 column要用當初創建Realtime使用的欄位名稱 data是更新過後的資料名稱
    func updateData(column: String, data: Bool)
    {
        //確認是否登入
        guard let id=self.authentication.getID() else { return }
        
        //取得 User節點 中的 id節點 中的 指定column節點 中的資料
        self.reference
            .child(id)
            .child(column)
            .setValue(data)
            {(error, _) in
                if let error=error
                {
                    print("Realtimer updateData(\(column)) Error: \(error.localizedDescription)")
                }
            }
    }
    //MARK: 更新資料 column要用當初創建Realtime使用的欄位名稱 data是更新過後的資料名稱
    func updateData(column: String, data: String, completion: @escaping () -> Void)
    {
        //確認是否登入
        guard let id=self.authentication.getID() else { return }
        
        //取得 User節點 中的 id節點 中的 指定column節點 中的資料
        self.reference
            .child(id)
            .child(column)
            .setValue(data=="nil" ? nil:data)
            {(error, _) in
                if let error=error
                {
                    print("Realtimer updateData(\(column)) Error: \(error.localizedDescription)")
                }
                
                completion()
            }
    }
}
