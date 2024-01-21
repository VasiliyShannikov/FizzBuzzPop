import SwiftUI

@main
struct FizzBuzzPopReactionApp: App {
    @StateObject var data = ProgrammData()
    
    var body: some Scene {
        WindowGroup {
            ContentView( data: ProgrammData())
        }
    }
}
