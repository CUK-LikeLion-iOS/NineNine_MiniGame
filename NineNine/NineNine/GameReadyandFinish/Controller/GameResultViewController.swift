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
    @IBOutlet weak var gameImageView: UIImageView!

    weak var gameDelegate: GameDelegate?
    weak var selectedGameDelegate: SelectedGameDelegate?
    let db = FireStore()
    let gameData = GameData()
    var gameScore: Int {
        get {
            return gameDelegate?.showGameResult() ?? 0
        }
    }
    var selectedGameTitle: String {
        get {
            let selectedGameNumber = selectedGameDelegate?.selectedGameNumber() ?? 0
            return gameData.gameTitleList()[selectedGameNumber]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = true
        score.text = "\(gameScore)"
        renderSelectedGameImage()
    }
    
    func renderSelectedGameImage() {
        guard let gameNumber = selectedGameDelegate?.selectedGameNumber() else {
            return
        }
        let gameResource = gameData.gameResource()
        
        gameImageView.image = gameResource[gameNumber].2
    }
    
    @IBAction func moveBackToStartBtnPressed(_ sender: UIButton) {
        // 타임 아웃 구현해보기 목표,,,,
        Task {
            loadingView.isHidden = false
            await self.db.recordScore(score: self.gameScore, gameName: "\(self.selectedGameTitle)")
            loadingView.isHidden = true
            moveBackToStartingVC(vc: self)
        }
    }
}
