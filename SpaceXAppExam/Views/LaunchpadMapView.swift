//
//  LaunchpadMapView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 03/12/2025.
//

import MapKit
import SwiftUI

// Map view showing all launchpads with annotations. Tapping a launchpad opens a sheet
struct LaunchpadMapView: View {
    @State private var controller = MapController()
    @Environment(LaunchListController.self) var launchController
    @Environment(AuthStateController.self) var authController
    @Environment(FavoritesController.self) var favoritesController

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120)
        )
    )

    @State private var selectedPad: LaunchpadModel? = nil

    var body: some View {
        Group {
            if controller.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading launchpads...")
                    Spacer()
                }
            } else if let error = controller.error {
                ErrorView(message: error) {
                    Task { await controller.loadLaunchpads() }
                }
            } else {
                Map(position: $cameraPosition) {
                    ForEach(controller.launchpads) { pad in
                        let coord = CLLocationCoordinate2D(
                            latitude: pad.latitude,
                            longitude: pad.longitude
                        )

                        Annotation(pad.name, coordinate: coord) {
                            LaunchpadAnnotationView(
                                pad: pad,
                                isSelected: selectedPad?.id == pad.id
                            ) {
                                // Animate camera to selected launchpad
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    selectedPad = pad
                                    cameraPosition = .region(
                                        MKCoordinateRegion(
                                            center: coord,
                                            span: MKCoordinateSpan(
                                                latitudeDelta: 0.1,
                                                longitudeDelta: 0.1
                                            )
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
                .mapStyle(.imagery(elevation: .realistic))
            }
        }
        .task {
            await controller.loadLaunchpads()
        }
        .navigationTitle("Launchpads")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedPad) { pad in
            LaunchesFromPadSheet(launchpad: pad)
                .environment(launchController)
                .environment(authController)
                .environment(favoritesController)
        }
    }
}

#Preview {
    NavigationStack {
        LaunchpadMapView()
            .environment(LaunchListController())
            .environment(AuthStateController())
            .environment(FavoritesController())
    }
}
