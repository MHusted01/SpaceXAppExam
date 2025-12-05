//
//  LaunchListView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import SwiftUI

// Main view displaying a list of all launches. filtering by favorites when authenticated
struct LaunchListView: View {
    @State var controller = LaunchListController()
    @Environment(AuthStateController.self) var authController
    @Environment(FavoritesController.self) var favoritesController
    @State private var showLoginSheet = false
    @State private var showFavoritesList = false
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                // Filter picker only shown when authenticated
                if authController.authenticationState == .authenticated {
                    Section {
                        Picker("Filter", selection: $showFavoritesList) {
                            Text("All launches").tag(false)
                            Text("Favorites").tag(true)
                        }
                        .pickerStyle(.segmented)
                    }
                }

                if controller.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading launches...")
                        Spacer()
                    }
                } else if let error = controller.errorMessage {
                    ErrorView(message: error) {
                        Task {
                            await controller.loadLaunches()
                        }
                    }
                } else {
                    let launchesToShow = controller.filteredLaunches(
                        showFavoritesOnly: showFavoritesList,
                        isAuthenticated: authController.authenticationState
                            == .authenticated,
                        favoriteIDs: favoritesController.favoriteIDs
                    )

                    if launchesToShow.isEmpty && showFavoritesList {
                        EmptyStateView(
                            iconName: "heart.slash",
                            title: "No favorites yet",
                            message:
                                "You haven't saved any favorite launches yet.",
                            secondaryMessage:
                                "Tap the heart icon on any launch to add it to favorites."
                        )
                    } else {
                        ForEach(launchesToShow) { launch in
                            NavigationLink(value: launch) {
                                LaunchRowView(launch: launch)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Launches")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        LaunchpadMapView()
                    } label: {
                        Image(systemName: "globe.europe.africa.fill")
                            .font(.title2)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    if authController.authenticationState == .authenticated {
                        Menu {
                            Text(authController.displayName)
                            Button("Log out") {
                                authController.signOut()
                                showFavoritesList = false
                            }
                        } label: {
                            Label("", systemImage: "person.crop.circle")
                                .font(.title2)
                        }
                    } else {
                        Button("Log in") {
                            showLoginSheet = true
                        }
                    }
                }
            }
            .sheet(isPresented: $showLoginSheet) {
                LoginView()
                    .environment(authController)
            }
            .task {
                await controller.loadLaunches()
            }
            .navigationDestination(for: LaunchModel.self) { launch in
                LaunchDetailView(launch: launch)
            }
        }
        .environment(controller)
    }
}

#Preview {
    LaunchListView()
        .environment(AuthStateController())
        .environment(FavoritesController())
}
