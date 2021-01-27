//
//  RegisterViewController.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/27.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let checkModel = CheckPermission()
        checkModel.showCheckPermission()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func regitster(_ sender: Any) {
    
        // email、passwordが空ではないことを確認
        
        // 登録
        
        // email、profileImageの値
        
    }
    
    // プロフィール画像をタップしたとき
    @IBAction func tapImageView(_ sender: Any) {
        
        // カメラ、アルバムから
        
        // アラートを出す
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
