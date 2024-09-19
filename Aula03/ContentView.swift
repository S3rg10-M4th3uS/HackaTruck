//
//  ContentView.swift
//  Aula03
//
//  Created by Turma01-25 on 19/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = "Sérgio"
    @State var showingAlert = false
    
    var body: some View {
        ZStack{
            Image(.image).resizable().frame(width: 900, height: 900).opacity(0.2)
        VStack() {
            VStack(){
                Text("Bem vindo, \(name)").font(.largeTitle).padding()
                Text("Sérgio")
            }.padding().frame(height: 100)
            VStack {
                Image(.image2).resizable().frame(width: 250, height: 100)
                Image(.image1).resizable().frame(width: 250, height: 100)
            }.padding().frame(height: 600)
            VStack(){
                        Button("Entrar") {
                                    showingAlert = true
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("ALERTA !"), message: Text("Você irá iniciar o desafio de aula agora!"), dismissButton: .default(Text("Vamos lá!")))
                                }
            }.padding()
            }
            }
    }
}

#Preview {
    ContentView()
}
