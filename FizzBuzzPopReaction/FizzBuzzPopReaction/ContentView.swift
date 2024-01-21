import SwiftUI

struct ContentView: View {
    @State var isGreating = UserDefaults.standard.bool(forKey: "isGreating")
    @ObservedObject var data: ProgrammData
    var body: some View {
        if !isGreating {
            Welcome( data: data, isGreating: $isGreating)
                .onAppear {
                    UserDefaults.standard.set(3, forKey: "rounds")
                    UserDefaults.standard.set(8, forKey: "numbers")
                }
        } else {
            MainScreen(data: data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: ProgrammData())
    }
}
