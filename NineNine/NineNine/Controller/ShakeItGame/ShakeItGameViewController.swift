//
//  ShakeItGameViewController.swift
//  NineNine
//
//  Created by Demian on 2023/06/26.
//

import UIKit
import CoreMotion

class ShakeItGameViewController: UIViewController {
    // 아울렛
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var playerNumber = 0    // 총 인원수
    var playerCounter = 1   // 현재 플레이어 번호
    var timer: DispatchSourceTimer?
    var remainingTime: TimeInterval = 10.0
    var score: UInt16 = 0 {
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
        willSet {   // 처음 흔들면 타이머 시작
            if (newValue == 1) {
                startTimer()
                messageLabel.text = "빠르게 흔드세요!"
            }
        }
    }
    
    // 기울기 관련 프로퍼티
    var motionManager: CMMotionManager!
    var tiltTimer: Timer!
    
    var previousPitch: Double = 0
    var previousRoll: Double = 0
    let TILTING_THRESHOLD: Double = 0.3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        motionManager = CMMotionManager()
        self.tiltTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkTilt), userInfo: nil, repeats: true)
        
    }
    
    // 매 0.1초마다 기울임 검사
    @objc func checkTilt() {
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
    
    func startTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        
        timer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.remainingTime -= 0.1
            DispatchQueue.main.async {
                self.updateTimeBar()
                if self.remainingTime <= 0 {
                    self.timer?.cancel()
                    self.timerExpired()
                }
            }
        }
        timer?.resume()
    }
    
    func timerExpired() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "알림", message: "플레이어의 점수는 \(self.score) 점입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                self.score = 0
                self.remainingTime = 10.0
                self.updateTimeBar()
                // self.startTimer()
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateTimeBar() {
        let progress = Float(remainingTime / 10.0)
        //timeBar.setProgress(progress, animated: true)
    }

}
