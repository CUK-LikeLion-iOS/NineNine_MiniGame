//
//  File.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

protocol GameDelegate: AnyObject {
    func showGameResult() -> Int
}


protocol GameRecordDelegate: AnyObject {
    func gameRecord() -> [[String: Any]]
    func gameHighScore() -> Int
}
