import SwiftUI

struct MainScreen: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @ObservedObject var data: ProgrammData

    @State var fizzBuzzPopChoice: NumberType = .fizz
    @State var countDownNr = 3
    @State var fizz = 3
    @State var buzz = 5
    @State var pop = 7
    @State var roundTitle = 1
    @State var remainingAnswers = 0
    @State var toSettings = false
    @State var toLeaderBoard = false
    @State var isStarted = false
    @State var isWrongAnswer = false
    @State var isRoundComplete = false
    @State var isGameComplete = false
    @State var fizzName = "Fizz"
    @State var buzzName = "Buzz"
    @State var popName = "Pop"
    @State var names = [String]()
    @State var scores = [Int]()
    @State var cellStatus: CellStatus = .neutral
    @State var numbersAppStorage = getDefaultValue(storeData: UserDefaults.standard.integer(forKey: "numbers"), defaultData: 8)

    @State var roundsAppStorage = getDefaultValue(storeData: UserDefaults.standard.integer(forKey: "rounds"), defaultData: 3)
    @State var rounds = UserDefaults.standard.integer(forKey: "rounds")
    @State var arr:[Int] = makeList(getDefaultValue(storeData: UserDefaults.standard.integer(forKey: "numbers"), defaultData: 8))

    @State var elepsedTime = 0
    @State var score = UserDefaults.standard.integer(forKey: "rounds") * UserDefaults.standard.integer(forKey: "numbers")
    @AppStorage("name") var name = "name"
    @State var isNameConfirm = false

    init(data:ProgrammData) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        UITableView.appearance().backgroundColor = .black
        self.data = data
    }

    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                NavigationLink(isActive: $toSettings) {
                    Settings(score: $score, roundsNr: $roundsAppStorage, numbersNr: $numbersAppStorage, fizz: $fizzName, buzz: $buzzName, pop: $popName, fizzNr: $fizz, buzzNr: $buzz, popNr: $pop)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $toLeaderBoard) {
                    LeaderBoard(data: data)
                } label: {
                    EmptyView()
                }
                
                
                VStack {
                    if !isGameComplete {
                        GameTimer(elepsedTime: $elepsedTime)
                            .onReceive(timer) { _ in
                                if remainingAnswers > 0 && !(countDownNr > 0){
                                    elepsedTime += 1
                                }
                            }
                    }

                    ZStack {
                        Rectangle()
                            .fill(Color(red: 0.125, green: 0.125, blue: 0.125))
                            .frame( height: 200, alignment: .center)
                        
                        if !isNameConfirm {
                            NameLine(name: $name, isNameConfirm: $isNameConfirm)
                                .padding(.horizontal)
                        }
                        if isNameConfirm {
                            if countDownNr > 0 {
                                Text("\(countDownNr)... ")
                                    .font(.system(size: 64, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .onReceive(timer) { _ in
                                        countDownNr -= 1
                                        while getCorrectNumbers() == 0 {
                                            refreshFunc()
                                        }
                                        remainingAnswers = getCorrectNumbers()
                                    }
                            } else {
                                if isGameComplete {
                                    VStack {
                                        Text("Well Played!!!")
                                            .font(.system(size: 52, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                        GameTimer(elepsedTime: $elepsedTime)
                                    }
                                    
                                } else {
                                    Text("\(fizzBuzzPopChoice.title)")
                                        .font(.system(size: 54, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,16)
                    if !isGameComplete && isNameConfirm{
                        Text("\(getInfoText()) ")
                            .foregroundColor(isWrongAnswer ? .red : .white)
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                    }
                    
                    Spacer()
                    // Choice pane
                    if countDownNr < 1 && !isGameComplete {
                        VStack{
                            HStack {
                                ForEach (0 ..< numbersAppStorage / 2) { i in
                                    GameCell(isWrong: $isWrongAnswer, remaining: $remainingAnswers, order: $fizzBuzzPopChoice, rounds: $roundsAppStorage, name: $name, score: $score, isRoundComplete: $isRoundComplete, isGameComplete: $isGameComplete, scores: $scores, number: arr[i])
                                }
                            }.frame(height: 40, alignment: .center)

                            HStack {
                                ForEach (numbersAppStorage / 2 ..< numbersAppStorage) { i in
                                    GameCell(isWrong: $isWrongAnswer, remaining: $remainingAnswers, order: $fizzBuzzPopChoice, rounds: $roundsAppStorage, name: $name, score: $score, isRoundComplete: $isRoundComplete, isGameComplete: $isGameComplete, scores: $scores, number: arr[i])
                                }
                            }.frame(height: 40, alignment: .center)
                        }
                        .frame( height: 360, alignment: .center)
                    }
                    
                    Spacer()
                    if isNameConfirm {
                        HStack(alignment: .center, spacing: 0) {
                            RefreshButton {
                                refreshFunc()
                            }

                            Spacer()

                            BigButton(isRoundComplete: $isRoundComplete,
                                      isGameComplete: $isGameComplete,
                                      countDownNr: $countDownNr,
                                      remainingAnswers: $remainingAnswers) {
                                if isRoundComplete {
                                    refreshFunc()
                                    isRoundComplete = false
                                    roundTitle += 1
                                }

                                if isGameComplete {
                                    roundTitle = 1
                                }

                                rounds = isGameComplete ? roundsAppStorage : rounds
                                isGameComplete = isGameComplete ? false : false
                            }
                            .frame( height: 50)
                            .padding(.horizontal,20)

                            Spacer()

                            FavoriteButton {
                                data.scores.removeAll()
                                data.names.removeAll()
                                let sortedTwo = Storage.gameHistory.sorted { $0.value > $1.value }

                                for (names1, score1) in sortedTwo {
                                    data.names.append(names1)
                                    data.scores.append(score1)
                                }

                                toLeaderBoard = true
                            }
                        }
                        .padding(.bottom, 150)
                        .frame( height: 50, alignment: .center)
                        .padding(.horizontal, 37)
                    }
                }.edgesIgnoringSafeArea(.top)
                    .padding(.top,50)
            }
            .navigationTitle("Round \(roundTitle)")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                Button("Settings") {
                    toSettings = true
                }
                .foregroundColor(.white)
            }
        }
    }

    private func refreshFunc() {
        countDownNr = 3
        fizzBuzzPopChoice = makeOrder()
        arr = makeList(numbersAppStorage)
    }

    private func getInfoText() -> String {
        var res = ""
        if countDownNr > 0 {
            res =  "Prepairing now"
        } else {
            if getCorrectNumbers() > 0 {
                res = "Select \(getCorrectNumbers()) numbers"
            } else {
                res =  "Refresh the game"
            }

            if isWrongAnswer {
                res = "Wrong! Select other number"
            }
            if isRoundComplete {
                res = "Correct! Proceed to the next round"
            }
        }
        return res
    }
    
    private func getCorrectNumbers() -> Int {
        var res = 0

        arr.forEach {
            if self.fizzBuzzPopChoice.isCorrect($0) {
                res += 1
            }
        }

        return res
    }

    private func handleCellPress(with number: Int) {
        if fizzBuzzPopChoice.isCorrect(number) {
            remainingAnswers -= 1
            cellStatus = .win
            isWrongAnswer = false
        } else {
            cellStatus = .lose
            isWrongAnswer = true
            score -= 1
        }

        isRoundComplete = remainingAnswers == 0

        if isRoundComplete {
            rounds -= 1
        }

        isGameComplete = rounds == 0
        if isGameComplete {
            Storage.gameHistory[name] = score
        }
    }

    private func makeOrder() -> NumberType {
        NumberType(rawValue: Int.random(in: 1...6)) ?? .fizz
    }


}

private func getDefaultValue (storeData:Int, defaultData: Int) -> Int {
    var res = 0
    if storeData == 0 {
        res = defaultData
    } else {
        res = storeData
    }
    return res
}

private func makeList(_ n: Int) -> [Int] {
    return (0..<n).map { _ in .random(in: 0...99) }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen (data: ProgrammData())
    }
}
