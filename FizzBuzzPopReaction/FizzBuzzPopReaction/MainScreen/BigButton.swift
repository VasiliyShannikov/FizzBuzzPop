//
//  SwiftUIView.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import SwiftUI

struct BigButton: View {
    @Binding var isRoundComplete: Bool
    @Binding var isGameComplete: Bool
    @Binding var countDownNr: Int
    @Binding var remainingAnswers: Int

    var onButtonPressed: () -> Void

    var body: some View {
        Button {
            onButtonPressed()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(isRoundComplete ?.yellow : Color(red: 0.771, green: 0.728, blue: 0.568))
                Text(getBigButtonText())
                    .foregroundColor(.black)
            }

        }
    }

    private func getBigButtonText() -> String {
        var res = ""
        if countDownNr > 0 {
            res = "Numbers are loading..."
        } else if remainingAnswers != 0 {
           var num = ""
            switch remainingAnswers {
            case 1:
                num = "One"
            case 2:
                num = "Two"
            case 3:
                num = "Three"
            case 4:
                num = "Four"
            case 5:
                num = "Five"
            case 6:
                num = "Six"
            case 7:
                num = "Seven"
            case 8:
                num = "Eight"
            case 9:
                num = "Nine"
            case 10:
                num = "Ten"
            default:
                num = ""
            }

            res = num + " more left"
        } else if isRoundComplete{
            res = "Next round"
        }

        if isGameComplete {
            res = "Play again"
        }

        return res
    }
}

#Preview {
    BigButton(isRoundComplete: .constant(false),
              isGameComplete: .constant(false),
              countDownNr: .constant(0),
              remainingAnswers: .constant(0),
              onButtonPressed: {})
}
