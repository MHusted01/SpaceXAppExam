//
//  LaunchHeaderView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Header view for launch detail showing patch, name, date, status and external links.
struct LaunchHeaderView: View {
    let launch: LaunchModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            LaunchPatchView(url: launch.links.patch.large, size: 120)

            HStack(spacing: 8) {
                Text("#\(launch.flightNumber)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                if launch.upcoming {
                    StatusBadgeView("UPCOMING")
                }
            }

            Text(launch.name)
                .font(.largeTitle)
                .bold()

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
                    Text("Status unknown")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            if let details = launch.details {
                Text(details)
                    .padding()
            }

            // External links
            if launch.links.webcast != nil || launch.links.wikipedia != nil || launch.links.article != nil {
                HStack(alignment: .center, spacing: 16) {
                    if let webcast = launch.links.webcast {
                        Link(destination: webcast) {
                            Label("Watch", systemImage: "play.circle.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    if let wikipedia = launch.links.wikipedia {
                        Link(destination: wikipedia) {
                            Label("Wiki", systemImage: "book.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    if let article = launch.links.article {
                        Link(destination: article) {
                            Label("Article", systemImage: "newspaper.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}
