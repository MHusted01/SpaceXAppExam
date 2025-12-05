//
//  PayloadModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Model for a launch payload (satellite, cargo, etc).
struct PayloadModel: Codable, Hashable {
    let name: String?
    let type: String?
}
