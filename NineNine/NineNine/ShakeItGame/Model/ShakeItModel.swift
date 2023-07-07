//
//  ShakeItModel.swift
//  NineNine
//
//  Created by Demian on 2023/07/02.
//

import UIKit

struct ShakeItGameData {
    private let catImage: [UIImage] = [#imageLiteral(resourceName: "ShakeItGame_before_shake"), #imageLiteral(resourceName: "ShakeItGame_after_shake")]
    
    func readyCatImage() -> UIImage {
        return catImage[0]
    }
    
    func shakingCatImage() -> UIImage {
        return catImage[1]
    }
}
