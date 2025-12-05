//
//  StatItem.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 05/12/2025.
//

import SwiftUI

//  Data model for a single statistic item
struct StatModel {
    let value: String
    let label: String
    let color: Color

    init(value: String, label: String, color: Color = .primary) {
        self.value = value
        self.label = label
        self.color = color
    }
}
