//
//  GameReadyData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit
import FirebaseFirestore

struct GameData {
    private let startingResource: [(String, String, UIImage)] = [
        ("탭탭!", "화면에 있는 치즈 버튼을\n10초동안\n마구마구 누르세요!.", #imageLiteral(resourceName: "TapTapGame_start_cat")),
        ("쉐킷쉐킷!", "휴대폰을 마음껏 흔들어주세요!\n너무 열심히 흔든 나머지\n휴대폰이 날아가지 않도록 주의하세요.", #imageLiteral(resourceName: "ShakeItGame_start_cat")),
        ("부비부비", "화면의 생선을 누른 상태로\n좌우로 마구마구 비벼주세요!\n고양이를 생선으로 재미있게 놀아주세요!", #imageLiteral(resourceName: "BBGame_start_cat")),
        ("더하기를 하자!", "최대한 빠르게\n덧셈에 대한 정답을\n입력해주세요!", #imageLiteral(resourceName: "PlusGame_start_cat")),
        ("곱하기를 하자!", "최대한 빠르게\n곱셈에 대한 정답을\n입력해주세요!", #imageLiteral(resourceName: "MultiplyeGame_start_cat"))
    ]
    private let gameStoryBoardAndViewControllerList: [(String, String)] = [
        ("TabTabGame", "TabTabGameViewController"),
        ("ShakeItGame", "ShakeItGameViewController"),
        ("BBGame", "BBGameViewController"),
        ("PlusGame", "PlusGameViewController"),
        ("MultiplyGame", "MultiplyGameViewController")
    ]
    private let gameTitles: [String] = ["TabTabGame", "ShakeItGame", "BBGame", "PlusGame", "MultiplyGame"]
    private let gameStartBtnImages: [UIImage] = [#imageLiteral(resourceName: "GameStartBtn2"), #imageLiteral(resourceName: "GameStartBtn")]
    
    func gameStartingResource() -> [(String, String, UIImage)] {
        return startingResource
    }
    
    func gameTitleList() -> [String] {
        return gameTitles
    }
    
    func gameStartBtnImageArray() -> [UIImage] {
        return gameStartBtnImages
    }
    
    func gameStoryBoardAndViewControllers() -> [(String, String)] {
        return gameStoryBoardAndViewControllerList
    }
}

struct FireStore {
    private let db = Firestore.firestore()
    private let uuid = UIDevice.current.identifierForVendor?.uuidString
    
    private func convertDateToString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "\(dateFormat)"
        return formatter.string(from: Date())
    }
    
    private func makeData(score: Int) -> [String: Any] {
        let documentID = convertDateToString(dateFormat: "yyyyMMddHHmmss")
        let current_date_string = convertDateToString(dateFormat: "MM-dd HH:mm:ss")
        
        return [
            "documentID": documentID,
            "gameTime": current_date_string,
            "gameScore": score
        ]
    }
    
    private func recordHighScore(collectionID: String, gameName: String, score: Int) async {
        let ref = db.collection("\(collectionID)").document("\(gameName)")
        
        do {
            let querySnapshot = try await ref.getDocument()
            if querySnapshot.exists { // 최고 기록 데이터가 이미 존재한다면
                if let data = querySnapshot.data(), let highScore = data["highScore"] {
                    if (score > highScore as! Int) {
                        try await ref.updateData(["highScore": score])
                    }
                } else {
                    print("Error getting High Score documents")
                }
            } else { // 존재하지 않는다면
                try await ref.setData(["highScore": score])
            }
        } catch {
            print("Error getting High Score document: \(error)")
        }
    }
    
    func recordScore(score: Int, gameName: String) async {
        guard let collectionID = uuid else { return }
        let ref = db.collection("\(collectionID)").document("\(gameName)").collection("\(gameName)")
        let data: [String: Any] = makeData(score: score)
        let documentID = convertDateToString(dateFormat: "yyyyMMddHHmmss")
        
        do {
            try await ref.document("\(documentID)").setData(data)
            await recordHighScore(collectionID: collectionID, gameName: gameName, score: score)
        } catch {
            print("Error adding Game Record Document: \(error)")
        }
    }
    
    func loadGameRecord(gameName: String) async -> [[String: Any]] {
        guard let collectionID = uuid else { return [] }
        let ref = db.collection("\(collectionID)").document("\(gameName)").collection("\(gameName)")
        let queryData = ref.order(by: "documentID", descending: true).limit(to: 20)
        var gameRecord: [[String: Any]] = []

        do {
            let querySnapshot = try await queryData.getDocuments()
            for document in querySnapshot.documents {
                let gameScoreAndTime: [String: Any] = [
                    "gameScore": document.data()["gameScore"]!,
                    "gameTime": document.data()["gameTime"]!
                ]
                gameRecord.append(gameScoreAndTime)
            }
        } catch {
            print("Error getting Game Record documents: \(error)")
        }
        
        return gameRecord
    }
    
    func loadHighScore(gameName: String) async -> Int {
        guard let collectionID = uuid else { return -1 }
        let ref = db.collection("\(collectionID)").document("\(gameName)")
        var highScore: Int = -1
        
        do {
            let querySnapshot = try await ref.getDocument()
            if let data = querySnapshot.data(), let score = data["highScore"] {
                highScore = score as! Int
            }
        } catch {
            print("Error getting Game High Score documents: \(error)")
        }
        
        return highScore
    }
}
