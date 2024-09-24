//
//  ContentView.swift
//  ListaSpotify
//
//  Created by Turma01-25 on 24/09/24.
//

import SwiftUI

struct Music: Hashable {
    var nome: String
    var artistas: String
    var imagem: String
}

struct ContentView: View {
    @State var musicas  = [
        Music( nome: "When We Were Young", artistas: "Adele", imagem: "https://i.scdn.co/image/ab67616d0000b27347ce408fb4926d69da6713c2"),
        Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7"), Music(nome: "Somewhere Only We Know", artistas: "Keane", imagem: "https://i.scdn.co/image/ab67616d0000b273f806a7942ff458ea7653edd7")]
    var body: some View {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    VStack (){
                        AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHmHUrlaJRAoLtx9DQSIQPi5Noe2MEQeyiXg&s")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Image(systemName: "photo.fill")
                        }
                        .frame(width: 220, height: 220)
                        
                        ScrollView {
                        ForEach(musicas, id:\.self) { m in
                            
                            HStack {
                                NavigationLink(destination: MusicView(mus: m)) {
                                AsyncImage(url: URL(string: m.imagem)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }
                                .frame(width: 80, height: 60)
                                
                                VStack(alignment: .leading) {
                                    Text(m.nome).foregroundStyle(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(m.artistas).foregroundStyle(.white).fontWeight(.light)
                                    
                                }
                                Spacer()
                                Image(systemName: "ellipsis").frame(width: 60).foregroundStyle(.white)
                            }
                            }
                        }
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
