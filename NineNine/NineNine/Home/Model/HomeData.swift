//
//  MainData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct HomeData {
    private let gameTitles: [String] = ["탭탭", "쉐킷쉐킷", "부비부비", "더하기를 하자!", "곱하기를 하자!"]
    private let gameImages: [UIImage] = [#imageLiteral(resourceName: "tabtab"), #imageLiteral(resourceName: "Shake"), #imageLiteral(resourceName: "swipe"), #imageLiteral(resourceName: "swipe"), #imageLiteral(resourceName: "swipe")]
    
    func gameTitleArray() -> [String] {
        return gameTitles
    }
    
    func gameImageArray() -> [UIImage] {
        return gameImages
    }
}
