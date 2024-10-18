import SwiftUI

struct DadosMembros: Identifiable, Hashable{
    var id = UUID()
    var nome: String
    var imagem: String
}


struct Membros: View{
    @StateObject var viewModel = ViewModel()
    @StateObject var viewModelAux = ViewModelAux()
    @State var Pessoas: [DadosMembros] = [DadosMembros(nome: "Mãe", imagem:"https://img.freepik.com/vetores-gratis/ilustracao-de-desenho-animado-de-perfil-lateral-desenhada-a-mao_23-2150503847.jpg?t=st=1729014968~exp=1729018568~hmac=24b42eaab2d98379ad8e7507d946bd44ad2afe163b5d5813bf031ef2aa0f9476&w=996"), DadosMembros(nome: "Pai", imagem:"https://img.freepik.com/vetores-gratis/ilustracao-de-desenho-animado-de-perfil-lateral-desenhada-a-mao_23-2150503821.jpg?t=st=1729014875~exp=1729018475~hmac=67449c867fee883ef26075b38fe12a85f3b4cfee307c03cce3e09a52ecad519a&w=996"),DadosMembros(nome: "Filho", imagem:"https://img.freepik.com/vetores-gratis/ilustracao-de-desenho-animado-de-perfil-lateral-desenhada-a-mao_23-2150517168.jpg?t=st=1729015043~exp=1729018643~hmac=10e20b1fdf51dd906b5914b9b536e3b262cec086b17670a99577cf7473ed2a43&w=996"),DadosMembros(nome: "Filha", imagem:"https://img.freepik.com/vetores-gratis/ilustracao-de-desenho-animado-de-perfil-lateral-desenhada-a-mao_23-2150503834.jpg?t=st=1729014994~exp=1729018594~hmac=357b50eade330d5d302c13b4258e4433f85d5806f18a76052cd5769225b21ce6&w=996")
                                          
    ]
    @State var total: Double?
    @State var strTotal : String?
    @ObservedObject var globalData = GlobalData.compartilhada
    
    var manager: GastoManager {
        return GastoManager(pessoas: viewModel.gastos.filter { ($0.nome == "Mãe" || $0.nome == "Pai" || $0.nome == "Filho" || $0.nome == "Filha" ) && $0.data == globalData.ano && $0.mes == globalData.mes })
    }
    
