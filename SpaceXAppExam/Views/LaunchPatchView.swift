//
//  LaunchPatchView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

// View for displaying a launch patch with fallback image.
struct LaunchPatchView: View {
    let patchURL: URL?
    let size: CGFloat
    
    init(url: URL?, size: CGFloat = 60) {
        self.patchURL = url
        self.size = size
    }
    
    var body: some View {
        if let url = patchURL {
            ImageView(url)
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            Image("ElonFace")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(.secondary)
        }
    }
}
