//
//  LaunchpadSheetHeaderView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Header view for the launchpad sheet displaying name, location and statistics
struct LaunchpadSheetHeaderView: View {
    let launchpad: LaunchpadModel

    var body: some View {
        VStack(spacing: 12) {
            Text(launchpad.fullName ?? launchpad.name)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("\(launchpad.locality), \(launchpad.region)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            StatCardView(items: [
                StatModel(
                    value: "\(launchpad.launchAttempts)",
                    label: "Attempts"
                ),
                StatModel(
                    value: "\(launchpad.launchSuccesses)",
                    label: "Successes",
                    color: .green
                ),
                StatModel(
                    value: launchpad.status.capitalized,
                    label: "Status",
                    color: launchpad.status == "active" ? .green : .secondary
                ),
            ])
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}
