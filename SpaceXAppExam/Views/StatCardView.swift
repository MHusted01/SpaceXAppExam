//
//  StatCardView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Displays a horizontal row of statistics with dividers between items
struct StatCardView: View {
    let items: [StatModel]

    var body: some View {
        HStack(spacing: 16) {
            ForEach(items.indices, id: \.self) { index in
                if index > 0 {
                    Divider()
                        .frame(height: 30)
                }

                let item = items[index]

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
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
