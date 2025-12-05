//
//  LaunchpadSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying launchpad information and statistics.
struct LaunchpadSectionView: View {
    let launchpad: LaunchpadModel?
    
    var body: some View {
        if let pad = launchpad {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image("space-shuttle-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text("Launchpad")
                            .font(.title)
                            .bold()
                        
                        Text("\(pad.name) – \(pad.locality), \(pad.region)")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                StatCardView(items: [
                    StatModel(value: "\(pad.launchAttempts)", label: "Attempts"),
                    StatModel(value: "\(pad.launchSuccesses)", label: "Successes"),
                    StatModel(
                        value: pad.status.capitalized,
                        label: "Status",
                        color: pad.status == "active" ? .green : .secondary
                    )
                ])
                .padding(.horizontal)
            }
        }
    }
}
