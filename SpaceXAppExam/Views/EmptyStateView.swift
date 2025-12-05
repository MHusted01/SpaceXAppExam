//
//  EmptyStateView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Empty state view with icon and messages
struct EmptyStateView: View {
    let iconName: String
    let title: String
    let message: String?
    let secondaryMessage: String?

    init(
        iconName: String,
        title: String,
        message: String? = nil,
        secondaryMessage: String? = nil
    ) {
        self.iconName = iconName
        self.title = title
        self.message = message
        self.secondaryMessage = secondaryMessage
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(title)
                .font(.headline)

            if let message = message {
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let secondaryMessage = secondaryMessage {
                Text(secondaryMessage)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding()
    }
}
