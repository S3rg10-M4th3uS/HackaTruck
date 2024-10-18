import SwiftUI

struct Adicionar: View {
    
    @State var showAlert = false
    @State var Mes = ""
    @State var count = 0
    @State var Ano = ""
    @State private var alertMessage = ""
    @State var acesso = ""
    var TipoAcesso: [String] = ["Público", "Privado"]
    @State var tipo = ""
    var TipoGastos: [String] = ["Alimentação", "Saúde", "Lazer", "Água", "Energia", "Internet"]
    @State var valor = 0.00
    @State var DataEscolhida: Date = Date()
    @State var pagamento = ""
    var TipoPagamento: [String] = ["Cartão de crédito", "Cartão de débito", "Pix", "Espécie"]
    
    var body: some View {
        NavigationView {
            ScrollView { // Adiciona ScrollView aqui
                VStack(spacing: 30) {
                    HStack {
                        Text("Novo gasto")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding()
                    
                    VStack {
                        // Tipo de Acesso
                        HStack {
                            Text("Tipo de acesso")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo) // Alterado para .botao
                                .frame(width: 350, height: 40)
                            TextField("Selecione", text: $acesso)
                                .disabled(true)
                                .padding(.horizontal)
                            HStack {
                                Spacer()
                                Menu {
                                    ForEach(TipoAcesso, id: \.self) { item in
                                        Button(item) {
                                            self.acesso = item
                                        }
                                    }
                                } label: {
                                    VStack(spacing: 5) {
                                        Image(systemName: "chevron.down.circle.fill")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }.padding()
                        }.padding(.horizontal)
                        
                        // Valor
                        HStack {
                            Text("Valor")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo) // Alterado para .botao
                                .frame(width: 350, height: 40)
                            TextField("", value: $valor, formatter: formato)
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.horizontal)
                        
                        // Forma de pagamento
                        HStack {
                            Text("Forma de pagamento")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo) // Alterado para .botao
                                .frame(width: 350, height: 40)
                            TextField("Selecione", text: $pagamento)
                                .disabled(true)
                                .padding(.horizontal)
                            HStack {
                                Spacer()
                                Menu {
                                    ForEach(TipoPagamento, id: \.self) { item in
                                        Button(item) {
                                            self.pagamento = item
                                        }
                                    }
                                } label: {
                                    VStack(spacing: 5) {
                                        Image(systemName: "chevron.down.circle.fill")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }.padding()
                        }.padding(.horizontal)
                        
                        // Tipo de gasto
                        HStack {
                            Text("Tipo de gasto")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo) // Alterado para .botao
                                .frame(width: 350, height: 40)
                            TextField("Selecione", text: $tipo)
                                .disabled(true)
                                .padding(.horizontal)
                            HStack {
                                Spacer()
                                Menu {
                                    ForEach(TipoGastos, id: \.self) { item in
                                        Button(item) {
                                            self.tipo = item
                                        }
                                    }
                                } label: {
                                    VStack(spacing: 5) {
                                        Image(systemName: "chevron.down.circle.fill")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }.padding()
                        }.padding(.horizontal)
                        
                        // Data
                        HStack {
                            Text("Data")
                                .font(.headline)
                            Spacer()
                        }.padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo)
                                .frame(width: 350, height: 40)
                            HStack {
                                DatePicker(selection: $DataEscolhida, displayedComponents: [.date]) {
                                    Label("Selecione a data: ", systemImage: "calendar")
                                }
                                .padding()
                            }.onChange(of:DataEscolhida)
                            {
                                updateMesAndAno(from: DataEscolhida)
                            }
                        }
                        
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30).fill(Color.fundo)
                                .frame(width: 150, height: 40)
                            Button("Adicionar") {
                                novoGasto()
                            }
                            .foregroundColor(.primary)
                            .padding()
                        }
                        
                        Spacer()
                        
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMessage), message: Text(""), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
        }
    }
    
    func novoGasto() {
        if acesso == "" || valor == 0.00 || Ano == "" || tipo == "" || pagamento == "" || Mes == "" {
            alertMessage = "Preencha todos os campos"
            showAlert = true
        } else {
            count += 1
            
            let NovoGasto =  Gasto(_id: nil,_rev: nil,id:count,nome: "Mãe", nome_familia: "Silva", valor: valor, mes: Mes, acesso: acesso, forma_pgt: pagamento,tipo_gasto: tipo, data: Ano)
            
            criarGasto(gasto: NovoGasto)
            alertMessage = "Gasto adicionado"
            showAlert = true
            
            acesso = ""
            valor = 0.00
            pagamento = ""
            Ano = ""
            tipo = ""
            Mes = ""
        }
    }
    
    public func updateMesAndAno(from date: Date) {
        let mesFormatter = DateFormatter()
        mesFormatter.dateFormat = "MM" // Formato para o mês como número
        Mes = mesFormatter.string(from: date)

        let anoFormatter = DateFormatter()
        anoFormatter.dateFormat = "yyyy" // Formato para o ano
        Ano = anoFormatter.string(from: date)
    }
}

#Preview {
    Adicionar()
}
