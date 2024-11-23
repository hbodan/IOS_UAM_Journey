//
//  ContentView.swift
//  ProyectoFinalV1
//
//  Created by Carlos Eduardo Gurdian on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Configura la vista principal como ListaCarrerasView
        ListaCarrerasView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
