//
//  TapTapGameData.swift
//  NineNine
//
//  Created by 김희은 on 2023/07/05.
//

import UIKit

struct TapTapGameData {
    private let cheeseButtonImage:[UIImage] = [#imageLiteral(resourceName: "TapTapGame_cheesebtn"), #imageLiteral(resourceName: "TapTapGame_cheesebtn_pushed")]
    private let pushingCatImages:[UIImage] = [#imageLiteral(resourceName: "TapTapGame_cat_before_push"), #imageLiteral(resourceName: "TapTapGame_cat_after_push")]
    
    func cheeseButtonImageArray() -> [UIImage] {
        return cheeseButtonImage
    }
    func pushingCatImageArray() -> [UIImage] {
        return pushingCatImages
    }
}
