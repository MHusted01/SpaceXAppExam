//
//  LaunchesFromPadSheet.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 03/12/2025.
//

import SwiftUI

// Sheet view displaying all launches from a specific launchpad
struct LaunchesFromPadSheet: View {
    let launchpad: LaunchpadModel
    @Environment(LaunchListController.self) var launchController
    @Environment(AuthStateController.self) var authController
    @Environment(FavoritesController.self) var favoritesController
    @Environment(\.dismiss) private var dismiss

    // Filters launches to only show those from this launchpad
    var launchesForPad: [LaunchModel] {
        launchController.launches.filter { $0.launchpad == launchpad.id }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                LaunchpadSheetHeaderView(launchpad: launchpad)

                if launchesForPad.isEmpty {
                    EmptyStateView(
                        iconName: "airplane.departure",
                        title: "No launches from this launchpad",
                        message:
                            "This site may be retired or only used for other operations."
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(launchesForPad) { launch in
                        NavigationLink {
                            LaunchDetailView(launch: launch)
                        } label: {
                            LaunchRowView(launch: launch)
                        }
                    }
                }
            }
            .navigationTitle("Launches")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .task {
            if launchController.launches.isEmpty {
                await launchController.loadLaunches()
            }
        }
    }
}
