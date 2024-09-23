//
//  Lista.swift
//  aula06
//
//  Created by Turma01-25 on 23/09/24.
//

import SwiftUI

struct Lista: View {
    var body: some View {
        Group {
            List {
                LabeledContent("App Version", value: "16.7")
                Text("Item")
            }.navigationTitle(Text("Lista"))
        }
        
    }
}

#Preview {
    Lista()
}
