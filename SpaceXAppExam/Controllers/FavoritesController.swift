//
//  FavoritesController.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import Foundation
import Observation

// Controller for managing favorite launches.
// Provides interface between views and FavoritesManager persistence.
@Observable
class FavoritesController {
    private let favoritesManager = FavoritesManager.shared
    var favoriteIDs: Set<String> = []

    init() {
        let saved = favoritesManager.load()
        self.favoriteIDs = Set(saved)
    }

    /// Checks if a launch is in favorites.
    /// - Parameter launch: The launch to check.
    /// - Returns: True if the launch is a favorite.
    func isFavorite(_ launch: LaunchModel) -> Bool {
        favoriteIDs.contains(launch.id)
    }

    /// Toggles favorite status for a launch and persists the change.
    /// - Parameter launch: The launch to toggle.
    func toggleFavorite(for launch: LaunchModel) {
        if favoriteIDs.contains(launch.id) {
            favoriteIDs.remove(launch.id)
        } else {
            favoriteIDs.insert(launch.id)
        }
        favoritesManager.save(Array(favoriteIDs))
    }
}
