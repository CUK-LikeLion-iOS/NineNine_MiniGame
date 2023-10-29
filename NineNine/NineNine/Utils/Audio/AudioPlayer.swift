//
//  AudioPlayer.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import AVFoundation

func makeAudioPlayer(audioResource: String) -> AVAudioPlayer? {
    var player: AVAudioPlayer!

    guard let url = Bundle.main.url(forResource: "\(audioResource)", withExtension: "m4a") else {
        return nil
    }
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
    } catch let error as NSError {
        print("\(error)")
        return nil
    }
    return player
}
