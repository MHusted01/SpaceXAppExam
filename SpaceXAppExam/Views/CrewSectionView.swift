//
//  CrewSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying crew members in a horizontal scroll.
struct CrewSectionView: View {
    let crewMembers: [CrewMemberModel]
    
    var body: some View {
        if !crewMembers.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Image("user-astronaut-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                        .padding(.bottom)
                    
                    
                    
                    VStack(alignment: .center) {
                        Text("Crew")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                }
                .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(crewMembers, id: \.name) { member in
                            CrewMemberCardView(member: member)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
