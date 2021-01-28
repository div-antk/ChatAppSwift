//
//  SendToDBModel.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/28.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    
    func sendProfileOKDelegate(url:String)
}

// 画像データをストレージに飛ばす
class SendToDBModel {
    
    // インスタンスとして持つ
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init() {
        <#statements#>
    }

    func sendProfileImageData(data:Data) {
        
        let image = UIImage(data: data)
        
        // データを圧縮
        let profileImage = image?.jpegData(compressionQuality: 0.1)
        
        // パスを作成する（ディレクトリ/ファイル名）
        let imageRef = Storage.storage().reference().child("profileImage")
            .child("\(UUID().uuidString +  String(Date().timeIntervalSince1970)).jpg")
        
        // データを置く
        imageRef.putData(profileImage!, metadata: nil) { (metaData, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            // 画像が保存されたURLを引数に取る
            imageRef.downloadURL { (url, error) in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                // userImageのURLを保存
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
            }
        }
    }
}
