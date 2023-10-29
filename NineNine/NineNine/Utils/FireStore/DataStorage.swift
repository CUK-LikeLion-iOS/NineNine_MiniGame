//
//  DataStorage.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/07/09.
//

import UIKit
import FirebaseFirestore

struct DataStorage {
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
    
    // DB가 아닌 로컬 스토리지에 저장
    private func recordHighScore(gameName: String, score: Int) {
        let highScore = UserDefaults.standard.integer(forKey: gameName)
        
        if (score > highScore) {
            UserDefaults.standard.set(score, forKey: gameName)
        }
    }
    
    func recordScore(score: Int, gameName: String) async {
        guard let collectionID = uuid else { return }
        let ref = db.collection("\(collectionID)").document("\(gameName)").collection("\(gameName)")
        let data: [String: Any] = makeData(score: score)
        let documentID = convertDateToString(dateFormat: "yyyyMMddHHmmss")
        
        do {
            try await ref.document("\(documentID)").setData(data)
            recordHighScore(gameName: gameName, score: score)
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
    
    func loadHighScore(gameName: String) -> Int {
        return UserDefaults.standard.integer(forKey: gameName)
    }
}
