//
//  StackNavigation.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/23.
//

import UIKit

func pushStackNavigationAddGameDelegate(vc: UIViewController, storyBoardID: String) {
    var uvc: UIViewController

    // 리펙토링 필요!!!!
    switch storyBoardID {
    case "BBGameResultVC":
        guard let nextVC = vc.storyboard?.instantiateViewController(identifier: "\(storyBoardID)") as? GameResultViewController else {
             return
         }
        nextVC.delegate = vc as? GameDelegate
        uvc = nextVC
        break
    default:
        return
    }

    vc.navigationController?.pushViewController(uvc, animated: true)
}

func popStackNavigation(vc: UIViewController) {
    vc.navigationController?.popViewController(animated: true)
}
