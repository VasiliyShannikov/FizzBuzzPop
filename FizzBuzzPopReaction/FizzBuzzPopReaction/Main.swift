import SwiftUI

struct Main: View {
    
    @State var countDownNr = 3
    init(data1:ProgrammData) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        UITableView.appearance().backgroundColor = .black
        self.data = data1
    }
    @ObservedObject var data: ProgrammData
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var fizzBuzzPopChoice = Int.random(in: 1...6)
    
    @State var fizz = 3
    @State var bazz = 5
    @State var pop = 7
    @State var roundTitle = 1
    @State var remainingAnswers = 0
    @State var toSettings = false
    @State var toLeaderBoard = false
    @State var isStarted = false
    @State var isWnongAnser = false
    @State var isRoundComlete = false
    @State var isGameComlete = false
    @State var fizzName = "Fizz"
    @State var buzzName = "Buzz"
    @State var popName = "Pop"
    @State var names = [String]()
    @State var scores = [Int]()
    @State var numbersAppStorage = getDefaultVal(storeData: UserDefaults.standard.integer(forKey: "numbers"), defaultData: 8)
    
    @State var roundsAppStorage = getDefaultVal(storeData: UserDefaults.standard.integer(forKey: "rounds"), defaultData: 3)
    @State var rounds = UserDefaults.standard.integer(forKey: "rounds")
    @State var arr:[Int] = makeList(getDefaultVal(storeData: UserDefaults.standard.integer(forKey: "numbers"), defaultData: 8))
    
    @State var elepsedTime = 0
    @State var score = UserDefaults.standard.integer(forKey: "rounds") * UserDefaults.standard.integer(forKey: "numbers")
    @AppStorage("name") var name = "name"
    @State var isNameConfirm = false
    fileprivate func refreshFunc() {
        countDownNr = 3
        fizzBuzzPopChoice = Int.random(in: 1...6)
        arr = makeList(numbersAppStorage)
    }
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                NavigationLink(isActive: $toSettings) {
                    Settings(score: $score, roundsNr: $roundsAppStorage, numbersNr: $numbersAppStorage, fizz: $fizzName, buzz: $buzzName, pop: $popName, fizzNr: $fizz, buzzNr: $bazz, popNr: $pop)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $toLeaderBoard) {
                    LeaderBoard(data1: data)
                } label: {
                    EmptyView()
                }
                
                
                VStack {
                    if !isGameComlete {
                        Text("\((elepsedTime/3600),specifier:"%02d"):\((elepsedTime/60),specifier:"%02d"):\((elepsedTime % 60),specifier:"%02d" )")
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        
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
                                if isGameComlete {
                                    VStack {
                                        Text("Well Played!!!")
                                            .font(.system(size: 52, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                        Text("\((elepsedTime/3600),specifier:"%02d"):\((elepsedTime/60),specifier:"%02d"):\((elepsedTime % 60),specifier:"%02d" )")
                                            .font(.system(size: 24, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                    }
                                    
                                } else {
                                    Text("\(fizzBuzzPop())")
                                        .font(.system(size: 54, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,16)
                    if !isGameComlete && isNameConfirm{
                        Text("\(getInfoText()) ")
                            .foregroundColor(isWnongAnser ? .red : .white)
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                    }
                    
                    Spacer()
                    // Choice pane
                    if countDownNr < 1 && !isGameComlete {
                        VStack{
                            HStack {
                                ForEach (0 ..< numbersAppStorage / 2) { i in
                                    let a = Rect( data: data, isWrong: $isWnongAnser, ramaining: $remainingAnswers, order: $fizzBuzzPopChoice, rounds: $roundsAppStorage,fizz: $fizz,buzz: $bazz, pop: $pop, name: $name, score: $score, isRoundComplete: $isRoundComlete, isGameComlete: $isGameComlete,names: $names, scores: $scores, number: arr[i])
                                    a
                                        .onAppear {
                                            let y = a.number % 2
                                            if y == 0 {
                                            }
                                        }
                                }
                            }.frame(height: 40, alignment: .center)
                            
                            HStack {
                                ForEach (numbersAppStorage / 2 ..< numbersAppStorage) { i in
                                    let a = Rect( data: data, isWrong: $isWnongAnser, ramaining: $remainingAnswers, order: $fizzBuzzPopChoice, rounds: $roundsAppStorage,fizz: $fizz, buzz: $bazz, pop: $pop, name: $name, score: $score, isRoundComplete: $isRoundComlete, isGameComlete: $isGameComlete,names: $names, scores: $scores, number: arr[i])
                                    a
                                        .onAppear {
                                            _ = a.number % 2
                                        }
                                }
                            }.frame(height: 40, alignment: .center)
                        }
                        .frame( height: 360, alignment: .center)
                    }
                    
                    Spacer()
                    if isNameConfirm{
                        HStack(alignment: .center, spacing: 0) {
                            Button {
                                refreshFunc()
                                // remainingAnswers = 0
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(Color(red: 0.204, green: 0.204, blue: 0.212))
                                        .frame(width: 40, height: 40, alignment: .center)
                                    Image(systemName: "arrow.clockwise").foregroundColor(.white)
                                }
                            }
                            Spacer()
                            Button {
                                if isRoundComlete {
                                    refreshFunc()
                                    isRoundComlete = false
                                    roundTitle += 1
                                }
                                if isGameComlete {
                                    roundTitle = 1
                                }
                                
                                rounds = isGameComlete ? roundsAppStorage : rounds
                                isGameComlete = isGameComlete ? false : false
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(isRoundComlete ?.yellow : Color(red: 0.771, green: 0.728, blue: 0.568))
                                    Text(getBigButtonText()).foregroundColor(.black)
                                }
                                
                            }
                            .frame( height: 50)
                            .padding(.horizontal,20)
                            
                            Spacer()
                            Button {
                                data.scores.removeAll()
                                data.names.removeAll()
                                let sortedTwo = Storage.gameHistory.sorted {
                                    return $0.value > $1.value
                                }
                                for (names1, score1) in sortedTwo {
                                    data.names.append(names1)
                                    data.scores.append(score1)
                                }
                                toLeaderBoard = true
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(Color(red: 0.204, green: 0.204, blue: 0.212))
                                        .frame(width: 40, height: 40, alignment: .center)
                                    Image(systemName: "star").foregroundColor(.white)
                                }
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
 //***************
    func getBigButtonText() -> String {
        var res = ""
        if countDownNr > 0 {
            res = "Numbers loading..."
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
        } else if isRoundComlete{
            res = "Next round"
        }
        if isGameComlete {
            res = "Play again"
        }
        return res
    }
    func getInfoText() -> String {
    var res = ""
        if countDownNr > 0 {
           res =  "Prepairing now"
        } else {
            if getCorrectNumbers() > 0 {
                res = "Select \(getCorrectNumbers()) numbers"
            } else {
               res =  "Refresh the game"
            }
            
            if isWnongAnser {
                res = "Wrong! Select other number"
            }
            if isRoundComlete {
                res = "Correct! Proceed to the next round"
            }
        }
        return res
    }
    
    func getCorrectNumbers() -> Int {
        var res = 0
        for i in (0..<arr.count) {
            switch self.fizzBuzzPopChoice {
            case 1:
                if arr[i] % fizz == 0 {
                    res += 1
                }
            case 2:
                if arr[i] % bazz == 0 {
                    res += 1
                }
            case 3:
                if arr[i] % pop == 0 {
                    res += 1
                }
            case 4:
                if arr[i] % fizz == 0 &&  arr[i] % bazz == 0 {
                    res += 1
                }
            case 5:
                if arr[i] % bazz == 0 &&  arr[i] % pop == 0 {
                    res += 1
                }
            case 6:
                if arr[i] % fizz == 0 &&  arr[i] % pop == 0 {
                    res += 1
                }
            default:
                isStarted = false
            }
        }
        return res
    }
    func fizzBuzzPop() -> String {
        var res: String
        switch fizzBuzzPopChoice {
        case 1:
            res = fizzName
        case 2:
            res = buzzName
        case 3:
            res = popName
        case 4:
            res = fizzName + buzzName
        case 5:
            res = buzzName + popName
        case 6:
            res = fizzName + popName
        default:
            res = ""
        }
        return res
    }
}

func makeList(_ n: Int) -> [Int] {
    return (0..<n).map { _ in .random(in: 0...99) }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main (data1: ProgrammData())
    }
}

struct Rect: View {
    @ObservedObject var data : ProgrammData
    @Binding var isWrong: Bool
    @Binding var ramaining: Int
    @Binding var order: Int
    @Binding var rounds: Int
    @Binding var fizz: Int
    @Binding var buzz: Int
    @Binding var pop: Int
    @Binding var name: String
    @State var mode = 0
    @Binding var score: Int
    @Binding var isRoundComplete:Bool
    @Binding var isGameComlete: Bool
    @Binding var names :[String]
    @Binding var scores :[Int]
    var number: Int = Int.random(in: 0..<100)
    var defaultColor: Color = Color(red: 0.125, green: 0.125, blue: 0.125)
    var winColor: Color = Color(red: 0.925, green: 0.894, blue: 0.779)
    var loseColor: Color = Color(red: 0.843, green: 0, blue: 0.082)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(getButtonColor())
                .frame( height: 38, alignment: .center)
            Text("\(number)")
                .foregroundColor(mode == 1 ? .black : .white)
                }
        .onTapGesture {
            switch order {
            case 1:
                if number % fizz == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                } else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            case 2:
                if number % buzz == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                }else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            case 3:
                if  number % pop == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                }else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            case 4:
                if self.number % fizz == 0 &&  self.number % buzz == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                }else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            case 5:
                if  number % buzz == 0 &&  self.number % pop == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                }else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            case 6:
                if number % fizz == 0 &&  self.number % pop == 0 {
                    ramaining -= 1
                    mode = 1
                    isWrong = false
                }else {
                    mode = 2
                    isWrong = true
                    score -= 1
                }
            default:
                mode = 0
            }
            isRoundComplete = ramaining == 0
            if isRoundComplete {
                rounds -= 1
            }
            isGameComlete = rounds == 0
            if isGameComlete {
                Storage.gameHistory[name] = score
            }
        }
    }
    
    func getButtonColor () -> Color {
        var res: Color
        switch mode {
        case 1:
            res = winColor
        case 2:
            res = loseColor
        default:
            res = defaultColor
        }
        return res
    }
}

func getDefaultVal (storeData:Int, defaultData: Int) -> Int {
    var res = 0
    if storeData == 0 {
        res = defaultData
    } else {
        res = storeData
    }
    return res
}

