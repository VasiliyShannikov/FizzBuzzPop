//
//  NameLine.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

import SwiftUI

struct NameLine: View {
    @Binding var name: String
    @Binding var isNameConfirm: Bool

    var body: some View {
        HStack {
            Text("What is your name ?")
                .foregroundColor(.white)
            Spacer()

            TextField("", text: $name)
                .disableAutocorrection(true)
                .frame(width: 100, alignment: .center)
                .foregroundColor(.white)
                .onSubmit {
                    isNameConfirm = true
                }
            
            Button {
                name = ""
            } label: {
                Image(systemName: "xmark.circle")
            }
        }
    }
}

#Preview {
    NameLine(name: .constant(""), isNameConfirm: .constant(true))
}
