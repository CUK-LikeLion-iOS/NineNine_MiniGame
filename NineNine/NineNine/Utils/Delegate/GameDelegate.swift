//
//  File.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

@objc protocol GameDelegate: AnyObject {
    func gameScore() -> Int
    @objc optional func gameRank() -> Int
}

protocol GameRecordDelegate: AnyObject {
    func gameRecord() -> [[String: Any]]
    func gameHighScore() -> Int
}
