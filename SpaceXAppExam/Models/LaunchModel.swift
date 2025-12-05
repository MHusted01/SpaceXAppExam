//
//  LaunchModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Main model for a launch
// Codable for JSON parsing, Identifiable for lists and Hashable for NavigationPath.
struct LaunchModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let flightNumber: Int
    let dateUtc: Date
    let details: String?
    let rocket: String?
    let capsules: [String]
    let crew: [LaunchCrew]
    let launchpad: String?
    let cores: [Core]
    let payloads: [String]
    let links: LaunchLinks
    let success: Bool?
    let upcoming: Bool
}

// Crew member within a launch
struct LaunchCrew: Codable, Hashable {
    let crew: String
    let role: String?
}

// Links associated with a launch
struct LaunchLinks: Codable, Hashable {
    let patch: LaunchPatch
    let webcast: URL?
    let wikipedia: URL?
    let article: URL?
}

// Mission patch image URLs
struct LaunchPatch: Codable, Hashable {
    let small: URL?
    let large: URL?
}

// Rocket core information includes landing pad
struct Core: Codable, Hashable {
    let landpad: String?
}

extension LaunchModel {
    // Formats the launch date for display
    var customFormattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "d. MMM yyyy 'at' HH:mm"
        return formatter.string(from: dateUtc)
    }
}
