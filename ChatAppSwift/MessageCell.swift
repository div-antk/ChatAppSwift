//
//  MessageCell.swift
//  ChatAppSwift
//
//  Created by Takuya Ando on 2021/01/30.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // 角を丸くする
        leftImageView.layer.cornerRadius = 25.0
        rightImageView.layer.cornerRadius = 25.0
        backView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
