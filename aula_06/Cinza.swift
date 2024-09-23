//
//  Cinza.swift
//  aula06
//
//  Created by Turma01-25 on 23/09/24.
//

import SwiftUI

struct Cinza: View {
    var body: some View {
        VStack {
            ZStack {
                Color.gray.ignoresSafeArea().frame(height: 1000)
                Circle().frame(width: 280)
                Image(systemName: "paintpalette").resizable().scaledToFit().frame(width: 200).foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    Cinza()
}
