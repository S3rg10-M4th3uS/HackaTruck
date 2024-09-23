//
//  ContentView.swift
//  aula06
//
//  Created by Turma01-25 on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                TabView {
                    Rosa().tabItem { Label("Rosa", systemImage: "paintbrush") }
                    Azul().tabItem { Label("Azul", systemImage: "paintbrush.pointed") }
                    Cinza().tabItem { Label("Cinza", systemImage: "paintpalette") }
                    Lista().tabItem { Label("Lista", systemImage: "list.bullet") }
                }.onAppear() {
                    UITabBar.appearance().backgroundColor = .white
                }
        }
        
    }
}

#Preview {
    ContentView()
}
