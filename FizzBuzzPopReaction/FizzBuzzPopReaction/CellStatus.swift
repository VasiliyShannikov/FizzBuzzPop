//
//  CellStatus.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import Foundation
import SwiftUI

enum CellStatus {
    case neutral
    case win
    case lose

    var color: Color {
        switch self {
        case .neutral:
            return Color(red: 0.125, green: 0.125, blue: 0.125)
        case .win:
            return Color(red: 0.925, green: 0.894, blue: 0.779)
        case .lose:
            return Color(red: 0.843, green: 0, blue: 0.082)
        }
    }
}
