//
//  BBGameData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct BBGameData {
    private let swipingCatImages:[UIImage] = [#imageLiteral(resourceName: "left"), #imageLiteral(resourceName: "right")]
    private let fishImage: UIImage = #imageLiteral(resourceName: "fish_icon")
    
    func swipingCatImageArray() -> [UIImage] {
        return swipingCatImages
    }
    
    func fishThumbImage() -> UIImage {
        return fishImage
    }
}
