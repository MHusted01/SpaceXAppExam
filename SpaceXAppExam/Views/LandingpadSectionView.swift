//
//  LandingpadSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying landing pad information with statistics.
struct LandingpadSectionView: View {
    let landingpad: LandingpadModel?
    
    var body: some View {
        if let landpad = landingpad {
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .top) {
                    Image("hospital-symbol-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text("Landingpad (\(landpad.type))")
                            .font(.title)
                            .bold()
                        
                        Text("\(landpad.fullName ?? landpad.name) – \(landpad.locality), \(landpad.region)")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                StatCardView(items: [
                    StatModel(value: "\(landpad.landingAttempts)", label: "Attempts"),
                    StatModel(value: "\(landpad.landingSuccesses)", label: "Successes"),
                    StatModel(
                        value: landpad.status.capitalized,
                        label: "Status",
                        color: landpad.status == "active" ? .green : .secondary
                    )
                ])
                .padding(.horizontal)
                
                if let wikipedia = landpad.wikipedia {
                    Link(destination: wikipedia) {
                        Label("Wikipedia", systemImage: "book.fill")
                    }
                    .buttonStyle(.bordered)
                    .padding(.leading)
                }
            }
        }
    }
}
