import SwiftUI

struct ModificarMeta: View {
    
    
    @ObservedObject var globalMeta = GlobalMeta.compartilhada
    @State var novameta: Double = 0

    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.fundo)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                Text("A Meta Atual é: \(formatarComoMoeda(globalMeta.meta))")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .bold()
                    .padding()
                TextField("Digite a meta", value: $novameta, formatter: formato)
                    .frame(width: 250, height: 40)
                    .background(Color.adaptativo)
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .padding(.bottom)
                    .keyboardType(.numberPad)
                Button("Confirmar",
                       action: {
                    globalMeta.meta = novameta
                    
                })
                .frame(width: 250, height: 40)
                .background(Color.botão)
                .foregroundStyle(Color.primary)
                .cornerRadius(30)
                .padding()
                Spacer()
            }
        }.onAppear(){
            
        }
    }
}

#Preview {
    ModificarMeta()
}

