import SwiftUI
import Charts

func formatarComoMoeda(_ valor: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
}

let formato: NumberFormatter = {
    let formato = NumberFormatter()
    formato.numberStyle = .currency
    formato.locale = Locale.current
    return formato
}()

struct ContentView: View{
    @StateObject var viewModel = ViewModel()
    var body: some View{
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(Color.fundo)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    HStack{
                        NavigationLink(destination: Tab()){
                            Text("Iniciar")
                                .frame(width: 250,height: 40)
                                .background(Color.botão)
                                .font(.headline)
                                .foregroundStyle(Color.black)
                                .cornerRadius(30)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}






#Preview {
    ContentView()
}
