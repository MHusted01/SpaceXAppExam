//
//  LaunchDetailView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import SwiftUI

// Detail view for a single launch showing all related information.
struct LaunchDetailView: View {
    let launch: LaunchModel
    @State private var controller = LaunchDetailController()
    @Environment(AuthStateController.self) var authController
    @Environment(FavoritesController.self) var favoritesController

    var body: some View {
        Group {
            if controller.isLoadingDetails {
                VStack {
                    Spacer()
                    ProgressView("Loading details...")
                    Spacer()
                }
            } else if let error = controller.detailError {
                ErrorView(message: error) {
                    Task {
                        await controller.loadDetails(for: launch)
                    }
                }
            } else {
                ScrollView {
                    VStack(alignment: .center, spacing: 32) {
                        LaunchHeaderView(launch: launch)
                        RocketSectionView(rocket: controller.rocket)
                        LaunchpadSectionView(launchpad: controller.launchpad)
                        LandingpadSectionView(landingpad: controller.landingpad)
                        CrewSectionView(crewMembers: controller.crewMembers)
                        PayloadSectionView(payloads: controller.payloads)
                        CapsuleSectionView(capsules: controller.capsules)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Launch details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Favorite button only shown when authenticated
                if authController.authenticationState == .authenticated {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            favoritesController.toggleFavorite(for: launch)
                        }
                    } label: {
                        Image(
                            systemName: favoritesController.isFavorite(launch)
                                ? "heart.fill" : "heart"
                        )
                        .foregroundStyle(
                            favoritesController.isFavorite(launch)
                                ? .red : .primary
                        )
                    }
                }
            }
        }
        .task {
            await controller.loadDetails(for: launch)
        }
    }
}
