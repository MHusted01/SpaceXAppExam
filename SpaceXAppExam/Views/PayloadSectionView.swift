//
//  PayloadSectionView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Section view displaying payload information.
struct PayloadSectionView: View {
    let payloads: [PayloadModel]
    
    var body: some View {
        if !payloads.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image("satellite-solid")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text("Payloads")
                            .font(.title)
                            .bold()
                        
                        ForEach(payloads, id: \.name) { payload in
                            let name = payload.name ?? "Unknown"
                            let type = payload.type ?? "Unknown"
                            Text("\(name) – \(type)")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                }
                .padding(.leading)
            }
        }
    }
}
