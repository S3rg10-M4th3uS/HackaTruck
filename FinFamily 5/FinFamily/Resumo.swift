import SwiftUI
struct Resumo: View {
    
    
    
    @ObservedObject var globalAPI = GlobalAPI.compartilhada
    @ObservedObject var globalData = GlobalData.compartilhada
    @ObservedObject var viewModel = ViewModel()
    @State var showingAlert = false
    @State var nome = "Mãe"
    @State var tipoGasto: String = ""
    
    var body: some View {
        VStack{
            // Título
            HStack{
                Text(tipoGasto)
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                Spacer()
            }.padding(.horizontal)
            
            // Cabeçalho da tabela
            
            HStack {
                Text("Acesso")
                Spacer()
                Text("Pagamento")
                Spacer()
                Text("Valor")
                Spacer()
                Spacer()
            }
            .font(.headline)
            .padding([.leading, .trailing], 20)
            .padding(.top, 10)
            .overlay(
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.purple),
                alignment: .bottom
            )
            .padding(.bottom, 6)
            
            let gastosFiltrados = globalAPI.dadosAPI.filter { $0.tipo_gasto == tipoGasto && $0.nome == nome && globalData.mes == $0.mes && $0.data == globalData.ano}
            // Verifique o que está sendo retornado
            // Lista de gastos
            List {
                ForEach (gastosFiltrados) { gasto in
                    //if tipoGasto == gasto.tipo_gasto && nome == gasto.nome {
                    HStack {
                        Text(gasto.acesso)
                            .frame(width: 100,height: 8)
                        //.padding(.horizontal,0)
                        Spacer()
                        Text(gasto.forma_pgt)
                            .frame(width: 100,height: 8)
                        //.padding(.horizontal,0)
                        Spacer()
                        Text(formatarComoMoeda(gasto.valor))
                            .frame(width: 100,height: 8)
                        //.padding(.horizontal,0)
                        Spacer()
                        // Ícone de lixeira
                        Button {
                            if let rev = gasto._rev, let id = gasto._id {
                                viewModel.removeItem(withId: id, rev: rev) { i, e in
                                    print(i)
                                }
//                                    sucesso, erro in
//                                    if sucesso {
//                                        print("Gasto removido com sucesso.")
//                                        showingAlert = true
//                                    } else {
//                                        print("Erro ao remover gasto.")
//                                    }
                                showingAlert = true
                            } else {
                                print("ID ou Rev nil")
                            }
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.purple)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("SUCESSO"), message: Text("GASTO REMOVIDO"), dismissButton: .default(Text("OK")))
                        }
                        
                        Spacer()
                    }.padding(.bottom, 6)
                    //}
                }
                
            }
            .listStyle(PlainListStyle()) // Remove o background e bordas da lista
            
        }
        
    }
    func formatarComoMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        print(globalAPI.dadosAPI)
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
    }
}
#Preview {
    Resumo()
}
