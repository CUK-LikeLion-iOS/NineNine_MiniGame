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

    var score: Int = 0
    let gameResource: BBGameData = BBGameData()
    var swipingCatImageList: [UIImage] {
        get {
            return gameResource.swipingCatImageArray()
        }
    }
    var fishThumbImage: UIImage {
        return gameResource.fishThumbImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(score)"
        slider.setThumbImage(fishThumbImage, for: .normal) // 슬라이더의 thumb가 터치되지 않았을 때
        slider.setThumbImage(fishThumbImage, for: .highlighted) // thumb가 터치되었을 때
        
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        countDownBeforeGame(countDownView: countDownView)
        timeTravel()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let image: UIImage = sender.value < 0.5 ? swipingCatImageList[0] : swipingCatImageList[1]

        if (catImage.image != image) {
            catImage.image = image
            score += 1
            scoreLabel.text = "\(score)"
        }
    }
    
    // BBGameProtocol 필수 구현 메서드
    func showGameResult() -> Int {
        return score
    }
    
    func timeTravel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0) {
            moveToGameResultVC(gameVC: self)
        }
    }
}
