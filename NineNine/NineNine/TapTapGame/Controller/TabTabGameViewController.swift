//
//  TabTabGameViewController.swift
//  NineNine
//
//  Created by 김희은 on 2023/06/30.
//

import UIKit

class TabTabGameViewController: UIViewController, GameDelegate {
    
    @IBOutlet weak var tappingCatImage: UIImageView!
    @IBOutlet weak var cheeseButton: UIButton!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var countDownView: UIView!
    
    // MARK: - GameResource 관련 프로퍼티
    let gameResource: TapTapGameData = TapTapGameData()
    var tapCheeseImage: [UIImage] {
        return gameResource.cheeseButtonImageArray()
    }
    var pushingCatImage: [UIImage] {
        return gameResource.pushingCatImageArray()
    }
 
    lazy var pushingCat = pushingCatImage[1]
    lazy var notPushingCat = pushingCatImage[0]
    
    lazy var pushedButton = tapCheeseImage[1]
    lazy var notPushedButton = tapCheeseImage[0]
    
    
    // MARK: - Game Timer 관련 프로퍼티
    var gameTimer: GameTimer?
    
    // MARK: - game score 관련 프로퍼티
    let highScore = DataStorage().loadHighScore(gameName: "TapTapGame")
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = gameResource.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            scoreLabel.text = "\(score)"
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        countDownBeforeGame(countDownView: countDownView)
        
        self.scoreLabel.text = "\(score)"
        tappingCatImage.image = notPushingCat
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
        
        countDownBeforeGame(countDownView: countDownView)
        countDownGame()
    }
    
    // MARK: - 탭탭 버튼 전환 구현부
    @IBAction func buttonTouchDown(_ sender: Any) {
        self.score += 1
        self.scoreLabel.text = "\(score)"
        tappingCatImage.image = pushingCat
    }
    @IBAction func buttonTouchUp(_ sender: Any) {
        tappingCatImage.image = notPushingCat
    }
    
    
    func countDownGame() {
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
    }
   
    func gameScore() -> Int {
        return score
    }

}
//코드 리펙토링


//버튼 푸쉬 이미지 변경
