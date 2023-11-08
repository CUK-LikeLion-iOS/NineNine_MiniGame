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

    // Delegate 관련 프로퍼티
    weak var gameRecordDelegate: GameRecordDelegate?
    var gameRecordList: [[String: Any]] {
        guard let gameRecord = gameRecordDelegate?.gameRecord() else {
            print("Error: gameRecordDelegate Missing!!")
            moveBackToStartingVC(vc: self)
            return []
        }
        
        return gameRecord
    }
    var highScore: String {
        guard let gameHighScore = gameRecordDelegate?.gameHighScore() else {
            print("Error: gameRecordDelegate Missing!!")
            moveBackToStartingVC(vc: self)
            return ""
        }
        
        return "\(gameHighScore)"
    }
}

extension GameRecordViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!gameRecordList.isEmpty) {
            noDataView.isHidden = true
        }
        
        gameRecordTableView.delegate = self
        gameRecordTableView.dataSource = self
        gameRecordTableView.backgroundColor = UIColor(hex: "#F4F4F4")
        
        self.makeViewRoundShape(cornerRadius: 20)
        
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
        let gameRecord = gameRecordList[indexPath.row]
        let gameScore = gameRecord["gameScore"]! as! Int
        let gamePlayTime = gameRecord["gameTime"]! as! String
        
        cell.gameScoreLabel.text = "\(gameScore)점"
        cell.gamePlayTimeLabel.text = gamePlayTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let selectedIndexPath = gameRecordTableView.indexPathForSelectedRow {
            gameRecordTableView.deselectRow(at: selectedIndexPath, animated: true)
        }
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
