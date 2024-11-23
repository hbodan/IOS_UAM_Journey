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

    init(carrera: CustomCarrera) {
        self.carrera = carrera
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some View {
        VStack(spacing: 0) {
            // Título fijo
            Text("Actualizar Carrera")
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                .padding(.horizontal)

            // Contenido desplazable
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // Campo: Nombre de la carrera
                    campoConTitulo(
                        titulo: "Nombre de la carrera",
                        texto: Binding($carrera.nombre, replacingNilWith: "")
                    )

                    // Menú desplegable: Departamento o facultad
                    VStack(alignment: .leading, spacing: 10) {
                        subtitulo(titulo: "Departamento/Facultad")
                        Picker("Selecciona un departamento", selection: Binding($carrera.departamento, replacingNilWith: "")) {
                            ForEach(departamentos, id: \.self) { dept in
                                Text(dept).tag(dept)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    }

                    // Campo: Descripción general
                    campoConTitulo(
                        titulo: "Descripción general",
                        texto: Binding($carrera.descripcion, replacingNilWith: ""),
                        esEditorDeTexto: true
                    )

                    // Campo: Plan de estudios detallado
                    campoConTitulo(
                        titulo: "Plan de estudios detallado",
                        texto: Binding($carrera.planEstudios, replacingNilWith: ""),
                        esEditorDeTexto: true
                    )

                    // Campo: Perfil del egresado
                    campoConTitulo(
                        titulo: "Perfil del egresado",
                        texto: Binding($carrera.perfilEgresado, replacingNilWith: ""),
                        esEditorDeTexto: true
                    )

                    // Campo: Oportunidades laborales
                    campoConTitulo(
                        titulo: "Oportunidades laborales",
                        texto: Binding($carrera.oportunidadesLaborales, replacingNilWith: ""),
                        esEditorDeTexto: true
                    )

                    // Campo: Requisitos de ingreso
                    campoConTitulo(
                        titulo: "Requisitos de ingreso",
                        texto: Binding($carrera.requisitosIngreso, replacingNilWith: ""),
                        esEditorDeTexto: true
                    )

                    // Campo: Más información
                    campoConTitulo(
                        titulo: "Más información (URL)",
                        texto: Binding($carrera.masInformacion, replacingNilWith: "")
                    )

                    // Selección de imagen
                    VStack(alignment: .leading, spacing: 10) {
                        subtitulo(titulo: "Imagen representativa")
                        if let imagen = imagenSeleccionada {
                            Image(uiImage: imagen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                        } else if let imagenData = carrera.imagen, let uiImage = UIImage(data: imagenData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    Text("Selecciona una imagen")
                                        .foregroundColor(.gray)
                                )
                        }
                        Button(action: { mostrarImagePicker.toggle() }) {
                            Text("Cambiar Imagen")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    // Botón para guardar cambios
                    Button(action: guardarCambios) {
                        Text("Guardar Cambios")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)

                    // Botón para cancelar
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func guardarCambios() {
        if let imagen = imagenSeleccionada {
            carrera.imagen = imagen.pngData()
        }
        do {
            try viewContext.save()
            print("Cambios guardados correctamente.")
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error al guardar los cambios: \(error.localizedDescription)")
        }
    }

    @ViewBuilder
    private func campoConTitulo(titulo: String, texto: Binding<String>, esEditorDeTexto: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            subtitulo(titulo: titulo)
            if esEditorDeTexto {
                TextEditor(text: texto)
                    .frame(height: 120)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            } else {
                TextField(titulo, text: texto)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            }
        }
    }

    private func subtitulo(titulo: String) -> some View {
        Text(titulo)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.black)
    }
}
