//
//  LaunchpadModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Model for a SpaceX launchpad with location and statistics.
// Used for both map annotations and detail views.
struct LaunchpadModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let fullName: String?
    let locality: String
    let region: String
    let latitude: Double
    let longitude: Double
    let launchAttempts: Int
    let launchSuccesses: Int
    let status: String
}
