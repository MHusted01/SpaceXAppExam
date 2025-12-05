//
//  LaunchDetailController.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import Foundation
import Observation

// Controller for the launch detail view.
// Loads all related data for a specific launch.
@Observable
class LaunchDetailController {
    private let service = SpaceXServices()
    
    var isLoadingDetails = false
    var detailError: String?
    var selectedLaunch: LaunchModel?
    
    // Related data for the selected launch
    var rocket: RocketModel?
    var launchpad: LaunchpadModel?
    var landingpad: LandingpadModel?
    var capsules: [CapsuleModel] = []
    var crewMembers: [CrewMemberModel] = []
    var payloads: [PayloadModel] = []

    /// Loads all related data for a launch (rocket, launchpad,  landingpad,  capsules, crew and payload ).
    /// - Parameter launch: The launch to load details for.
    func loadDetails(for launch: LaunchModel) async {
        isLoadingDetails = true
        detailError = nil
        selectedLaunch = launch

        // Reset all data
        rocket = nil
        capsules = []
        crewMembers = []
        payloads = []
        launchpad = nil
        landingpad = nil

        do {
            // Load rocket
            let rocketModel = try await service.getRocket(id: launch.rocket)
            self.rocket = rocketModel

            // Load launchpad if available
            if let padId = launch.launchpad {
                let pad = try await service.getLaunchpad(id: padId)
                self.launchpad = pad
            }

            // Load landing pad from first core with landpad
            if let landpadId = launch.cores.first(where: { $0.landpad != nil })?.landpad {
                let landpad = try await service.getLandingpad(id: landpadId)
                self.landingpad = landpad
            }

            // Load all capsules
            for capId in launch.capsules {
                let cap = try await service.getCapsule(id: capId)
                self.capsules.append(cap)
            }

            // Load all crew members
            for crew in launch.crew {
                let profile = try await service.getCrewMember(id: crew.crew)
                self.crewMembers.append(profile)
            }

            // Load all payloads
            for payloadId in launch.payloads {
                let payload = try await service.getPayload(id: payloadId)
                self.payloads.append(payload)
            }
        } catch let error as APIError {
            switch error {
            case .badResponse:
                detailError = "Bad response when fetching data"
            case .badStatusCode(let code):
                detailError = "Server error: \(code)"
            case .decodingFailed:
                detailError = "Failed to decode"
            }
        } catch {
            detailError = "Unexpected error \(error.localizedDescription)"
        }

        isLoadingDetails = false
    }
}
