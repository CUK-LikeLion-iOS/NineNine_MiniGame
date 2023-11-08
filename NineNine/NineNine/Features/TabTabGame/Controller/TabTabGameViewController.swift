//
//  TabTabGameViewController.swift
//  NineNine
//
//  Created by 김희은 on 2023/06/30.
//

import UIKit

class TabTabGameViewController: UIViewController, GameDelegate {
    
    @IBOutlet weak var tappingCatImage: UIImageView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var tapCheeseImageVIew: UIImageView!

    // MARK: - GameResource 관련 프로퍼티
    let gameResource: TabTabGameData = TabTabGameData()
    var tapCheeseImage: [UIImage] {
        return gameResource.cheeseButtonImageArray()
    }
    lazy var pushedButton = tapCheeseImage[1]
    lazy var notPushedButton = tapCheeseImage[0]
    
    var pushingCatImage: [UIImage] {
        return gameResource.pushingCatImageArray()
    }
    lazy var pushingCat = pushingCatImage[1]
    lazy var notPushingCat = pushingCatImage[0]
    
    
    // MARK: - Game Timer 관련 프로퍼티
    var gameTimer: GameTimer?
    
    // MARK: - game score 관련 프로퍼티
    var rank: UIColor = .systemRed
    let highScore = DataStorage().loadHighScore(gameName: "TabTabGame")
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = gameResource.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            self.rank = scoreBoardColor[2]
            scoreLabel.text = "\(score)"
        }
    }

}

extension TabTabGameViewController {
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownBeforeGame(countDownView: countDownView)
        scoreLabel.text = "\(score)"
        setupTapTapGameUI()
        countDownGame()
    }
    
    //MARK: - 탭탭 게임 UI 설정
    private func setupTapTapGameUI() {
        tappingCatImage.image = notPushingCat
        tapCheeseImageVIew.image = notPushedButton
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
    }
    
    // MARK: - 탭탭 버튼 전환 구현부
    @IBAction func buttonTouchDown(_ sender: Any) {
        self.score += 1
        self.scoreLabel.text = "\(score)"
        tappingCatImage.image = pushingCat
        tapCheeseImageVIew.image = pushedButton
    }
    @IBAction func buttonTouchUp(_ sender: Any) {
        tappingCatImage.image = notPushingCat
        tapCheeseImageVIew.image = notPushedButton
    }
    
    // MARK: - 타이머 countDown
    func countDownGame() {
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
    }
   
    // MARK: - 게임 종료 후 score 전달
    func gameScore() -> Int {
        return score
    }
    func gameRank() -> Int {
        switch self.rank {
        case .systemRed:
            return 0
        case .systemGreen:
            return 1
        case .systemBlue:
            return 2
        default:
            return 3
        }
    }
}
