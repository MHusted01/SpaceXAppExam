//
//  LaunchpadAnnotationView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Map annotation view for a launchpad with selection state
struct LaunchpadAnnotationView: View {
    let pad: LaunchpadModel
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 2) {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                    .scaleEffect(isSelected ? 1.4 : 1.0)
                    .shadow(radius: isSelected ? 6 : 0)

                // Show name label when selected
                if isSelected {
                    Text(pad.name)
                        .font(.caption2)
                        .padding(2)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            .animation(
                .spring(response: 0.3, dampingFraction: 0.7),
                value: isSelected
            )
        }
    }
}
