//
//  RocketModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Model for a rocket with specifications and statistics
struct RocketModel: Codable, Hashable {
    let name: String
    let description: String?
    let flickrImages: [URL]?
    let active: Bool
    let successRatePct: Int
    let costPerLaunch: Int
    let firstFlight: String?
}
