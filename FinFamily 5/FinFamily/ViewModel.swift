//
//  ViewModel.swift
//  FinFamily
//
//  Created by Turma01-5 on 15/10/24.
//

import Foundation
func criarGasto(gasto: Gasto) {
    // URL da sua API
    guard let url = URL(string: "http://10.87.154.42:1880/gasto") else {
        print("URL inválida")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Codificando o gasto para JSON
    do {
        let jsonData = try JSONEncoder().encode(gasto)
        request.httpBody = jsonData
    } catch {
        print("Erro ao codificar gasto: \(error)")
        return
    }

    // Fazendo a requisição
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Erro na requisição: \(error)")
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Resposta não foi 200: \(response!)")
            return
        }

        // Manipule a resposta se necessário
        if let data = data {
            // Se precisar, você pode decodificar a resposta aqui
            print("Resposta recebida: \(String(data: data, encoding: .utf8) ?? "")")
        }
    }

    task.resume()
}
class ViewModel: ObservableObject{
        @Published var gastos: [Gasto] = []
        
        func fetch(){
            let task = URLSession.shared.dataTask(with: URL(string: "http://10.87.154.42:1880/lerFamilia")!){
                data, _, error in
                do{
                    self.gastos = try JSONDecoder().decode([Gasto].self, from: data!)
                }catch{
                    print(error)
                }
            }
            task.resume()
        }
    
    
    func removeItem(withId id: String, rev: String, completion: @escaping (Bool, Error?) -> Void) {
        
        
        let urlString = "http://10.87.154.42:1880/delete/"
        guard let url = URL(string: urlString) else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var gr = GastoRemove(_id: id, _rev: rev)
        
        do{
            var json = try JSONEncoder().encode(gr)
            
            request.httpBody = json
            
        }catch{
            print(error)
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            
        }
        
        task.resume()
    }
    
}

class ViewModelAux: ObservableObject{
    @Published var apiGeral: [APIGeral] = []
        
        func fetch(){
            let task = URLSession.shared.dataTask(with: URL(string: "http://10.87.154.42:1880/lerFamilia")!){
                data, _, error in
                do{
                    self.apiGeral = try JSONDecoder().decode([APIGeral].self, from: data!)
                }catch{
                    print(error)
                }
            }
            task.resume()
        }
    
}





