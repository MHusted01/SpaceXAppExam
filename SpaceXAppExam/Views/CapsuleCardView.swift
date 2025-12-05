//
//  CapsuleCardView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Card view for a single capsule with reuse statistics.
struct CapsuleCardView: View {
    let capsule: CapsuleModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(capsule.serial) – \(capsule.type)")
                .font(.headline)

            StatCardView(items: [
                StatModel(value: "\(capsule.reuseCount)", label: "Reuses"),
                StatModel(value: "\(capsule.waterLandings)", label: "Water"),
                StatModel(value: "\(capsule.landLandings)", label: "Land"),
                StatModel(
                    value: capsule.status.capitalized,
                    label: "Status",
                    color: capsule.status == "active" ? .green : .secondary
                ),
            ])

            if let lastUpdate = capsule.lastUpdate {
                Text(lastUpdate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
