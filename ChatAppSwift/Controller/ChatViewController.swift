//
//  ChatViewController.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/29.
//

import UIKit
import Firebase
import SDWebImage

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    let db = Firestore.firestore()
    
    var roomName = String()
    var imageString = String()
    
    var messages:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        
        if roomName == "" {
            
            roomName = "All"
        }
        // タイトルバーにルーム名を表示
        self.navigationItem.title = roomName
        
        loadMessages(roomName: roomName)
    }
    
    // メッセージを取得
    func loadMessages(roomName:String) {
        
        db.collection(roomName).order(by: "date").addSnapshotListener { (snapShot, error) in
            
            self.messages = []
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents {
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    if let sender = data["sender"] as? String,
                       let body = data["body"] as? String,
                       let imageString = data["imageString"] as? String
                    {
                        // 構造体
                        let newMessage = Message(sender: sender, body: body, imageString: imageString)
                        
                        // 構造体がこの中に入る
                        self.messages.append(newMessage)
                    }
                }
            }
        }
        
    }
    
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    // セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MessageCellのプロパティにアクセスできるようにする
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        
        let message = messages[indexPath.row]
        
        cell.label.text = message.body
        
        // カスタムセルのプロフィール画像を表示する位置
        if message.sender == Auth.auth().currentUser?.email {
            
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            // 画像呼び出し元
            cell.rightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            // 背景色
            cell.backView.backgroundColor = .systemTeal
            cell.label.textColor = .white
        
        } else {
        
            // elseの場合は基本的に全部逆
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            // 画像呼び出し元
            cell.rightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            // 背景色
            cell.backView.backgroundColor = .systemOrange
            cell.label.textColor = .white
        }
        
        return cell
    }
    
    

    // 送信
    @IBAction func send(_ sender: Any) {
    
        if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            
            db.collection(roomName).addDocument(data: [
                "sender":sender,
                "body":messageBody,
                "imageString":imageString,
                "date":Date().timeIntervalSince1970
            ]) { (error) in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                // 非同期処理
                DispatchQueue.main.async {
                    // フィールドを空にする
                    self.messageTextField.text = ""
                    // キーボードを閉じる
                    self.messageTextField.resignFirstResponder()
                    
                    DispatchQueue.main.async {
                        // tableViewにmessageを表示
                        self.tableView.reloadData()
                        
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        // 送信後に最新のmessageまで移動
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
                
            }
        }
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
