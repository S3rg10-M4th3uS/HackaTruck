import SwiftUI


struct Familia: View{
    @State private var gastoTotal: Double = 0.0
    @State private var meta: Double = 3000.00
    @ObservedObject var globalData = GlobalData.compartilhada
    @StateObject var viewModel = ViewModel()
    @State private var dataEscolhida = Date()
    @State private var mostrarCalendario = false

    
    // []
    
    var manager: GastoManager {
        return GastoManager(gastos: viewModel.gastos.filter { $0.data == globalData.ano && $0.mes == globalData.mes })
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
                        totalGastoView
                        listaView
                        Spacer()
                        
                    }
                }
            }
        }.onAppear() {
            
            viewModel.fetch()
            
        }
    }

    private var headerView: some View {
        HStack {
            
//            Text("\(mes_atual!) \(year)").font(.title)
//                    .foregroundColor(.black)
//                    .bold()
//                    .padding()
            
            Text("\(mes[globalData.mes]!) \(globalData.ano)")
                .foregroundColor(.primary)
                .bold()
                .padding().font(.title)
            

            Spacer()
            Button(action:{mostrarCalendario.toggle()}){
                Image(systemName: "calendar")
                    .font(.system(size: 40))
                    .foregroundColor(Color.botão)
            }
                .padding()
        }
        .sheet(isPresented: $mostrarCalendario, content: {
            DatePicker("Selecione uma data", selection: $dataEscolhida, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            Button(action: {
                globalData.mes = dateToStringM(date: dataEscolhida)
                globalData.ano = dateToStringY(date: dataEscolhida)
                gastoTotal = calculateGastoTotal(Gastos: viewModel.gastos)
                mostrarCalendario.toggle()
            }, label: {
                Image(systemName: "calendar")
                    .scaledToFill()
                Text("Selecionar")
            })
        })
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
                    .fill(.fundo)
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
        }.onAppear() {
            gastoTotal = calculateGastoTotal(Gastos: viewModel.gastos)
            print(viewModel.gastos)
        }
    }

    func formatarComoMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
    }
    
    
    private func dateToStringM(date: Date) -> String{
        let month_formatter = DateFormatter()
        month_formatter.dateFormat = "MM"
        return month_formatter.string(from: date)
        
    }
    private func dateToStringY(date:Date) -> String{
        let year_formatter = DateFormatter()
        year_formatter.dateFormat = "yyyy"
        return year_formatter.string(from: date)
    }
    
    func calculateGastoTotal(Gastos: [Gasto]) -> Double {
        
        var totalValor = 0.0
        for gasto in Gastos {
                if gasto.mes == globalData.mes && gasto.data == globalData.ano {
                    totalValor += gasto.valor
                }
            }
            return totalValor
        }

}

#Preview {
    Familia()
}




