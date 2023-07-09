//
//  BBStartingViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/29.
//

import UIKit
import AVFoundation
import Network

class StartingViewController: UIViewController, AVAudioPlayerDelegate, GameRecordDelegate {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameStartBtn: UIImageView!
    @IBOutlet weak var loadingView: UIView!

    // Delegate 프로퍼티
    weak var audioDelegate: AudioPlayerDelegate?
    weak var selectedGameDelegate: SelectedGameDelegate?
    var selectedGameNumber: Int {
        guard let gameNumber = selectedGameDelegate?.selectedGameNumber() else {
            print("Error: selectedGameDelegate Missing!")
            moveBackToHomeVC(vc: self)
            return -1
        }
        return gameNumber
    }

    // Network 관련 프로퍼티
    var isConnectedNetwork = true
    let monitor = NWPathMonitor()
    
    // DB 관련 프로퍼티
    let db = DataStorage()
    var gameScoreAndPlayTime: [[String: Any]] = []
    
    // Audio 관련 프로퍼티
    var player: AVAudioPlayer? = makeAudioPlayer(audioResource: "Game")
    
    // Game Resource 관련 프로퍼티
    let gameResource = GameResource()
    var gameStartBtnImages: [UIImage] {
        return gameResource.gameStartBtnImageArray()
    }
    var gameSBandVCs: [(String, String)] {
        return gameResource.gameStoryBoardAndViewControllers()
    }
    var selectedGameTitle: String {
        return gameResource.gameTitleList()[selectedGameNumber]
    }
    
    /* --------------------------- View LifeCycle 메서드 --------------------------- */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView.isHidden = true
        renderSelectedGameResource()
        detectNetworkConnected()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameStartBtn.image = gameStartBtnImages[0]
        audioDelegate?.playAudioPlayer()
    }

    /* --------------------------- IBAction 메서드 --------------------------- */
    
    @IBAction func gameStartBtnPressed(_ sender: UIButton) {
        gameStartBtn.image = gameStartBtnImages[1]
    }

    @IBAction func moveBack(_ sender: UIButton) {
        moveBackToHomeVC(vc: self)
    }
    
    @IBAction func showGameRecord(_ sender: UIButton) {
        self.loadingView.isHidden = false
        
        Task {
            self.gameScoreAndPlayTime = await db.loadGameRecord(gameName: selectedGameTitle)
            self.loadingView.isHidden = true
            moveToGameRecordVC(startingVC: self)
        }
        
    }
    
    @IBAction func moveGameView(_ sender: UIButton) {
        moveToGameVC(startingVC: self, gameSBandVC: gameSBandVCs[selectedGameNumber])
        
        audioDelegate?.stopAudioPlayer() // 게임 스타트 버튼 눌리면 Main BGM 꺼짐
        player?.delegate = self
        player?.prepareToPlay()
        player?.play()
    }
    
    /* -------------------------------------------------------------------- */

    // 오디오 플레이어가 종료되었으면 할당 해제
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        weak var audioPlayer = player
        audioPlayer = nil
    }
    
    /* ------------------------- 네트워크 관련 메서드 ---------------------------- */
    
    func detectNetworkConnected() {
        // self.isConnectedNetwork로 조건문 검사를 하는 이유 -> 빼고 검사하면 이유는 모르겠지만 두 번 실행됨
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied && self.isConnectedNetwork == false {
                DispatchQueue.main.async {
                    showAlert(title: "네트워크 연결 성공", content: "네트워크가 다시 연결되었습니다.\n게임 결과가 정상적으로 기록되고 열람됩니다.", vc: self)
                }
                self.isConnectedNetwork = true
            } else if path.status == .unsatisfied && self.isConnectedNetwork == true {
                DispatchQueue.main.async {
                    showAlert(title: "네트워크 연결 실패", content: "현재 네트워크에 연결되어 있지 않습니다.\n게임에는 지장이 없으나 게임 결과의 열람과 기록에 실패할 수 있으니 주의해 주세요.", vc: self)
                }
                self.isConnectedNetwork = false
            }
        }
        
        self.monitor.start(queue: DispatchQueue.global())
    }
    
    func stopDetectNetwork() {
        self.monitor.cancel()
    }
    
    /* ------------------------- Game Record Delegate 필수 구현 메서드 ------------------------ */
    
    func gameRecord() -> [[String : Any]] {
        return gameScoreAndPlayTime
    }
    
    func gameHighScore() -> Int {
        return db.loadHighScore(gameName: selectedGameTitle)
    }
    
    /* ----------------------------------------------------------------------------------- */
    
    func renderSelectedGameResource() {
        let gameNumber = selectedGameNumber
        let gameStartingResource = gameResource.gameInformation()
        
        gameTitle.text = gameStartingResource[gameNumber].0
        gameDescription.text = gameStartingResource[gameNumber].1
        titleImage.image = gameStartingResource[gameNumber].2
    }
}
