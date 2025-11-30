//
//  Models.swift
//  CourtConnect
//
//  Created by {{partialupn}} on 11/25/25.
//

import Foundation
import UIKit

struct Sport {
    let id: String
    let name: String
    let icon: String
    let color: UIColor
}

struct JoinedPlayer: Codable {
    let name: String
    let joinedAt: Date
}

struct Post: Codable {
    let id: String
    let name: String
    let time: String
    let location: String
    let notes: String
    let sportId: String
    let createdAt: Date
    var joinedPlayers: [JoinedPlayer]
    
    init(id: String = UUID().uuidString, name: String, time: String, location: String, notes: String, sportId: String, createdAt: Date = Date(), joinedPlayers: [JoinedPlayer] = []) {
        self.id = id
        self.name = name
        self.time = time
        self.location = location
        self.notes = notes
        self.sportId = sportId
        self.createdAt = createdAt
        self.joinedPlayers = joinedPlayers
    }
}
