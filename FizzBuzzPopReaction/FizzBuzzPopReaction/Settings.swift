import SwiftUI

struct Settings: View {
    @State var rounds = ""
    @State var numbers = ""
    @Binding var score: Int
    @Binding var roundsNr: Int
    @Binding var numbersNr: Int
    @State var isActive = false
    @Binding var fizz :String
    @Binding var buzz :String
    @Binding var pop :String
    @Binding var fizzNr : Int
    @Binding var buzzNr : Int
    @Binding var popNr : Int
    @State var toConfigFizz = false
    @State var toConfigBuzz = false
    @State var toConfigPop = false
    var body: some View {
        VStack{
            NavigationLink( isActive: $toConfigFizz) {
                Cofiguration(name: $fizz, number: $fizzNr)
            } label: {
                EmptyView()
            }
                NavigationLink(isActive: $toConfigBuzz) {
                    Cofiguration(name: $buzz, number: $buzzNr)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $toConfigPop) {
                Cofiguration(name: $pop, number: $popNr)
        } label: {
            EmptyView()
        }

            Group{
                HStack {
                    Text("Rounds")
                    Spacer()
                    ZStack {
                        if rounds == "" {
                            Text("\(UserDefaults.standard.integer(forKey: "rounds"))")
                                .opacity(0.6)
                        }
                        TextField("3", text: $rounds)
                            .frame(width: 11)
                            .onTapGesture {
                                isActive = true
                            }
                    }
                }
                Divider()
                HStack {
                    Text("Numbers to select")
                    Spacer()
                    ZStack {
                        if numbers == "" {
                            Text("\(UserDefaults.standard.integer(forKey: "numbers"))")
                                .opacity(0.6)
                        }
                        TextField("", text: $numbers)
                            .frame(width: 11)
                            .onTapGesture {
                                isActive = true
                            }
                    }
                }
                .padding(.bottom, 61)
          
            }
            
            
            Group{
                HStack {
                    Text("Configure")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding(.bottom, 27)
                HStack {
                    Text(fizz)
                    Spacer()
                    Text("\(fizzNr)")
                        .frame(width: 11)
                    Image(systemName: "chevron.forward")
                        .onTapGesture {
                            toConfigFizz = true
                        }
                }
                Divider()
                HStack {
                    Text(buzz)
                    Spacer()
                    Text("\(buzzNr)")
                        .frame(width: 11)
                    Image(systemName: "chevron.forward")
                        .onTapGesture {
                            toConfigBuzz = true
                        }
                }
                Divider()
                HStack {
                    Text(pop)
                    Spacer()
                    Text("\(popNr)")
                        .frame(width: 11)
                    Image(systemName: "chevron.forward")
                        .onTapGesture {
                            toConfigPop = true
                        }
                }
                Divider()
            }
            Spacer()
        }
        .toolbar(content: {
            Button {
                if rounds != "" {
                    if let a = Int(rounds) {
                        UserDefaults.standard.set(a, forKey: "rounds")
                        roundsNr = a
                    }
                }
                
                if numbers != "" {
                    if let a = Int(numbers) {
                        UserDefaults.standard.set(a, forKey: "numbers")
                        numbersNr = a
                    }
                }
              score = numbersNr * roundsNr
            } label: {
                if isActive {
                    Text("Save")
                        .foregroundColor(rounds != "" || numbers != "" ? .yellow : .white)
                }
                
            }

        })
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 16)
        .padding(.top, 37)
        .foregroundColor(.white)
        .background(.black)
      
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(score: .constant(0), roundsNr: .constant(0), numbersNr: .constant(0), fizz: .constant(""), buzz: .constant(""), pop: .constant(""), fizzNr: .constant(0), buzzNr: .constant(0), popNr: .constant(0))
    }
}
