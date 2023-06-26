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

    let gamseResource: BBGameData = BBGameData()
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(score)"
        slider.setThumbImage(gamseResource.fishThumbImage(), for: .normal) // 슬라이더의 thumb가 터치되지 않았을 때
        slider.setThumbImage(gamseResource.fishThumbImage(), for: .highlighted) // thumb가 터치되었을 때
        
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        countDownBeforeGame(countDownView: countDownView)
        timeTravel()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let swipingCatImages = gamseResource.swipingCatImageArray()
        let image: UIImage = sender.value < 0.5 ? swipingCatImages[0] : swipingCatImages[1]

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
            let storyboard = UIStoryboard(name: "Ready&Finish", bundle: nil)

            guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameResultViewController") as? GameResultViewController else {
                return
            }
            
            nextVC.delegate = self
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }

}
