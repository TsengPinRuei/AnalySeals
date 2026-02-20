//
//  Storager.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/3/31.
//

import SwiftUI
import FirebaseStorage

struct Storager
{
    //Firebase Storage的參考
    private let reference: StorageReference
    
    //MARK: init()
    init()
    {
        self.reference=Storage.storage().reference()
    }
    
    //MARK: 從Firebase Storage下載圖片
    func downloadImage(noteID: String, completion: @escaping ([(UIImage, String)]) -> Void)
    {
        self.reference
            //Storage資料夾參考位置
            .child(noteID)
            //列出資料夾中的所有檔案
            .listAll
            {(data, error) in
                if let error=error
                {
                    print("Storager downloadImage() Error: \(error.localizedDescription)")
                    completion([])
                }
                else
                {
                    var image: [(UIImage, String)]=[]
                    let dispatchGroup: DispatchGroup=DispatchGroup()
                    
                    //下載並解碼所有圖片
                    for i in data!.items
                    {
                        dispatchGroup.enter()
                        
                        //取得資料
                        i.getData(maxSize: .max)
                        {(data, error) in
                            if let error=error
                            {
                                print("Storager downloadImage \(i) Error: \(error.localizedDescription)")
                            }
                            //將資料轉換成圖片 放進圖片陣列
                            else if let data=data, let uiImage=UIImage(data: data)
                            {
                                //(圖片, 圖片名稱)
                                image.append((uiImage, i.name))
                            }
                            
                            dispatchGroup.leave()
                        }
                    }
                    
                    //完成所有下載 將陣列傳給completion
                    dispatchGroup.notify(queue: .main)
                    {
                        completion(image)
                    }
                }
            }
    }
    //MARK: 從Firebase Storage刪除資料夾中的所有圖片 目前不支援直接刪除資料夾 但是當沒有圖片時 資料夾會消失
    func deleteImage(noteID: String)
    {
        self.reference
            //Storage資料夾參考位置
            .child(noteID)
            //列出資料夾中的所有檔案
            .listAll
            {(data, error) in
                if let error=error
                {
                    print("Storager deleteImage() Error: \(error.localizedDescription)")
                }
                else if let data=data
                {
                    //遍歷資料夾中的所有檔案
                    for i in data.items
                    {
                        //刪除檔案
                        i.delete
                        {error in
                            if let error=error
                            {
                                print("Storager deleteImage \(i) Error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
    }
    //MARK: 上傳圖片到Firebase Storage
    func uploadImage(noteID: String, image: [UIImage?], completion: @escaping () -> Void)
    {
        //遍歷UIImage陣列
        for i in 0..<image.count
        {
            //若有UIImage
            if let imagei=image[i]
            {
                //壓縮成JPEG比較不佔空間
                guard let imageData=imagei.jpegData(compressionQuality: 0.8)
                else
                {
                    print("Storager uploadImage() Error: Convert JPEG Error")
                    return
                }
                
                //為檔案命名
                let child=self.reference.child(noteID).child("image_\(i)")
                
                //上傳圖片
                child.putData(imageData)
                {(_, error) in
                    if let error=error
                    {
                        print("Storager uploadImage \(i) Error: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
        
        completion()
    }
}
