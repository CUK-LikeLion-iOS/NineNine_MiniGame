//
//  BBStartingViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/29.
//

import UIKit
import AVFoundation

class BBStartingViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var gameStartBtn: UIImageView!
    weak var delegate: AudioPlayerDelegate?
    var player: AVAudioPlayer! = makeAudioPlayer(audioResource: "Game")
    let gameStartBtnImages: [UIImage] = BBGameData().gameStartBtnImageArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameStartBtn.image = gameStartBtnImages[0]
    }

    @IBAction func gameStartBtnPressed(_ sender: UIButton) {
        gameStartBtn.image = gameStartBtnImages[1]
    }

    @IBAction func moveBack(_ sender: UIButton) {
        popStackNavigation(vc: self)
    }

    @IBAction func moveBBGameVIew(_ sender: UIButton) {
        pushStackNavigation(vc: self, storyBoardID: "BBGameVC")
        delegate?.stopAudioPlayer() // 게임 스타트 버튼 눌리면 Main BGM 꺼짐
        player?.delegate = self
        player?.prepareToPlay()
        player?.play()
    }
    
    // 오디오 플레이어가 종료되었으면 할당 해제
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        weak var audioPlayer = player
        audioPlayer = nil
    }
}
