//
//  RoomViewController.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/31.
//

import UIKit
import ViewAnimator


class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var roomNameArray = ["誰でも話そうよ！","20代たまり場！","1人ぼっち集合","地球住み集合！！","好きなYoutuberを語ろう","大学生集合！！","高校生集合！！","中学生集合！！","暇なひと集合！","A型の人！！"]
    var roomImageStringArray = ["0","1","2","3","4","5","6","7","8","9"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // ViewAnimatorがかかる場合、テーブルが表示されると挙動がおかしくなるので
        tableView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    // ViewAnimator
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isHidden = false
        
        let animation = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
        UIView.animate(views: tableView.visibleCells, animations: animation, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roomNameArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
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
