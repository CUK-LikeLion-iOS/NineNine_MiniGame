//
//  GameRecordTableViewCell.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/07/05.
//

import UIKit

class GameRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var gameScoreLabel: UILabel!
    @IBOutlet weak var gamePlayTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        // Configure the view for the selected state
    }

}
