//
//  CapsuleSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying capsule information with statistics.
struct CapsuleSectionView: View {
    let capsules: [CapsuleModel]
    
    var body: some View {
        if !capsules.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image("parachute-box-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text("Capsules")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                }
                .padding(.leading)
                
                ForEach(capsules, id: \.serial) { capsule in
                    CapsuleCardView(capsule: capsule)
                        .padding(.horizontal)
                }
            }
        }
    }
}
