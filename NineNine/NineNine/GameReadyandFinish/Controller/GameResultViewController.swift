//
//  BBGameResultViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

class GameResultViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    
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

        score.text = "\(gameScore)"
        timeTravel()
    }

    func timeTravel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            moveBackToStartingVC(vc: self)
            self.db.recordScore(score: self.gameScore, gameName: "\(self.selectedGameTitle)")
        }
    }
}
