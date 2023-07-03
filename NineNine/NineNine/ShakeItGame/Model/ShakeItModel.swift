//
//  ShakeItModel.swift
//  NineNine
//
//  Created by Demian on 2023/07/02.
//

import UIKit

struct ShakeItGameData {
    private let shakingCatImage: UIImage = #imageLiteral(resourceName: "ShakeItGame_after_shake")
    
    func shakingCat() -> UIImage {
        return shakingCatImage
    }
}
