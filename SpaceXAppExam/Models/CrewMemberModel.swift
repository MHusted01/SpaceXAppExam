//
//  CrewMemberModel.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Model for a SpaceX crew member / astronaut.
struct CrewMemberModel: Codable, Hashable {
    let name: String
    let agency: String?
    let image: URL?
    let wikipedia: URL?
    let status: String?
}
