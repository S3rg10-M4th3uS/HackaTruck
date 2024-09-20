//
//  ContentView.swift
//  aula04
//
//  Created by Turma01-25 on 20/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColour: Color = .normal
    @State private var peso: Double?
    @State private var altura: Double?
    @State private var densidade: String = ""
    
    var body: some View {
        ZStack {
            backgroundColour.ignoresSafeArea()
            VStack {
                Group{
                    Text("Calculadora de IMC").font(.largeTitle)
                    TextField("Insira um peso", value: $peso, formatter: NumberFormatter()).keyboardType(.decimalPad).textContentType(.oneTimeCode).padding().background(Color.white).cornerRadius(10)
                    TextField("Insira uma altura", value: $altura, formatter:NumberFormatter()).keyboardType(.decimalPad).textContentType(.oneTimeCode).padding().background(Color.white).cornerRadius(10)
                    
                }.padding(15).frame(width: 400)
                Button(action: {
                    let res = (peso ?? 76) / ((altura ?? 1.85)*(altura ?? 1.85))
                    if res < 18.5 {
                        backgroundColour = .baixoPeso
                        densidade = "Baixo peso"
                    } else if res >= 18.5 || res <= 24.99 {
                        backgroundColour = .normal
                        densidade = "Normal"
                    } else if res >= 25 || res <= 29.99 {
                        backgroundColour = .sobrepeso
                        densidade = "Sobrepeso"
                    } else if res >= 25 || res <= 29.99 {
                        backgroundColour = .obesidade
                        densidade = "Obesidade"
                    }
                }, label: {
                    Text("Calcular")
                }).buttonStyle(.borderedProminent).controlSize(.large)
                Text("\(altura ?? 1)").padding(110).font(.largeTitle).foregroundColor(.white)
                Image(.image).resizable().frame(width:430,height: 200)
                

            }
            
        }
    }
}

#Preview {
    ContentView()
}
