//
//  RefreshButton.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import SwiftUI

struct RefreshButton: View {
    var onButtonPressed: () -> Void
    var body: some View {
        Button {
            onButtonPressed()
        } label: {
            ZStack{
                Circle()
                    .fill(Color(red: 0.204, green: 0.204, blue: 0.212))
                    .frame(width: 40, height: 40, alignment: .center)
                Image(systemName: "arrow.clockwise").foregroundColor(.white)
            }
        }
    }
}

#Preview {
    RefreshButton(onButtonPressed: {})
}
