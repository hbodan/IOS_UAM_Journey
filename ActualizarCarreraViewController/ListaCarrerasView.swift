//
//  ListaCarrerasView.swift
//  ProyectoFinalV1
//
//  Created by Carlos Eduardo Gurdian on 23/11/24.
//

import SwiftUI
import CoreData

struct ListaCarrerasView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CustomCarrera.nombre, ascending: true)],
        animation: .default)
    private var carreras: FetchedResults<CustomCarrera>

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            VStack {
                if carreras.isEmpty {
                    Text("No hay carreras registradas.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(carreras) { carrera in
                            NavigationLink(
                                destination: ActualizarCarreraView(carrera: carrera),
                                label: {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(carrera.nombre ?? "Sin nombre")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(carrera.departamento ?? "Sin departamento")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            )
                        }
                        .onDelete(perform: eliminarCarreras)
                    }
                }
            }
            .navigationTitle("Carreras Universitarias")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: agregarCarrera) {
                        Label("Agregar Carrera", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }

    private func agregarCarrera() {
        let nuevaCarrera = CustomCarrera(context: viewContext)
        nuevaCarrera.nombre = "Nueva Carrera"
        nuevaCarrera.departamento = "Nuevo Departamento"
        nuevaCarrera.descripcion = "Descripción predeterminada"
        nuevaCarrera.planEstudios = "Plan de estudios predeterminado"
        nuevaCarrera.perfilEgresado = "Perfil del egresado predeterminado"
        nuevaCarrera.oportunidadesLaborales = "Oportunidades laborales predeterminadas"
        nuevaCarrera.requisitosIngreso = "Requisitos de ingreso predeterminados"
        nuevaCarrera.masInformacion = "Más información predeterminada"

        do {
            try viewContext.save()
        } catch {
            print("Error al guardar la nueva carrera: \(error.localizedDescription)")
        }
    }

    private func eliminarCarreras(offsets: IndexSet) {
        offsets.map { carreras[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            print("Error al eliminar las carreras: \(error.localizedDescription)")
        }
    }
}
