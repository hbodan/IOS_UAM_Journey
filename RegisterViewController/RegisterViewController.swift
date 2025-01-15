//
//  RegisterViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//
import UIKit
import SwiftUI

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let FacultadesyCarreras = [
        "Ciencias Administrativas y Económicas":
            ["administracion de Empresas",
             "Contabilidad y Finanzas",
            "Economia Empresarial",
            "Negocios Internacionales"
            ],
        "ciencias Jurídicas, Humanidades y Relaciones Internacionales":
            ["Derecho",
             "Diplomacia y relaciones internacionales"
            ],
        "Ciencias Médicas":
            ["Medicina",
             "Psicologia",
             "Nutricion"
            ],
        "Ingeniería y Arquitectura":
            ["Arquitectura",
            "Ingenieria Civil",
            "Ingenieria Industrial",
            "Ingenieria En sistemas de informacion"],
        "Marketing, Diseño y Ciencias de la Comunicacion":
            ["Marketing y publicidad",
            "Disenio y comunicacion visual",
            "Comunicacion y relaciones publicas"],
        "Odontología":["Odontologia"],
        "UAM College":
            ["Strategic Marketing",
             "Global Finance",
             "Global Management",
             "Internacional Development"
            ]
    ]
    
    var facultades: [String] { Array(FacultadesyCarreras.keys) }
    var carreras: [String] = []
    
    let facultadPickerView = UIPickerView()
    let carreraPickerView = UIPickerView()
    let facultadTextField = UITextField()
    let carreraTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Color de fondo
        self.view.backgroundColor = UIColor(red: 128/255, green: 204/255, blue: 198/255, alpha: 1)
        
        
        //Titulo
        let titleLabel = UILabel()
        titleLabel.text = "Registro"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        
        //Imagen Jaguar
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        //ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        //Contenedor dentro del Scroll
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        //Configuración del Auto layout de Scroll y Content
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        /*//Campos de textos
        let textField = UITextField()
        textField.placeholder = "Nombre de la carrera"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)*/
        
        //boton regitrar
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemGray
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(registerButton)
        
        
        //Configurar el campo de texto para facultad
        facultadTextField.placeholder = "Selecciona una facultad"
        facultadTextField.borderStyle = .roundedRect
        facultadTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(facultadTextField)
        
        //Configurar el campo de texto para la carrera
        carreraTextField.placeholder = "Selecciona una carrera"
        carreraTextField.borderStyle = .roundedRect
        carreraTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(carreraTextField)
        
        // Configuracion UIPickerView para facultad y la carrera
        facultadPickerView.delegate = self
        facultadPickerView.dataSource = self
        carreraPickerView.delegate = self
        carreraPickerView.dataSource = self
        
        //Asociar los UIPicker con los UITextField
        facultadTextField.inputView = facultadPickerView
        carreraTextField.inputView = carreraPickerView
        
        //Boton para cerrar el UIPicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicking))
        toolbar.setItems([doneButton], animated: true)
        
        facultadTextField.inputAccessoryView = toolbar
        carreraTextField.inputAccessoryView = toolbar

        //Configurar AutoLayout
        NSLayoutConstraint.activate([
            //Titulo
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            //Imagen
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            
            // Botón Registrar
            registerButton.topAnchor.constraint(equalTo: carreraTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 100),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            
            facultadTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            facultadTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            facultadTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            carreraTextField.heightAnchor.constraint(equalToConstant: 40),
            
            carreraTextField.topAnchor.constraint(equalTo: facultadTextField.bottomAnchor, constant: 20),
            carreraTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            carreraTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            carreraTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //Mark: - UIpikerView DataSource y Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == facultadPickerView {
            return facultades.count
        }else{
            return carreras.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == facultadPickerView {
            return facultades[row]
        }else{
            return carreras[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == facultadPickerView {
            let facultadSeleccionada = facultades[row]
            facultadTextField.text = facultadSeleccionada
            
            //Actualizar la lista de las carreras segun la facultad seleccionada
            carreras = FacultadesyCarreras[facultadSeleccionada] ?? []
            carreraTextField.text = ""
            carreraPickerView.reloadAllComponents()
        }else{
            carreraTextField.text = carreras[row]
        }
    }
    
    //Metodo para cerrar el UIpickerView cuando se presiona el boton "Done"
    @objc func donePicking() {
        facultadTextField.resignFirstResponder()
        carreraTextField.resignFirstResponder()
    }
    
}
