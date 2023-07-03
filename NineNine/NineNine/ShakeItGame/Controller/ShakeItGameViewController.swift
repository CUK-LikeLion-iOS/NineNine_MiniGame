//
//  ShakeItGameViewController.swift
//  NineNine
//
//  Created by Demian on 2023/06/26.
//

import UIKit
import CoreMotion

class ShakeItGameViewController: UIViewController, GameDelegate {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var countdownView: UIView!
    
    let shakeitResources = ShakeItGameData()
    
    var timer: DispatchSourceTimer?
    var remainingTime: TimeInterval = 13.0
    var score: Int = 0 {
        didSet {    // 점수와 레이블의 텍스트를 동기화
            scoreLabel.text = String(score)
            if (score < 10) {
                scoreLabel.textColor = .systemBlue
            }
            else if (score < 30) {
                scoreLabel.textColor = .systemCyan
            }
            else if (score < 50) {
                scoreLabel.textColor = .systemGreen
            }
            else {
                scoreLabel.textColor = .systemPink
            }
        }
    }
    
    // 기울기 관련 프로퍼티
    var motionManager: CMMotionManager!
    
    var previousPitch: Double = 0
    var previousRoll: Double = 0
    let TILTING_THRESHOLD: Double = 0.3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        countDownBeforeGame(countDownView: countdownView)
        
        timeTravel()
        startGameAfter3seconds()
    }
    
    // 매 0.1초마다 기울임 검사
    func checkTilt() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager?.deviceMotionUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self else { return }
            guard let motion = motion else { return }
            
            //let pitch = motion.attitude.pitch // 앞, 뒤
            let roll = motion.attitude.roll // 좌, 우
            
            //let pitchChange = pitch - self.previousPitch
            let rollChange = roll - self.previousRoll
            
            // 이전과 비교해 임계치 이상 기울기가 바뀌면 점수 추가
            if (abs(rollChange) > TILTING_THRESHOLD) {
                self.score += 1
            }
            print("rollChange: \(rollChange)")
            
            //self.previousPitch = pitch
            self.previousRoll = roll
        }
    }
    
    func timeTravel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0) {
            self.motionManager.stopDeviceMotionUpdates()
            moveToGameResultVC(gameVC: self)
        }
    }
    
    func startGameAfter3seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.motionManager = CMMotionManager()
            self.checkTilt()
            self.catImage.image = self.shakeitResources.shakingCat()
        }
    }

    func showGameResult() -> Int {
        return score
    }
}
