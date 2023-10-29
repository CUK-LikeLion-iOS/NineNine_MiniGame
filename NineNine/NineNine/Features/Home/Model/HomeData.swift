//
//  MainData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct HomeData {
    private let gameTitles: [String] = ["탭탭", "쉐킷쉐킷", "부비부비", "더하기를 하자!", "곱하기를 하자!"]
    private let gameImages: [UIImage] = [#imageLiteral(resourceName: "icon_TapTap"), #imageLiteral(resourceName: "icon_ShakeIt"), #imageLiteral(resourceName: "icon_BB"), #imageLiteral(resourceName: "icon_Plus"), #imageLiteral(resourceName: "icon_Multiply")]
    
    func gameTitleArray() -> [String] {
        return gameTitles
    }
    
    func gameImageArray() -> [UIImage] {
        return gameImages
    }
}
