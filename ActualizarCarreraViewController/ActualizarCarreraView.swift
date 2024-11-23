//
//  ActualizarCarreraView.swift
//  ProyectoFinalV1
//
//  Created by Carlos Eduardo Gurdian on 23/11/24.
//

import SwiftUI
import CoreData

struct ActualizarCarreraView: View {
    @ObservedObject var carrera: CustomCarrera
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var imagenSeleccionada: UIImage?
    @State private var mostrarImagePicker = false

    let departamentos = ["Ingeniería", "Ciencias de la Salud", "Ciencias Jurídicas", "Administración"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Actualizar Carrera")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)

                // Campo: Nombre de la carrera
                campoConTitulo(titulo: "Nombre de la carrera", texto: Binding($carrera.nombre, replacingNilWith: ""))

                // Menú desplegable: Departamento o facultad
                VStack(alignment: .leading, spacing: 5) {
                    Text("Departamento/Facultad")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Picker("Selecciona un departamento", selection: Binding($carrera.departamento, replacingNilWith: "")) {
                        ForEach(departamentos, id: \.self) { dept in
                            Text(dept).tag(dept)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }

                // Campo: Descripción general
                campoConTitulo(titulo: "Descripción general", texto: Binding($carrera.descripcion, replacingNilWith: ""), esEditorDeTexto: true)

                // Campo: Plan de estudios detallado
                campoConTitulo(titulo: "Plan de estudios detallado", texto: Binding($carrera.planEstudios, replacingNilWith: ""), esEditorDeTexto: true)

                // Campo: Perfil del egresado
                campoConTitulo(titulo: "Perfil del egresado", texto: Binding($carrera.perfilEgresado, replacingNilWith: ""), esEditorDeTexto: true)

                // Campo: Oportunidades laborales
                campoConTitulo(titulo: "Oportunidades laborales", texto: Binding($carrera.oportunidadesLaborales, replacingNilWith: ""), esEditorDeTexto: true)

                // Campo: Requisitos de ingreso
                campoConTitulo(titulo: "Requisitos de ingreso", texto: Binding($carrera.requisitosIngreso, replacingNilWith: ""), esEditorDeTexto: true)

                // Campo: Más información
                campoConTitulo(titulo: "Más información (URL)", texto: Binding($carrera.masInformacion, replacingNilWith: ""))

                // Selección de imagen
                VStack(alignment: .leading, spacing: 5) {
                    Text("Imagen representativa")
                        .font(.headline)
                        .foregroundColor(.gray)
                    if let imagen = imagenSeleccionada {
                        Image(uiImage: imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(8)
                    } else if let imagenData = carrera.imagen, let uiImage = UIImage(data: imagenData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(Color(UIColor.systemGray6))
                            .frame(height: 150)
                            .cornerRadius(8)
                            .overlay(
                                Text("Selecciona una imagen")
                                    .foregroundColor(.gray)
                            )
                    }
                    Button(action: { mostrarImagePicker.toggle() }) {
                        Text("Cambiar Imagen")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                // Botón para guardar cambios
                Button(action: guardarCambios) {
                    Text("Guardar Cambios")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                // Botón para cancelar
                Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss() // Cierra la vista sin guardar
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        .sheet(isPresented: $mostrarImagePicker) {
            //ImagePicker(selectedImage: $imagenSeleccionada)
        }
    }

    // Función para guardar cambios
    private func guardarCambios() {
        if let imagen = imagenSeleccionada {
            carrera.imagen = imagen.pngData()
        }
        do {
            try viewContext.save()
            print("Cambios guardados correctamente.")
            presentationMode.wrappedValue.dismiss() // Cierra la vista tras guardar
        } catch {
            print("Error al guardar los cambios: \(error.localizedDescription)")
        }
    }

    // Componente reutilizable para un campo con título
    @ViewBuilder
    private func campoConTitulo(titulo: String, texto: Binding<String>, esEditorDeTexto: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(.gray)
            if esEditorDeTexto {
                TextEditor(text: texto)
                    .frame(height: 100)
                    .padding(10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                TextField(titulo, text: texto)
                    .padding(10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
        }
        .padding(.vertical, 5)
    }
}
