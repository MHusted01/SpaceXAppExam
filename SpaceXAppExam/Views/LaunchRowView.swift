//
//  LaunchRowView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import SwiftUI

// Row view for displaying a launch in a list.
struct LaunchRowView: View {
    let launch: LaunchModel

    var body: some View {
        HStack {
            LaunchPatchView(url: launch.links.patch.small, size: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("#\(launch.flightNumber)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    
                    if launch.upcoming {
                        StatusBadgeView("UPCOMING", size: .small)
                    }
                }
                
                Text(launch.name)
                    .font(.headline)
                
                Text(launch.customFormattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Only show success/failed for past launches
                if !launch.upcoming {
                    if let success = launch.success {
                        Text(success ? "Success" : "Failed")
                            .font(.subheadline)
                            .foregroundStyle(success ? .green : .red)
                    } else {
                        Text("Status Unknown")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
