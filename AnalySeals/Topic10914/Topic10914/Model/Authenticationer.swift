//
//  Authenticationer.swift
//  Topic10914
//
//  Created by 曾品瑞 on 2023/9/14.
//

import FirebaseAuth
import FirebaseDatabase

//Firebase Authentication
struct Authenticationer
{
    let authentication: Auth
    
    init()
    {
        self.authentication=Auth.auth()
    }
    
    //MARK: 刪除當前使用者的資料
    func delete(completion: @escaping () -> Void)
    {
        if let user=self.authentication.currentUser
        {
            user.delete
            {error in
                if let error=error
                {
                    print("Authenticationer delete() Error: \(error.localizedDescription)")
                }
                
                completion()
            }
        }
    }
    //MARK: 取得當前使用者的UID
    func getID() -> String?
    {
        if let user=self.authentication.currentUser
        {
            return user.uid
        }
        else
        {
            return nil
        }
    }
    //MARK: 寄送修改密碼
    func resetPassword(account: String)
    {
        self.authentication.sendPasswordReset(withEmail: account)
        {error in
            if let error=error
            {
                print("Authenticationer resetPassword() Error: \(error.localizedDescription)")
            }
        }
    }
    //MARK: 使用者登入驗證
    func signIn(account: String, password: String, completion: @escaping (Error?) -> Void)
    {
        self.authentication
            .signIn(withEmail: account, password: password)
            {(_, error) in
                if let error=error
                {
                    completion(error)
                }
                else
                {
                    completion(nil)
                }
            }
    }
    //MARK: 使用者登出驗證
    func signOut(completion: @escaping () -> Void)
    {
        do
        {
            try self.authentication.signOut()
            completion()
        }
        catch
        {
            print("Authenticationer signOut() Error")
            completion()
        }
    }
    //MARK: 使用者註冊資料
    func signUp(information: [String], completion: @escaping (Error?) -> Void)
    {
        self.authentication
            .createUser(withEmail: information[0], password: information[1])
            {(sign, error) in
                if let error=error
                {
                    completion(error)
                }
                else if let sign=sign
                {
                    //取得 User節點 中的 id節點
                    let reference=Database
                        .database()
                        .reference()
                        .child("User")
                        .child(sign.user.uid)
                    
                    //新增資料
                    reference.setValue(
                        [
                            "Account": information[0],
                            "Password": information[1],
                            "Name": information[2],
                            "Gender": information[3],
                            "City": information[5],
                            "Degree": information[6],
                            "School": information[7],
                            "Bio": nil,
                            "Note": "0",
                            "Track": true,
                            "MeTag": nil
                        ] as [String: Any?]
                    )
                    {(_, _) in
                        if let error=error
                        {
                            completion(error)
                        }
                        else
                        {
                            completion(nil)
                        }
                    }
                }
            }
    }
}
