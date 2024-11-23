//
//  ViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/15/24.
//
import UIKit
import SwiftUI
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar imagen de fondo
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "descarga")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Configurar imagen del logo
        let logoImage = UIImageView(image: UIImage(named: "image"))
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImage)
        
        // Configurar texto "The Journey Awaits!"
        let journeyLabel = UILabel()
        journeyLabel.text = "The Journey Awaits!"
        journeyLabel.textColor = .white
        journeyLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        journeyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(journeyLabel)
        
        // Configurar botón de Login
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemTeal, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        // Configurar botón de Register
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.systemTeal, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        registerButton.backgroundColor = .white
        registerButton.layer.cornerRadius = 5
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside)
        self.view.addSubview(registerButton)
        
        // Añadir restricciones
        NSLayoutConstraint.activate([
            // Restricciones para el logo
            logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 230),
            
            // Restricciones para el texto "The Journey Awaits!"
            journeyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            journeyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            // Restricciones para el botón de Login
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 630),
            loginButton.widthAnchor.constraint(equalToConstant: 315),
            loginButton.heightAnchor.constraint(equalToConstant: 51),
            
            // Restricciones para el botón de Register
            registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            registerButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 551),
            registerButton.widthAnchor.constraint(equalToConstant: 315),
            registerButton.heightAnchor.constraint(equalToConstant: 51),
        ])
    }
    
    @objc func navigateToLogin() {
        //let loginVC = LoginViewController()
        //self.present(loginVC, animated: true, completion: nil)
        // Crear una instancia del contexto de Core Data
        let viewContext = PersistenceController.shared.container.viewContext


           // Crear la vista SwiftUI
           let listaCarrerasView = ListaCarrerasView()
               .environment(\.managedObjectContext, viewContext)

           // Crear un UIHostingController para la vista SwiftUI
           let hostingController = UIHostingController(rootView: listaCarrerasView)

           // Presentar el hostingController
           self.present(hostingController, animated: true, completion: nil)
    }
    
    @objc func navigateToRegister() {
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)
    }
}
