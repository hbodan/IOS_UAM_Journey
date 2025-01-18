//
//  RegisterViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//

import UIKit
import SwiftUI



class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    let FacultadesyCarreras = [
        "Ciencias Administrativas y Económicas",
        "ciencias Jurídicas, Humanidades y Relaciones Internacionales",
        "Ciencias Médicas",
        "Ingeniería y Arquitectura",
        "Marketing, Diseño y Ciencias de la Comunicacion",
        "Odontología",
        "UAM College"
    ]

    let facultadPickerView = UIPickerView()
    let facultadTextField = UITextField()
    let carreraTextField = UITextField()
    let pdfLabel = UILabel()
    
    let descripcionGeneralTextView = UITextView()
    let perfilEgresadoTextView = UITextView()
    let oportunidadesLaboralesTextView = UITextView()
    let requisitosIngresoTextView = UITextView()
    let enlaceInformacionTextView = UITextView()
    
    let perfilEgresadoPlaceHolder = UILabel()
    let descripcionGeneralPlaceHolder = UILabel()
    let oportunidadesLaboralesPlaceHolder = UILabel()
    let requisitosIngresoPlaceHolder = UILabel()
    let enlaceInformacionPlaceHolder = UILabel()
    
    let registerButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Color de fondo
        self.view.backgroundColor = UIColor(red: 128/255, green: 204/255, blue: 198/255, alpha: 1)
        
        // Configurar cada UITextView y su placeholder
        configureTextView(descripcionGeneralTextView, placeholder: descripcionGeneralPlaceHolder, placeholderText: "Ingrese una descripción general")
        configureTextView(perfilEgresadoTextView, placeholder: perfilEgresadoPlaceHolder, placeholderText: "Ingrese el perfil del egresado")
        configureTextView(oportunidadesLaboralesTextView, placeholder: oportunidadesLaboralesPlaceHolder, placeholderText: "Ingrese las oportunidades laborales")
        configureTextView(requisitosIngresoTextView, placeholder: requisitosIngresoPlaceHolder, placeholderText: "Ingrese los requisitos de ingreso")
        configureTextView(enlaceInformacionTextView, placeholder: enlaceInformacionPlaceHolder, placeholderText: "Ingrese un enlace")
        
        // Configuración del ScrollView
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            //scrollView.showsVerticalScrollIndicator = true
            self.view.addSubview(scrollView)
        
        //Contenedor dentro del Scroll
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        //scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000) // Altura estimada

        
        //Configuración de los elementos en contenView
        configureForm(in: contentView)
        
        // Configuración del Auto layout de ScrollView y ContentView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // Ajusta el contentView para incluir todo el contenido
            //contentView.bottomAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20)
        ])

        //registrar notifiaciones para el teclado
        registerKeyboardNotifications()
        
        // Forzar actualización de la vista
        //contentView.layoutIfNeeded()
        //scrollView.layoutIfNeeded()
        
        
    }
    
    //Mark: - UIpikerView DataSource y Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FacultadesyCarreras.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FacultadesyCarreras[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Actualizar el campo de texto con la facultad seleccionada
        facultadTextField.text = FacultadesyCarreras[row]
        facultadTextField.resignFirstResponder() // Cerrar el picker
    }
    
    // Ajusta automáticamente la altura del UITextView y gestiona los placeholders
    func textViewDidChange(_ textView: UITextView) {
        // Ajuste automático de altura
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        if let heightConstraint = textView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = size.height
        }

        // Mostrar/ocultar el placeholder según el contenido
        if textView == descripcionGeneralTextView {
            descripcionGeneralPlaceHolder.isHidden = !textView.text.isEmpty
        } else if textView == perfilEgresadoTextView {
            perfilEgresadoPlaceHolder.isHidden = !textView.text.isEmpty
        } else if textView == oportunidadesLaboralesTextView {
            oportunidadesLaboralesPlaceHolder.isHidden = !textView.text.isEmpty
        } else if textView == requisitosIngresoTextView {
            requisitosIngresoPlaceHolder.isHidden = !textView.text.isEmpty
        }else if textView == enlaceInformacionTextView {
            enlaceInformacionPlaceHolder.isHidden = !textView.text.isEmpty
        }

    }

    
    // Configuración genérica de UITextView con placeholder
    func configureTextView(_ textView: UITextView, placeholder: UILabel, placeholderText: String) {
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self

        placeholder.text = placeholderText
        placeholder.font = UIFont.systemFont(ofSize: 16)
        placeholder.textColor = .lightGray
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholder)

        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholder.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5)
        ])
    }
    func configureForm(in contentView: UIView){
        //Titulo
        let titleLabel = UILabel()
        titleLabel.text = "Registro"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        
        //Imagen Jaguar
        let imageView = UIImageView()
        imageView.image = UIImage(named: "jaguar_Logo-removebg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        //boton regitrar
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
                contentView.addSubview(facultadTextField)
                
                //Configurar el campo de texto para la carrera
                carreraTextField.placeholder = "Escriba una carrera"
                carreraTextField.borderStyle = .roundedRect
                carreraTextField.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(carreraTextField)
                
                // Configuracion UIPickerView para facultad y la carrera
                facultadPickerView.delegate = self
                facultadPickerView.dataSource = self
                
                //Asociar los UIPicker con los UITextField
                facultadTextField.inputView = facultadPickerView
                
                //Boton para cerrar el UIPicker
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicking))
                toolbar.setItems([doneButton], animated: true)
                
                facultadTextField.inputAccessoryView = toolbar
                
                //Campos de texto Descripción
                descripcionGeneralTextView.layer.borderColor = UIColor.gray.cgColor
                descripcionGeneralTextView.layer.borderWidth = 1
                descripcionGeneralTextView.layer.cornerRadius = 8
                descripcionGeneralTextView.font = UIFont.systemFont(ofSize: 16)
                descripcionGeneralTextView.translatesAutoresizingMaskIntoConstraints = false
                descripcionGeneralTextView.delegate = self
                contentView.addSubview(descripcionGeneralTextView)
                
                //Place Holder para la descripción general
                descripcionGeneralPlaceHolder.text = "Ingrese una descripción general"
                descripcionGeneralPlaceHolder.font = UIFont.systemFont(ofSize: 16)
                descripcionGeneralPlaceHolder.textColor = .lightGray
                descripcionGeneralPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
                descripcionGeneralTextView.addSubview(descripcionGeneralPlaceHolder)
                
                //Botón para subir plan de estudios pdf.
                let uploadPDFButton = UIButton(type: .system)
                uploadPDFButton.setTitle("Subir plan de estudio (PDF)", for: .normal)
                uploadPDFButton.backgroundColor = .systemBlue
                uploadPDFButton.setTitleColor(.white, for: .normal)
                uploadPDFButton.layer.cornerRadius = 8
                uploadPDFButton.translatesAutoresizingMaskIntoConstraints = false
                uploadPDFButton.addTarget(self, action: #selector(selectPDF), for: .touchUpInside)
                contentView.addSubview(uploadPDFButton)
                
                //label para mostrar el archivo escogido
                
                pdfLabel.text = "Ningún archivo seleccionado"
                pdfLabel.font = UIFont.systemFont(ofSize: 16)
                pdfLabel.textColor = .black
                pdfLabel.textAlignment = .center
                pdfLabel.layer.borderColor = UIColor.white.cgColor
                pdfLabel.layer.borderWidth = 2
                pdfLabel.layer.cornerRadius = 8
                pdfLabel.clipsToBounds = true
                pdfLabel.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(pdfLabel)
                
                //Campos de texto perfil del egresado
                perfilEgresadoTextView.layer.borderColor = UIColor.gray.cgColor
                perfilEgresadoTextView.layer.borderWidth = 1
                perfilEgresadoTextView.layer.cornerRadius = 8
                perfilEgresadoTextView.font = UIFont.systemFont(ofSize: 16)
                perfilEgresadoTextView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(perfilEgresadoTextView)
                
                //Place holder para perfil del egresado
                perfilEgresadoPlaceHolder.text = "Ingrese el perfil del egresado"
                perfilEgresadoPlaceHolder.font = UIFont.systemFont(ofSize: 16)
                perfilEgresadoPlaceHolder.textColor = .lightGray
                perfilEgresadoPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
                perfilEgresadoTextView.addSubview(perfilEgresadoPlaceHolder)
                
                //Campos de texto de oportunidades laborales
                oportunidadesLaboralesTextView.layer.borderColor = UIColor.gray.cgColor
                oportunidadesLaboralesTextView.layer.borderWidth = 1
                oportunidadesLaboralesTextView.layer.cornerRadius = 8
                oportunidadesLaboralesTextView.font = UIFont.systemFont(ofSize: 16)
                oportunidadesLaboralesTextView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(oportunidadesLaboralesTextView)
                
                //Place Holder para la Oportunidades laborales
                oportunidadesLaboralesPlaceHolder.text = "Ingrese las oportunidades laboreles"
                oportunidadesLaboralesPlaceHolder.font = UIFont.systemFont(ofSize: 16)
                oportunidadesLaboralesPlaceHolder.textColor = .lightGray
                oportunidadesLaboralesPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
                oportunidadesLaboralesTextView.addSubview(oportunidadesLaboralesPlaceHolder)

                //Campo de Requisito de ingreso
                requisitosIngresoTextView.layer.borderColor = UIColor.gray.cgColor
                requisitosIngresoTextView.layer.borderWidth = 1
                requisitosIngresoTextView.layer.cornerRadius = 8
                requisitosIngresoTextView.font = UIFont.systemFont(ofSize: 16)
                requisitosIngresoTextView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(requisitosIngresoTextView)
                
                //Place holder de Requisitos de ingreso
                requisitosIngresoPlaceHolder.text = "Ingresar los requisitos de ingreso"
                requisitosIngresoPlaceHolder.font = UIFont.systemFont(ofSize: 16)
                requisitosIngresoPlaceHolder.textColor = .lightGray
                requisitosIngresoPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
                requisitosIngresoTextView.addSubview(requisitosIngresoPlaceHolder)
        
                //Campo de enlace Información
                enlaceInformacionTextView.layer.borderColor = UIColor.gray.cgColor
                enlaceInformacionTextView.layer.borderWidth = 1
                enlaceInformacionTextView.layer.cornerRadius = 8
                enlaceInformacionTextView.font = UIFont.systemFont(ofSize: 16)
                enlaceInformacionTextView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(enlaceInformacionTextView)
                
                //Place holder enlace Información
                enlaceInformacionPlaceHolder.text = "Ingresar el enlace"
                enlaceInformacionPlaceHolder.font = UIFont.systemFont(ofSize: 16)
                enlaceInformacionPlaceHolder.textColor = .lightGray
                enlaceInformacionPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
                enlaceInformacionTextView.addSubview(enlaceInformacionPlaceHolder)
        
                
                //Configurar AutoLayout
                NSLayoutConstraint.activate([
                    //Titulo
                    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    
                    //Imagen
                    imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                    imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 150),
                    imageView.heightAnchor.constraint(equalToConstant: 150),
                    
                    //LabelText listado de Facultad
                    facultadTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                    facultadTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    facultadTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    carreraTextField.heightAnchor.constraint(equalToConstant: 40),
                    
                    //LabelText listado de Carreras
                    carreraTextField.topAnchor.constraint(equalTo: facultadTextField.bottomAnchor, constant: 20),
                    carreraTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    carreraTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    carreraTextField.heightAnchor.constraint(equalToConstant: 40),
                    
                    //TextLabel de descripción
                    descripcionGeneralTextView.topAnchor.constraint(equalTo: carreraTextField.bottomAnchor, constant: 20),
                    descripcionGeneralTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    descripcionGeneralTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    descripcionGeneralTextView.heightAnchor.constraint(equalToConstant: 100),
                    
                    //Place Holder Descripción
                    descripcionGeneralPlaceHolder.topAnchor.constraint(equalTo: descripcionGeneralTextView.topAnchor, constant: 8),
                    descripcionGeneralPlaceHolder.leadingAnchor.constraint(equalTo: descripcionGeneralTextView.leadingAnchor, constant: 5),
                    
                    //Boton de upload
                    uploadPDFButton.topAnchor.constraint(equalTo: descripcionGeneralTextView.bottomAnchor, constant: 20),
                    uploadPDFButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    uploadPDFButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    uploadPDFButton.heightAnchor.constraint(equalToConstant: 40),
                    
                    //PDF label
                    pdfLabel.topAnchor.constraint(equalTo: uploadPDFButton.bottomAnchor, constant: 10),
                    pdfLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    pdfLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    
                    
                    //Perfil del egresado.
                    perfilEgresadoTextView.topAnchor.constraint(equalTo: pdfLabel.bottomAnchor, constant: 20),
                    perfilEgresadoTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    perfilEgresadoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    perfilEgresadoTextView.heightAnchor.constraint(equalToConstant: 100),
                    
                    //Place Holder egresado
                    perfilEgresadoPlaceHolder.topAnchor.constraint(equalTo: perfilEgresadoTextView.topAnchor, constant: 8),
                    perfilEgresadoPlaceHolder.leadingAnchor.constraint(equalTo: perfilEgresadoTextView.leadingAnchor, constant: 5),
                    
                    //Oportunidades laborales.
                    oportunidadesLaboralesTextView.topAnchor.constraint(equalTo: perfilEgresadoTextView.bottomAnchor, constant: 20),
                    oportunidadesLaboralesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    oportunidadesLaboralesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    oportunidadesLaboralesTextView.heightAnchor.constraint(equalToConstant: 100),
                    
                    //Place Holder oportunidades laborales
                    oportunidadesLaboralesPlaceHolder.topAnchor.constraint(equalTo: oportunidadesLaboralesTextView.topAnchor, constant: 8),
                    oportunidadesLaboralesPlaceHolder.leadingAnchor.constraint(equalTo: oportunidadesLaboralesTextView.leadingAnchor, constant: 5),
                    
                    //Requisitos de ingresos.
                    requisitosIngresoTextView.topAnchor.constraint(equalTo: oportunidadesLaboralesTextView.bottomAnchor, constant: 20),
                    requisitosIngresoTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    requisitosIngresoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    requisitosIngresoTextView.heightAnchor.constraint(equalToConstant: 100),
                    
                    //Place Holder oportunidades laborales
                    requisitosIngresoPlaceHolder.topAnchor.constraint(equalTo: requisitosIngresoTextView.topAnchor, constant: 8),
                    requisitosIngresoPlaceHolder.leadingAnchor.constraint(equalTo: requisitosIngresoTextView.leadingAnchor, constant: 5),
                    
                    //Requisitos de ingresos.
                    enlaceInformacionTextView.topAnchor.constraint(equalTo: requisitosIngresoTextView.bottomAnchor, constant: 20),
                    enlaceInformacionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    enlaceInformacionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    enlaceInformacionTextView.heightAnchor.constraint(equalToConstant: 50),
                    
                    //Place Holder oportunidades laborales
                    enlaceInformacionPlaceHolder.topAnchor.constraint(equalTo: enlaceInformacionTextView.topAnchor, constant: 8),
                    enlaceInformacionPlaceHolder.leadingAnchor.constraint(equalTo: enlaceInformacionTextView.leadingAnchor, constant: 5),
                    
                    // Botón Registrar
                    registerButton.topAnchor.constraint(equalTo: enlaceInformacionTextView.bottomAnchor, constant: 20),
                    registerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    registerButton.widthAnchor.constraint(equalToConstant: 100),
                    registerButton.heightAnchor.constraint(equalToConstant: 40),
                    registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
                ])
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else { return }
        
        // Ajustar el contenido del scrollView
        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight
        
        // Desplazar al elemento activo
        if let activeField = view.currentFirstResponder {
            let visibleRect = self.view.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0))
            if !visibleRect.contains(activeField.frame.origin) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        guard let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else { return }
        
        // Restablecer el contenido del scrollView
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }

    
    //Metodo para cerrar el UIpickerView cuando se presiona el boton "Done"
    @objc func donePicking() {
        facultadTextField.resignFirstResponder()
        carreraTextField.resignFirstResponder()
    }
    
    
    @objc func selectPDF() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.pdf"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
}

extension RegisterViewController: UIDocumentPickerDelegate {
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }
            pdfLabel.text = "Archivo: \(selectedFileURL.lastPathComponent)"
        }
    }

extension UIView {
    var currentFirstResponder: UIView? {
        if self.isFirstResponder {
            return self
        }
        for subview in self.subviews {
            if let responder = subview.currentFirstResponder {
                return responder
            }
        }
        return nil
    }
}
