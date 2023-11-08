//
//  BBGameResultViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

class GameResultViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var scoreBoardView: UIImageView!

    // Delegate 관련 프로퍼티
    weak var gameDelegate: GameDelegate?
    weak var selectedGameDelegate: SelectedGameDelegate?
    var gameScore: Int {
        guard let score = gameDelegate?.gameScore() else {
            print("Error: gameDelegate Missing!!")
            moveBackToStartingVC(vc: self)
            return -1
        }
        
        return score
    }
    var selectedGameNumber: Int {
        guard let gameNumber = selectedGameDelegate?.selectedGameNumber() else {
            print("Error: selectedGameDelegate Missing!")
            moveBackToStartingVC(vc: self)
            return -1
        }
        
        return gameNumber
    }
    var rank: Int {
        guard let gameRank = gameDelegate?.gameRank?() else {
            print("Error: gameDelegate Missing!!")
            moveBackToStartingVC(vc: self)
            return 0
        }

        return gameRank
    }

    // DB 관련 프로퍼티
    let db = DataStorage()
    
    // Game Resource 관련 프로퍼티
    let gameResource = GameResource()
    var selectedGameTitle: String {
        return gameResource.gameTitleList()[selectedGameNumber]
    }
    var gameInformationList: [(String, String)] {
        return gameResource.gameInformation()
    }
    var gameRankImageList: [UIImage] {
        return gameResource.gameRankImages()
    }
}

extension GameResultViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = true
        score.text = "\(gameScore)"
        scoreBoardView.image = gameRankImageList[self.rank]
    }
    
    @IBAction func moveBackToStartBtnPressed(_ sender: UIButton) {
        loadingView.isHidden = false
        Task {
            await self.db.recordScore(score: gameScore, gameName: selectedGameTitle)
            loadingView.isHidden = true
            moveBackToStartingVC(vc: self)
        }
    }
}
