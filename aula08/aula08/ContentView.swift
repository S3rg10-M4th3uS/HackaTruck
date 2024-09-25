//
//  ContentView.swift
//  aula08
//
//  Created by Turma01-25 on 25/09/24.
//

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let flag: String
    let description: String
}
extension CLLocationCoordinate2D {
    static var brazil: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: -8.583114916350855, longitude: -55.67732238959669)
    }
    static var eua: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 39.534888704482434, longitude:  -102.40695823510838)
    }
}

import SwiftUI
import MapKit

struct ContentView: View {
    
    let array = [Location(name: "Brasil", coordinate: .brazil, flag: "https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/486px-Flag_of_Brazil.svg.png", description: "Eh o BRASIL!"), Location(name: "EUA", coordinate: .eua, flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1600px-Flag_of_the_United_States.svg.png", description: "EH o EUA"), Location(name: "Austrália", coordinate: .australia, flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/510px-Flag_of_Australia_%28converted%29.svg.png", description: "Eh a Australia")]
    
    @State private var isShowingSheet: Location? = nil
    @State var actualLocation: Location = Location(name: "Brasil", coordinate: .brazil, flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/550px-Flag_of_Brazil.svg.png",description: "Is a country")
    @State var position =  MapCameraPosition.region(MKCoordinateRegion(center: .brazil, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                Annotation(actualLocation.name, coordinate: actualLocation.coordinate) {
                    Button {
                 isShowingSheet = actualLocation
                    }label: {
                        Image(systemName: "pin.square.fill")
                    }
                 }
            }.sheet(item: $isShowingSheet) { location in
                SheetView(name: location)
            }
            VStack {
                Group {
                    Text("World map").bold().font(.largeTitle)
                    Text(actualLocation.name)
                    Spacer()
                }
                
                HStack {
                ForEach(array, id: \.id) { location in
                    
                        AsyncImage(url: URL(string: location.flag)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Image(systemName: "photo.fill")
                        }
                        .frame(width: 80, height: 80).onTapGesture {
                            actualLocation = location
                            position = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
                        }
                    }
                }
            }
        }
    }
}
struct SheetView: View {
    var name: Location
    
    var body: some View {
        Text(name.name)
    }
}

#Preview {
    ContentView()
}
