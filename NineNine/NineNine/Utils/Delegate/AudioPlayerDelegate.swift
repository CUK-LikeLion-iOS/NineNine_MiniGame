//
//  AVAudioPlayerDelegate.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

protocol AudioPlayerDelegate: AnyObject {
    func stopAudioPlayer()
    func playAudioPlayer()
}

// AnyObject를 따르도록 한 이유 https://jusung.github.io/classOnlyProtocol/

