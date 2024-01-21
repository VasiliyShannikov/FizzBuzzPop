//
//  GameCell.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import SwiftUI

struct GameCell: View {
    @State var cellStatus: CellStatus = .neutral
    @Binding var isWrong: Bool
    @Binding var remaining: Int
    @Binding var order: NumberType
    @Binding var rounds: Int
    @Binding var name: String
    @Binding var score: Int
    @Binding var isRoundComplete:Bool
    @Binding var isGameComplete: Bool
    @Binding var scores :[Int]

    var number: Int = Int.random(in: 0..<100)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(cellStatus.color)
                .frame( height: 38, alignment: .center)
            Text("\(number)")
                .foregroundColor(cellStatus == .win ? .black : .white)
                }
        .onTapGesture {
            if order.isCorrect(number) {
                remaining -= 1
                cellStatus = .win
                isWrong = false
            } else {
                cellStatus = .lose
                isWrong = true
                score -= 1
            }

            isRoundComplete = remaining == 0

            if isRoundComplete {
                rounds -= 1
            }

            isGameComplete = rounds == 0
            if isGameComplete {
                Storage.gameHistory[name] = score
            }
        }
    }
}
