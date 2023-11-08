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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var timeBar: UIProgressView!
    
    let db = DataStorage()
    var gameTimer: GameTimer?
    let shakeitResources = ShakeItGameData()
    var rank: UIColor = .systemRed
    var readyCatImage: UIImage {
        get {
            return shakeitResources.readyCatImage()
        }
    }
    var shakingCatImage: UIImage {
        get {
            return shakeitResources.shakingCatImage()
        }
    }
    var highScore: Int {
        return db.loadHighScore(gameName: "ShakeItGame")
    }
    
    var score: Int = 0 {
        didSet {    // 점수와 레이블의 텍스트를 동기화
            let scoreBoardColor = shakeitResources.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreLabel.text = String(score)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            self.rank = scoreBoardColor[2]
        }
    }
    
    // 기울기 관련 프로퍼티
    var motionManager: CMMotionManager!
    
    var previousPitch: Double = 0
    var previousRoll: Double = 0
    let TILTING_THRESHOLD: Double = 0.3
    
    // 진동(햅틱) 프로퍼티
    var shakingHaptic: UIImpactFeedbackGenerator!
}

extension ShakeItGameViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        countDownBeforeGame(countDownView: countdownView)
        
        shakingHaptic = UIImpactFeedbackGenerator(style: .heavy)
        
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
        startMotionManagerAfter3seconds()
        endMotionManagerAfter13seconds()
    }
    
    // 매 0.1초마다 기울임 검사
    func checkTilt() {
        guard self.motionManager.isDeviceMotionAvailable else { return }
        self.motionManager?.deviceMotionUpdateInterval = 0.1
        
        self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self else { return }
            guard let motion = motion else { return }
            
            let roll = motion.attitude.roll // 좌, 우
            let rollChange = roll - self.previousRoll
            
            // 이전과 비교해 임계치 이상 기울기가 바뀌면 점수 추가
            if (abs(rollChange) > TILTING_THRESHOLD) {
                self.score += 1
                self.catImage.image = self.shakingCatImage
                shakingHaptic.prepare()
                shakingHaptic.impactOccurred()
            }
            else {
                self.catImage.image = self.readyCatImage
            }
            
            self.previousRoll = roll
        }
    }
    
    func startMotionManagerAfter3seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.motionManager = CMMotionManager()
            self.checkTilt()
        }
    }
    
    func endMotionManagerAfter13seconds() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0) {
            self.motionManager.stopDeviceMotionUpdates()
        }
    }
    
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
