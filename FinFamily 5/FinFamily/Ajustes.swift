import SwiftUI

struct Ajustes: View{
        
    var body: some View{
        NavigationStack{
            
            VStack{
                List(content: {
                    NavigationLink("Modificar Meta",destination: ModificarMeta())
                    NavigationLink("Notificações",destination: Notifications())
                    NavigationLink("Adicionar Familiar",destination: Notifications())
                    NavigationLink("Modo Escuro",destination: Notifications())
                    NavigationLink("Redefinir Senha",destination: Notifications())
                    
                    
                    
                })
                .navigationTitle("Ajustes")
            }
        }
    }
}
#Preview {
    Ajustes()
}

