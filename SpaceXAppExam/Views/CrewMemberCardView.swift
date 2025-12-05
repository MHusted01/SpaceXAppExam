//
//  CrewMemberCardView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Card view for a single crew member with photo and link
struct CrewMemberCardView: View {
    let member: CrewMemberModel

    var body: some View {
        VStack(spacing: 8) {
            if let imageUrl = member.image {
                ImageView(imageUrl)
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundStyle(.secondary)
                    )
            }

            Text(member.name)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)

            if let agency = member.agency {
                Text(agency)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            if let wikipedia = member.wikipedia {
                Link(destination: wikipedia) {
                    Image(systemName: "link.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
        }
        .frame(width: 100)
    }
}
