import SwiftUI
import Charts



struct Individual: View {
    @State private var gastoTotal: Double = 0.00
    @State private var meta: Double = 3000.00
    @ObservedObject var globalMeta = GlobalMeta.compartilhada
    @ObservedObject var globalData = GlobalData.compartilhada
    @ObservedObject var globalAPI = GlobalAPI.compartilhada
    
    @State private var dataEscolhida = Date()
    @State private var mostrarCalendario = false
    
    @StateObject var viewModel = ViewModel()
    
    var manager: GastoManager {
        return GastoManager(gastos: viewModel.gastos.filter { $0.data == globalData.ano && $0.mes == globalData.mes && $0.nome == "Mãe" })
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
                            .onAppear() {
                            globalAPI.dadosAPI = viewModel.gastos
                        }
                        totalGastoView
                        
                        metaView
                        navigationLinks
                        chartView
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
                    .fill(gastoTotal <= globalMeta.meta ? Color.verdeLucro : Color.vermelhoPrejuizo)
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
    
    private var metaView: some View {
        HStack {
            Text("Meta")
                .font(.title2)
                .foregroundColor(.primary)
                .bold()
                .padding()
            Spacer()
            Text(formatarComoMoeda(globalMeta.meta))
                .font(.headline)
                .foregroundColor(.primary)
                .bold()
                .padding(30)
        }
    }
    
    private var listaView: some View {

        ForEach(manager.groupedGastos.keys.sorted(), id: \.self) { tipo in
            VStack(alignment: .leading) {
                Text(tipo).bold().font(.title3)
                let totalForTipo = manager.groupedGastos[tipo]?.reduce(0.0) { $0 + $1.valor } ?? 0.0
                NavigationLink(destination: Resumo(tipoGasto: tipo)){
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.fundo)
                        .frame(width: 350, height: 35)
                    HStack {
                        Text("Total: \(formatarComoMoeda(totalForTipo))")
                    }
                }
            }
                .foregroundStyle(Color.primary)
            }
            .padding(.bottom, 10)
        }.onAppear() {
            gastoTotal = calculateGastoTotal(Gastos: viewModel.gastos)
        }
    }
    
    private var chartView: some View {
        @State var mesAtual = Int(globalData.mes)!
        
        func ajustarMes(_ mes: Int) -> Int {
            let ajustado = (mes - 1) % 12
            return ajustado >= 0 ? ajustado + 1 : ajustado + 13
        }
        
        let todosOsMeses = ((mesAtual - 5)...(mesAtual + 2)).map { String(format: "%02d", $0) }
        var valoresPorMes = viewModel.gastos.reduce(into: [String: Double]()) { (result, gasto) in
            result[gasto.mes, default: 0] += gasto.valor
        }
        for mes in todosOsMeses {
            if valoresPorMes[mes] == nil {
                valoresPorMes[mes] = 0
            }
        }

        let mesesOrdenados = todosOsMeses

        return HStack {
            Chart {
                ForEach(mesesOrdenados, id: \.self) { mes in
                    if let valor = valoresPorMes[mes] {
                        BarMark(
                            x: .value("Mês", mes),
                            y: .value("Valor", valor)
                        )
                    }
                }
            }
            .frame(width: 300, height: 200)
            .padding()
            .foregroundStyle(Color.primary)
        }
    }



    
    private var navigationLinks: some View {
        VStack {
            
            NavigationLink("+ Adicionar Gasto", destination: Adicionar())
                .frame(width: 280, height: 40)
                .background(Color.fundo)
                .cornerRadius(30)
                .foregroundStyle(Color.primary)
                .bold()
                .padding(.bottom)
        }
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

    func formatarComoMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
    }
    func calculateGastoTotal(Gastos: [Gasto]) -> Double {
        
        var totalValor = 0.0
        for gasto in Gastos {
            if gasto.mes == globalData.mes && gasto.data == globalData.ano && gasto.nome == "Mãe" {
                    totalValor += gasto.valor
                }
            }
            return totalValor
        }
}

#Preview {
    Individual()
}
