import SwiftUI

struct Welcome: View {
    @State var isNext = false
    @State var isVisible = false
    @ObservedObject var data: ProgrammData
    @Binding var isGreating: Bool
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0) {
                Text("ARE               YOU           READY?")
                    .font(.system(size: 64, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(4)
                Spacer()
                Button {
                    isVisible = true
                    isNext = true
                    UserDefaults.standard.set(isNext, forKey: "isGreating")
                }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.yellow)
                    Text("Let's start")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                }
                .frame( height: 50, alignment: .center)
                .padding(.horizontal,16)
            }
                
            }
            .background(.black)
            
            if isVisible{
                Main(data1: data)
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome(data: ProgrammData(), isGreating: .constant(true))
    }
}
