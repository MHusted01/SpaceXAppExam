//
//  LaunchListController.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation
import Observation

// Controller for the launch list view. Handles loading and filtering of launches
@Observable
class LaunchListController {
    var launches: [LaunchModel] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let service = SpaceXServices()

    // Fetches all launches from the API and sorts by date descending
    func loadLaunches() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetched = try await service.getLaunches()
            let sorted = fetched.sorted { $0.dateUtc > $1.dateUtc }
            self.launches = sorted
        } catch let apiError as APIError {
            switch apiError {
            case .badResponse:
                self.errorMessage = "Could not connect to SpaceX API"
            case .badStatusCode(let code):
                self.errorMessage = "Server error: (\(code))"
            case .decodingFailed:
                self.errorMessage = "Failed to process server data"
            }
        } catch {
            self.errorMessage = "Unknown error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    /// Filters launches based on favorites and authentication status
    /// - Parameters:
    ///     showFavoritesOnly: Bool
    ///     isAuthenticated: Bool
    ///     favoriteID: Set<String>
    /// - Returns: Filtered array of launches or lauches
    func filteredLaunches(
        showFavoritesOnly: Bool,
        isAuthenticated: Bool,
        favoriteIDs: Set<String>
    ) -> [LaunchModel] {
        guard isAuthenticated else {
            return launches
        }

        if showFavoritesOnly {
            return launches.filter { favoriteIDs.contains($0.id) }
        } else {
            return launches
        }
    }
}
