import SwiftUI


struct Detalhes: View {
    var usuario = ""
    @State private var gastoTotal: Double = 0.0
    
    @State private var meta: Double = 3000.00
    @ObservedObject var globalData = GlobalData.compartilhada
    @StateObject var viewModel = ViewModel()
    
    

    var manager: GastoManager {
        return GastoManager(gastos: viewModel.gastos.filter { $0.data == globalData.ano && $0.nome == usuario && $0.mes == globalData.mes })
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    Rectangle()
                        .fill(Color.adaptativo)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        headerView
                        nomeView
                        totalGastoView
                        listaView
                        Spacer()
                    }
                }.onAppear() {
                    viewModel.fetch()
                }
            }
        }
    }

    private var headerView: some View {
        HStack {
            let mes_atual = mes[globalData.mes]
            
//            Text("\(mes_atual!) \(year)").font(.title)
//                    .foregroundColor(.black)
//                    .bold()
//                    .padding()
            
            Text("\(mes_atual!) \(globalData.ano)")
                .foregroundColor(.primary)
                .bold()
                .padding().font(.title)
            

            Spacer()
            Image(systemName: "calendar")
                .font(.system(size: 40))
                .foregroundColor(Color.botão)
                .padding()
        }
    }

    private var nomeView: some View {
        HStack {
            Text(usuario).font(.title).bold().padding(.bottom)
            Spacer()
            
        }.padding(.horizontal)
    }

    private var totalGastoView: some View {
        HStack {
            Text("Gasto total")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
                .padding()
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.fundo)
                    .frame(width: 150, height: 40)
                    .cornerRadius(30)
                    .padding()
                Text(formatarComoMoeda(gastoTotal))
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
                    .padding()
            }
        }
    }

    private var listaView: some View {

        ForEach(manager.groupedGastos.keys.sorted(), id: \.self) { tipo in
            VStack(alignment: .leading) {
                Text(tipo).bold().font(.title3)
                let totalForTipo = manager.groupedGastos[tipo]?.reduce(0.0) { $0 + $1.valor } ?? 0.0
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.fundo)
                        .frame(width: 350, height: 35)
                    HStack {
                        Text("Total: \(formatarComoMoeda(totalForTipo))")
                    }
                }
            }
            .padding(.bottom, 10)
        }.onAppear(){
            gastoTotal = calculateGastoTotal()
        }
    }

    func formatarComoMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
    }
    func calculateGastoTotal() -> Double {
            var totalValor = 0.0
        for gasto in viewModel.gastos {
                if gasto.nome == usuario && gasto.mes == globalData.mes && gasto.data == globalData.ano {
                    totalValor += gasto.valor
                }
            }
            return totalValor
        }
}


#Preview {
    Detalhes()
}
