//
//  StatusBadgeView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Badge view for status indicators
struct StatusBadgeView: View {
    let text: String
    let color: Color
    let size: BadgeSize

    enum BadgeSize {
        case small
        case regular

        var font: Font {
            switch self {
            case .small: return .caption2
            case .regular: return .caption
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 6
            case .regular: return 8
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .small: return 2
            case .regular: return 4
            }
        }
    }

    init(_ text: String, color: Color = .blue, size: BadgeSize = .regular) {
        self.text = text
        self.color = color
        self.size = size
    }

    var body: some View {
        Text(text)
            .font(size.font)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(color)
            .clipShape(Capsule())
    }
}
