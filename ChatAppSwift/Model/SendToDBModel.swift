//
//  SendToDBModel.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/28.
//

import Foundation
import FirebaseStorage

// 画像データをストレージに飛ばす
class sendToDBModel {
    init() {
        <#statements#>
    }

    func sendProfileImageData(data:Data) {
        
        let image = UIImage(data: data)
        
        // データを圧縮
        let profileImage = image?.jpegData(compressionQuality: 0.1)
        
        // ディレクトリの作成
        let imageRef = Storage.storage().reference().child("profileImage")
    }
}
