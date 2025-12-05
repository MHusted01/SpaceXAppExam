//
//  StatCardView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Displays a horizontal row of statistics with dividers between items.
struct StatCardView: View {
    let items: [StatModel]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if index > 0 {
                    Divider()
                        .frame(height: 30)
                }
                
                VStack {
                    Text(item.value)
                        .font(.headline)
                        .foregroundStyle(item.color)
                    Text(item.label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
