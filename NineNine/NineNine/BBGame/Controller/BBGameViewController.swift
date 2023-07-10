//
//  BBGameViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/01.
//

import UIKit

class BBGameViewController: UIViewController, GameDelegate {

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    

    // Game Resource 관련 프로퍼티
    let gameResource: BBGameResource = BBGameResource()
    var fishThumbImage: UIImage {
        return gameResource.fishThumbImage()
    }
    var swipingCatImageList: [UIImage] {
        return gameResource.swipingCatImageArray()
    }
    
    // Game Timer 관련 프로퍼티
    var gameTimer: GameTimer?
    
    // 게임 점수 관련 프로퍼티
    let highScore = DataStorage().loadHighScore(gameName: "BBGame")
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = gameResource.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            scoreLabel.text = "\(score)"
        }
    }

    /* -------------------------------------------------------------------------- */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.setThumbImage(fishThumbImage, for: .normal) // 슬라이더의 thumb가 터치되지 않았을 때
        slider.setThumbImage(fishThumbImage, for: .highlighted) // thumb가 터치되었을 때
        
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        countDownBeforeGame(countDownView: countDownView)
        countDownGame()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let image: UIImage = sender.value < 0.5 ? swipingCatImageList[0] : swipingCatImageList[1]

        if (catImage.image != image) {
            catImage.image = image
            score += 1
        }
    }
    
    // BBGameProtocol 필수 구현 메서드
    func showGameResult() -> Int {
        return score
    }
    
    func countDownGame() {
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
    }
}
