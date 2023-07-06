//
//  GameRecordViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/07/05.
//

import UIKit

class GameRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gameRecordHeadView: UIView!
    @IBOutlet weak var gameRecordTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!

    weak var gameRecordDelegate: GameRecordDelegate?
    var gameRecordList: [[String: Any]] {
        return gameRecordDelegate?.gameRecord() ?? []
    }
    var highScore: String {
        let score = gameRecordDelegate?.gameHighScore() ?? -1
        if (score == -1) {
            return "--"
        } else {
            return "\(score)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameRecordTableView.delegate = self
        gameRecordTableView.dataSource = self
        
        self.makeViewRoundShape(cornerRadius: 20)
        gameRecordTableView.backgroundColor = UIColor(hex: "#F4F4F4")
        if (!gameRecordList.isEmpty) {
            noDataView.isHidden = true
        }
        highScoreLabel.text = "최고 점수: \(highScore)점"
    }
    
    @IBAction func moveBackBtnPressed(_ sender: UIButton) {
        moveBackToStartingVC(vc: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameRecordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameRecordTableView.dequeueReusableCell(withIdentifier: "GameRecordCell", for: indexPath) as! GameRecordTableViewCell
        
        let gameScore = gameRecordList[indexPath.row]["gameScore"]! as! Int
        let gamePlayTime = gameRecordList[indexPath.row]["gameTime"]! as! String
        
        cell.gameScoreLabel.text = "\(gameScore)점"
        cell.gamePlayTimeLabel.text = gamePlayTime
        return cell
    }
    
    func makeViewRoundShape(cornerRadius: CGFloat) {
        gameRecordHeadView
            .layer.cornerRadius = cornerRadius
        gameRecordHeadView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        gameRecordTableView
            .layer.cornerRadius = cornerRadius
        gameRecordTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
