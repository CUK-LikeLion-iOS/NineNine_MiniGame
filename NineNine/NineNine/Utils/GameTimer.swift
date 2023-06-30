/*
 progressview 를 좌 : 70 우 :70 상 : 30 높이 : 25로 설정해주세요
 
 모르겠으면 MultiplyGame storyboard 에서 타임바 어떻게
 오토레이아웃 했는지 참조하기 !
 
 progressview 와 , label 이름은 각각 timeBar,timeLabel
 로 설정해서 하기
 label 은 굳이 오토레이아웃으로 안해도 됨 코드로 설정했음 !
 
 */

import UIKit

class GameTimer {
   

    private var timer: DispatchSourceTimer?
    private var remainingTime: TimeInterval = 13.0
    private var controller: UIViewController
    private var score: Int = 0
    private var timeBar : UIProgressView
    private var timeLabel : UILabel
    
    
    init(controller: UIViewController, timeBar : UIProgressView, timeLabel : UILabel) {
        
        self.controller = controller
        self.timeBar = timeBar
        self.timeLabel = timeLabel
        setupTimeBar()
    }
    
    private func setupTimeBar() {
        
        // timeBar 디자인 설정
        timeBar.clipsToBounds = true
        timeBar.layer.cornerRadius = 10
        
        // 타임라벨 설정
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
                    timeLabel.centerXAnchor.constraint(equalTo: timeBar.centerXAnchor),
                    timeLabel.centerYAnchor.constraint(equalTo: timeBar.centerYAnchor)
                ])
    }
    
    
    func startTimer() {
       
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        timer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.remainingTime -= 0.1
            
            DispatchQueue.main.async {
                self.updateTimeBar()
                if self.remainingTime <= 10 {
                    let formattedRemainingTime = String(format: "%.2f", self.remainingTime)
                    self.timeLabel.text = "\(formattedRemainingTime)"
                }
                if self.remainingTime <= 0 {
                    self.timer?.cancel()
                    self.timerExpired()
                }
            }
        }
        timer?.resume()
    }
    
    private func updateTimeBar() {
        let progress = Float(remainingTime / 10.0)
        timeBar.setProgress(progress, animated: true)
    }
    
    private func timerExpired() {
        moveToGameResultVC(gameVC: controller)
    }
    
}
