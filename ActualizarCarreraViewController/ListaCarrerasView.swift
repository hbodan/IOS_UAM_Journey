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

    init() {
        // Configuración de la barra de navegación
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

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
                                    carreraBox(carrera: carrera)
                                }
                            )
                        }
                        .onDelete(perform: eliminarCarreras)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Carreras Universitarias")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    agregarCarreraButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .foregroundColor(.teal)
                }
            }
        }
    }

    // Botón estilizado para agregar carreras
    private var agregarCarreraButton: some View {
        Button(action: agregarCarrera) {
            HStack {
                Image(systemName: "plus")
                Text("Agregar Carrera")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.teal)
            .cornerRadius(10)
            .shadow(color: .teal.opacity(0.4), radius: 4, x: 0, y: 2)
        }
    }

    // Diseño estilizado para cada box de carrera
    @ViewBuilder
    private func carreraBox(carrera: CustomCarrera) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(carrera.nombre ?? "Sin nombre")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            Text(carrera.departamento ?? "Sin departamento")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)

            Divider()
                .background(Color.gray.opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
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
