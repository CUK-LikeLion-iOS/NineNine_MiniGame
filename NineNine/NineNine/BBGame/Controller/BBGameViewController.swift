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
    
    let gameResource: BBGameData = BBGameData()
    var gameTimer: GameTimer?
    var swipingCatImageList: [UIImage] {
            return gameResource.swipingCatImageArray()
    }
    var fishThumbImage: UIImage {
        return gameResource.fishThumbImage()
    }
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
            if (score < 40) {
                scoreLabel.textColor = .systemPink
            }
            else if (score < 70) {
                scoreLabel.textColor = .systemGreen
            }
            else if (score < 100) {
                scoreLabel.textColor = .systemBlue
            }
            else {
                scoreLabel.textColor = .systemPurple
            }
        }
    }

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
