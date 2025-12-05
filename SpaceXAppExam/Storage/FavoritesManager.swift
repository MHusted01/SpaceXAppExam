//
//  FavoritesManager.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 02/12/2025.
//

import Foundation

// Handles persistence of favorite launches ID using UserDefaults.
class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}

    private let key = "favoriteLaunchIDs"

    /// Loads the launch IDs from UserDefaults. Returns empty array if none exist.
    func load() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    /// Saves the given launch id list to UserDefaults.
    func save(_ ids: [String]) {
        UserDefaults.standard.set(ids, forKey: key)
    }
}