    var body: some View{
        
        NavigationStack{
                        ZStack{
                            Rectangle()
                                .fill(Color.adaptativo)
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            ScrollView{
                            VStack{
                                HStack{
                                    Text("Família Silva")
                                    //modificar pra variável global
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .bold()
                                        
                                    Spacer()
                                }.padding(.horizontal)
                                VStack(spacing: 20){
//                                    ForEach($Pessoas, id: \.self){ pessoa in
//                                        if(pessoa.nome.wrappedValue != "teste"){
//                                            HStack{
//                                                NavigationLink(destination: Detalhes(usuario: pessoa.nome.wrappedValue)){
//                                                AsyncImage(url: URL(string: pessoa.imagem.wrappedValue)) { image in
//                                                    image
//                                                        .resizable()
//                                                        .aspectRatio(contentMode: .fill)
//                                                } placeholder: {
//                                                    ProgressView()
//                                                }
//                                                .frame(width: 100, height: 100)
//                                            }
//                                                    VStack{
//                                                        Text(pessoa.nome.wrappedValue)
//                                                            .font(.headline)
//                                                            .onAppear{
//
//                                                                total = Total(pessoa:pessoa.nome.wrappedValue, gastos: viewModel.gastos)
//                                                                strTotal =  String(format: "%.2f", total ?? "0,00")
//                                                            }
//                                                        ZStack{
//                                                            RoundedRectangle(cornerRadius: 30).fill(.fundo)
//                                                                .frame(width: 150, height: 40)
//                                                            Text(strTotal ?? "0,00")
//                                                        }
//
//                                                    }
//                                                }
//                                            }
//
//                                        }
                                    
                                    ForEach(manager.groupedGastos.keys.sorted(), id: \.self) { tipo in
                                        VStack(alignment: .leading) {
                                            
                                            
                                            let totalForNome = manager.groupedGastos[tipo]?.reduce(0.0) { $0 + $1.valor } ?? 0.0
                                            HStack { //Antes: ZStack
                                                
                                                HStack(spacing: 20) {
                                                    if tipo == "Mãe" {
                                                        NavigationLink(destination: Detalhes(usuario: "Mãe")) {
                                                            AsyncImage(url: URL(string: Pessoas[0].imagem)) { image in
                                                                image
                                                                    .resizable()
                                                                    .clipShape(Circle())
                                                                    .aspectRatio(contentMode: .fill)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }.frame(width: 100, height: 100)
                                                        }
                                                        VStack(spacing: 10){
                                                            Text(tipo)
                                                                .foregroundStyle(Color.primary)
                                                                .bold()
                                                                .font(.title3)
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 30)
                                                                .fill(Color.fundo)
                                                                .frame(width: 190, height: 35)
                                                            Text("Total: \(formatarComoMoeda(totalForNome))")
                                                        }
                                                    }
                                                    } else if tipo == "Pai" {
                                                        NavigationLink(destination: Detalhes(usuario: "Pai")) {
                                                            AsyncImage(url: URL(string: Pessoas[1].imagem)) { image in
                                                                image
                                                                    .resizable()
                                                                    .clipShape(Circle())
                                                                    .aspectRatio(contentMode: .fill)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }.frame(width: 100, height: 100)
                                                        }
                                                        VStack(spacing: 10){
                                                            Text(tipo)
                                                                .foregroundStyle(Color.primary)
                                                                .bold()
                                                                .font(.title3)
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 30)
                                                                .fill(Color.fundo)
                                                                .frame(width: 190, height: 35)
                                                            Text("Total: \(formatarComoMoeda(totalForNome))")
                                                        }
                                                    }
                                                    } else if tipo == "Filho" {
                                                        NavigationLink(destination: Detalhes(usuario: "Filho")) {
                                                            AsyncImage(url: URL(string: Pessoas[2].imagem)) { image in
                                                                image
                                                                    .resizable()
                                                                    .clipShape(Circle())
                                                                    .aspectRatio(contentMode: .fill)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }.frame(width: 100, height: 100)
                                                        }
                                                        VStack(spacing: 10){
                                                            Text(tipo)
                                                                .foregroundStyle(Color.primary)
                                                                .bold()
                                                                .font(.title3)
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 30)
                                                                .fill(Color.fundo)
                                                                .frame(width: 190, height: 35)
                                                            Text("Total: \(formatarComoMoeda(totalForNome))")
                                                        }
                                                    }
                                                    } else if tipo == "Filha" {
                                                        NavigationLink(destination: Detalhes(usuario: "Filha")) {
                                                            AsyncImage(url: URL(string: Pessoas[3].imagem)) { image in
                                                                image
                                                                    .resizable()
                                                                    .clipShape(Circle())
                                                                    .aspectRatio(contentMode: .fill)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }.frame(width: 100, height: 100)
                                                        }
                                                        VStack(spacing: 10){
                                                            Text(tipo)
                                                                .foregroundStyle(Color.primary)
                                                                .bold()
                                                                .font(.title3)
                                                        ZStack{
                                                            RoundedRectangle(cornerRadius: 30)
                                                                .fill(Color.fundo)
                                                                .frame(width: 190, height: 35)
                                                            Text("Total: \(formatarComoMoeda(totalForNome))")
                                                        }
                                                    }
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.bottom, 10)
                                    }
                                    
//                                    ForEach(viewModelAux.apiGeral.filter {$0.nome == "Mãe"} , id: \.self) { p in
//                                        Text("\(p.valor)")
//                                    }
                                    
                                }.padding()
                                
                            }
                        }
                        
                    }
        }.onAppear(){
            viewModel.fetch()
            viewModelAux.fetch()
            print(viewModel.gastos)
        }
    }
    
    func formatarComoMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: valor)) ?? "\(valor)"
    }
    
    func Total (pessoa: String, gastos: [Gasto])-> Double{
        var total: Double = 0
        
        for gasto in viewModel.gastos{
            if gasto.nome==pessoa && gasto.acesso=="Público"{
                    total+=gasto.valor
            }
        }
        
        return total
    }

}


#Preview {
    Membros()
}
