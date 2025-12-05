//
//  CapsuleModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Model for a SpaceX Dragon capsule with reuse statistics.
struct CapsuleModel: Codable, Hashable {
    let serial: String
    let type: String
    let status: String
    let reuseCount: Int
    let waterLandings: Int
    let landLandings: Int
    let lastUpdate: String?
}
