//
//  Timer.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import SwiftUI

struct GameTimer: View {
    @Binding var elepsedTime: Int

    var body: some View {
        Text("\((elepsedTime/3600),specifier:"%02d"):\((elepsedTime/60),specifier:"%02d"):\((elepsedTime % 60),specifier:"%02d" )")
            .font(.system(size: 24, weight: .medium, design: .default))
            .foregroundColor(.white)
    }
}

#Preview {
    GameTimer(elepsedTime: .constant(0))
}
