//
//  StackNavigation.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/23.
//

import UIKit

func moveToGameVC(startingVC: UIViewController, gameSBandVC: (String, String)) {
    let storyboard = UIStoryboard(name: "\(gameSBandVC.0)", bundle: nil)
    let gameVC = storyboard.instantiateViewController(withIdentifier: "\(gameSBandVC.1)")

    startingVC.navigationController?.pushViewController(gameVC, animated: true)
}

func moveToStartingVC(mainVC: UIViewController) {
    let storyboard = UIStoryboard(name: "ReadyandFinish", bundle: nil)

    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "StartingViewController") as? StartingViewController else {
        return
    }
    
    nextVC.selectedGameDelegate = mainVC as? SelectedGameDelegate
    nextVC.audioDelegate = mainVC as? AudioPlayerDelegate
    
    mainVC.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToGameResultVC(gameVC: UIViewController) {
    let storyboard = UIStoryboard(name: "ReadyandFinish", bundle: nil)

    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "GameResultViewController") as? GameResultViewController else { return }
    guard let homeVC = gameVC.navigationController?.viewControllers.first as? HomeViewController else {
        return }
    
    nextVC.gameDelegate = gameVC as? GameDelegate
    nextVC.selectedGameDelegate = homeVC as SelectedGameDelegate
    
    gameVC.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToGameRecordVC(startingVC: UIViewController) {
    let storyboard = UIStoryboard(name: "ReadyandFinish", bundle: nil)
    guard let gameRecordVC = storyboard.instantiateViewController(withIdentifier: "GameRecordViewController") as? GameRecordViewController else {
        return
    }

    gameRecordVC.gameRecordDelegate = startingVC as? GameRecordDelegate
    
    startingVC.navigationController?.pushViewController(gameRecordVC, animated: true)
}

func moveBackToHomeVC(vc: UIViewController) {
    vc.navigationController?.popToRootViewController(animated: true)
}

func moveBackToStartingVC(vc: UIViewController) {
    guard let startingVC = vc.navigationController?.viewControllers[1] else {
        return
    }
    vc.navigationController?.popToViewController(startingVC, animated: true)
}

