import SwiftUI

struct LeaderBoard: View {
    init(data1: ProgrammData) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UITableView.appearance().backgroundColor = .black
        self.data = data1
    }
    @ObservedObject var data: ProgrammData
    var gameScores = Storage.gameHistory.keys.sorted{ $0 > $1}
    var body: some View {
        VStack{
            List{
                ForEach(0..<data.scores.count) { i in
                    HStack{
                        Text("\(data.names[i])")
                        Spacer()
                        Text("\(data.scores[i])")
                    }   .listRowBackground(Color.black)
                    
                }
            }
            Spacer()
        }
        .background(.black)
        .foregroundColor(.white)
        .navigationTitle("Leaderboard")
        .accentColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard(data1: ProgrammData())
    }
}
