//
//  RocketSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying rocket information, statistics and image.
struct RocketSectionView: View {
    let rocket: RocketModel?
    
    var body: some View {
        if let rocket = rocket {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Image("rocket-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text("Rocket")
                            .font(.title)
                            .bold()
                        
                        Text(rocket.name)
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                
                if let images = rocket.flickrImages, let firstImage = images.first {
                    ImageView(firstImage)
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                }
                
                if let description = rocket.description {
                    Text(description)
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                
                StatCardView(items: [
                    StatModel(value: "\(rocket.successRatePct)%", label: "Success rate"),
                    StatModel(value: "$\(rocket.costPerLaunch / 1_000_000)M", label: "Cost per launch"),
                    StatModel(
                        value: rocket.active ? "Active" : "Retired",
                        label: "Status",
                        color: rocket.active ? .green : .secondary
                    )
                ])
                .padding(.horizontal)
            }
        }
    }
}
