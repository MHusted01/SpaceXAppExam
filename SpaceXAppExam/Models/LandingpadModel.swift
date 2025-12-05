//
//  LandingpadModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 02/12/2025.
//

import Foundation

// Model for a landing pad
struct LandingpadModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let fullName: String?
    let locality: String
    let region: String
    let latitude: Double
    let longitude: Double
    let type: String
    let status: String
    let landingAttempts: Int
    let landingSuccesses: Int
    let wikipedia: URL?
    let details: String?
}
