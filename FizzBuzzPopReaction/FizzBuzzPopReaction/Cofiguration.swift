import SwiftUI

struct Cofiguration: View {
    @State var name1 = ""
    @State var nr1 = ""
    @State var isActive = false
    @Binding var name: String
    @Binding var number: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
           Group {
            Text("Name")
                   .padding(.bottom, 12)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.125, green: 0.125, blue: 0.125))
                .frame( height: 46)
                ZStack {
                    if name1 == "" {
                        Text(name)
                            .opacity(0.6)
                    }
                    TextField("", text: $name1)
                        .onTapGesture {
                            isActive = true
                        }
                }
            }
            .padding(.bottom, 26)
            
            Text("Number")
                   .padding(.bottom, 12)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.125, green: 0.125, blue: 0.125))
                .frame( height: 46)
                ZStack {
                    if nr1 == "" {
                        Text("\(number)")
                            .opacity(0.6)
                    }
                    TextField("", text: $nr1)
                        .onTapGesture {
                            isActive = true
                        }
                }
            }
        }
           .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("Configure")
        .foregroundColor(.white)
        .background(.black)
        .toolbar(content: {
            Button {
                if name1 != "" {
                        name = name1
                }
                
                if nr1 != "" {
                    if let a = Int(nr1) {
                        number = a
                    }
                }
              
            } label: {
                if isActive {
                    Text("Save")
                        .foregroundColor(name1 != "" || nr1 != "" ? .yellow : .white)
                }
            }
        })
    }
}

struct Cofiguration_Previews: PreviewProvider {
    static var previews: some View {
        Cofiguration(name: .constant(""), number: .constant(0))
    }
}
