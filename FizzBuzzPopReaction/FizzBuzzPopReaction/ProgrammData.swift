//
//  ProgrammData.swift
//  FizzBuzzPopReaction
//
//  Created by Vasiliy Shannikov on 04.01.2022.
//

import SwiftUI

class ProgrammData: ObservableObject {
    @Published var scores = [Int]()
    @Published var names = [String]()
}

enum Storage {
    @AppDataStorage(key: "historyArr", defaultValue: [String: Int]())
    static var gameHistory
}

@propertyWrapper
struct AppDataStorage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }

        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
