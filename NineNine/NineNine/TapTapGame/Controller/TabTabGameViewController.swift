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
    
    let gameResource: TapTapGameData = TapTapGameData()
    //var score: Int = 0
    
    //lazy var를 위치 옮겨서 let으로 처리할 것
    lazy var tapCheeseImage = gameResource.cheeseButtonImageArray()
    lazy var pushingCatImage = gameResource.pushingCatImageArray()
    
    lazy var pushingCat = pushingCatImage[1]
    lazy var notPushingCat = pushingCatImage[0]
    
    lazy var pushedButton = tapCheeseImage[1]
    lazy var notPushedButton = tapCheeseImage[0]
    
    
    //***
    // Game Timer 관련 프로퍼티
    var gameTimer: GameTimer?
    
    // 게임 점수 관련 프로퍼티
    let highScore = DataStorage().loadHighScore(gameName: "TapTapGame")
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = gameResource.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            scoreLabel.text = "\(score)"
        }
    }
    
    //====================================================//
    
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
    
    @IBAction func ordinaryButton() {
        tappingCatImage.image = notPushingCat
        cheeseButton.isHighlighted = false
        print(cheeseButton.isHighlighted)
        
        
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        cheeseButton.isHighlighted = true
        print(cheeseButton.isHighlighted)
        
        if cheeseButton.isHighlighted == true {
            tappingCatImage.image = pushingCat
            //ordinaryButton()
        }
    }
    
    //탭탭 버튼 전환 구현부
    @IBAction func buttonTouchDown(_ sender: Any) {
        self.score += 1
        self.scoreLabel.text = "\(score)"
        buttonSelected()
    }
    @IBAction func buttonTouchUp(_ sender: Any) {
        buttonNormalMode()
    }

    func buttonNormalMode() {
        tappingCatImage.image = notPushingCat
    }

    func buttonSelected() {
        tappingCatImage.image = pushingCat
    }

    
    func countDownGame() {
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
    }
   
    func gameScore() -> Int {
        return score
    }
    
    
}
//오토레이아웃 - 수정 요망
//코드 리펙토링
