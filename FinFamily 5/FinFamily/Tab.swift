import SwiftUI

struct Tab: View {
    
    var body: some View {
        
       
        TabView{
            Individual()
                .tabItem {
                    Label("Individual", systemImage: "person")
                }
            Familia()
                .tabItem {
                    Label("Familia", systemImage: "person.3")
                }
            Membros()
                .tabItem{
                    Label("Membros", systemImage: "list.bullet")
                }
            Ajustes()
                .tabItem {
                    Label("Ajustes", systemImage: "gear")
                }
        }
        
    }
}
