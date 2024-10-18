//
//  Dados.swift
//  FinFamily
//
//  Created by Turma01-25 on 11/10/24.
//

import Foundation


struct Individuo {
    let imagem: URL
    let nome: String
    var meta_individual: Double
    //let gastos: [Gasto]
}


// API ->>

struct Gasto: Identifiable, Codable {
    let _id: String?
    let _rev: String?
    var id: Int
    var nome: String
    var nome_familia: String
    let valor: Double
    let mes: String
    let acesso: String
    let forma_pgt: String
    let tipo_gasto: String
    let data: String //"2024"
}

struct GastoRemove: Hashable, Codable{
    let _id: String?
    let _rev: String?
}

struct APIGeral: Hashable, Codable {
    var id: Int
    var nome: String
    var nome_familia: String
    let valor: Double
    let mes: String
    let acesso: String
    let forma_pgt: String
    let tipo_gasto: String
    let data: String //"2024"
}

// <<-

struct GastoManager {
    var gastosFamilia: [Gasto]
    var groupedGastos: [String: [Gasto]]

    init(gastos: [Gasto]) {
        self.gastosFamilia = gastos
        self.groupedGastos = Dictionary(grouping: gastosFamilia) { $0.tipo_gasto }
    }
    
    init(pessoas: [Gasto]) {
        self.gastosFamilia = pessoas
        self.groupedGastos = Dictionary(grouping: gastosFamilia) { $0.nome }
    }
}




var mes = [
    "01": "Janeiro",
    "02": "Fevereiro", "03": "Março",
    "04": "Abril", "05": "Maio", "06": "Junho",
    "07": "Julho", "08": "Agosto", "09": "Setembro",
    "10": "Outubro", "11": "Novembro", "12": "Dezembro"
]
class GlobalData: ObservableObject {
    @Published var ano: String = "2024"
    @Published var mes: String = "10"
    static let compartilhada = GlobalData()
}

class GlobalMeta: ObservableObject {
    @Published var meta: Double = 0.0
    static let compartilhada = GlobalMeta()
}

class GlobalAPI: ObservableObject {
    @Published var dadosAPI: [Gasto] = []
    static let compartilhada = GlobalAPI()
}
