//
//  StackNavigation.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/23.
//

import UIKit

func pushStackNavigation(vc: UIViewController, storyBoardID: String) {
    guard let nextVC = vc.storyboard?.instantiateViewController(identifier: "\(storyBoardID)") else {
         return
     }

    vc.navigationController?.pushViewController(nextVC, animated: true)
}

func pushStackNavigationAddGameDelegate(vc: UIViewController, storyBoardID: String) {
    var uvc: UIViewController
    
    // 리펙토링 필요!!!!
    switch storyBoardID {
    case "BBGameResultVC":
        guard let nextVC = vc.storyboard?.instantiateViewController(identifier: "\(storyBoardID)") as? BBGameResultViewController else {
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

// 메인 뷰 컨트롤러에서
func pushNextVCFromMainVC(nextVC vc: UIViewController, mainVC: UIViewController, idx: Int) {
    var targetVC: UIViewController
    switch idx {
//    case 0:
//        탭탭
//        break
//    case 1:
//        쉐킷쉐킷
//        break
    case 2:
        let nextVC = vc as! BBStartingViewController
        nextVC.delegate = mainVC as? AudioPlayerDelegate
        targetVC = nextVC
        break
//    case 3:
//        더하기 게임
//        break
//    case 4:
//        구구단 게임
//        break
    default:
        return
    }
    mainVC.navigationController?.pushViewController(targetVC, animated: true)
}

func popStackNavigation(vc: UIViewController) {
    vc.navigationController?.popViewController(animated: true)
}
