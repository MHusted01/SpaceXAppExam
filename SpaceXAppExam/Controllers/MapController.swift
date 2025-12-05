//
//  MapController.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 03/12/2025.
//

import Foundation
import Observation

// Controller for the launchpad map view.
// Handles loading of all launchpads for map annotations.
@Observable
class MapController {
    private let service = SpaceXServices()

    var launchpads: [LaunchpadModel] = []
    var isLoading = false
    var error: String? = nil

    /// Loads all launchpads from the API.
    func loadLaunchpads() async {
        isLoading = true
        error = nil

        do {
            let fetched = try await service.getAllLaunchpads()
            launchpads = fetched
        } catch let apiError as APIError {
            switch apiError {
            case .badResponse:
                self.error = "Could not connect to server"
            case .badStatusCode(let code):
                self.error = "Server error: (\(code))"
            case .decodingFailed:
                self.error = "Error processing launchpad data"
            }
        } catch {
            self.error = "Unknown error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
