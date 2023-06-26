import UIKit

class GameTimer {
    var timer: DispatchSourceTimer?
    var remainingTime: TimeInterval = 3.0
    var scoreLabel: UILabel
    var controller: UIViewController
    var score: Int = 0

    init(pointLabel: UILabel, controller: UIViewController) {
        self.scoreLabel = pointLabel
        self.controller = controller
    }
    
    // 처음 시작했을때 10초 세팅
    func startTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        timer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.remainingTime -= 0.1
            DispatchQueue.main.async {
                if self.remainingTime <= 0 {
                    self.timer?.cancel()
                    self.timerExpired()
                }
            }
        }
        timer?.resume()
    }
    
    func resetTimer() {
        remainingTime = 3.0
        score = 0
        updateCount()
    }
    
    func startAction() {
        if score == 0 {
            startTimer()
        }
        score += 1
        updateCount()
    }

    private func timerExpired() {
        let alert = UIAlertController(title: "알림", message: "player의 점수는 \(self.score) 점입니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            self.resetTimer()
        })
        controller.present(alert, animated: true, completion: nil)
    }
    
    private func updateCount() {
        scoreLabel.text = "\(score)"
    }
    
}
