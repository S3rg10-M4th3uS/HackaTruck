//
//  Rosa.swift
//  aula06
//
//  Created by Turma01-25 on 23/09/24.
//

import SwiftUI

struct Rosa: View {
    var body: some View {
        VStack {
            ZStack {
                Color.pink.ignoresSafeArea().frame(height: 1000)
                Circle().frame(width: 280)
                Image(systemName: "paintbrush").resizable().scaledToFit().frame(width: 200).foregroundStyle(.pink)            }
        }
    }
}

#Preview {
    Rosa()
}
