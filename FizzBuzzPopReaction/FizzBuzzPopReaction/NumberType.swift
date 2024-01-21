//
//  NumberType.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 21.01.2024.
//

enum NumberType: Int {
    case fizz = 0
    case buzz
    case pop
    case fizzBuzz
    case buzzPop
    case fizzPop
    case fizzBuzzPop

    var title: String {
        switch self {
        case .fizz:
            return "Fizz"
        case .buzz:
            return "Buzz"
        case .pop:
            return "Pop"
        case .fizzBuzz:
            return "FizzBuzz"
        case .buzzPop:
            return "BuzzPop"
        case .fizzPop:
            return "FizzPop"
        case .fizzBuzzPop:
            return "FizzBuzzPop"
        }
    }

    func isCorrect(_ number: Int) -> Bool {
        switch self {
        case .fizz:
            return number % 3 == 0
        case .buzz:
            return number % 5 == 0
        case .pop:
            return number % 7 == 0
        case .fizzBuzz:
            return number % 3 == 0 && number % 5 == 0
        case .buzzPop:
            return number % 5 == 0 && number % 7 == 0
        case .fizzPop:
            return number % 3 == 0 && number % 7 == 0
        case .fizzBuzzPop:
            return number % 3 == 0 && number % 5 == 0 && number % 7 == 0
        }
    }
}
