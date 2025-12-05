//
//  ErrorView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// Reusable error view with retry button.
struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(message)
                .foregroundStyle(.red)
            Button("Try again") {
                retryAction()
            }
            Spacer()
        }
    }
}
