//
//  LoginViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//
import UIKit

class LoginViewController: UIViewController {

    // MARK: - Elementos de la interfaz
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre de usuario"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar Sesión", for: .normal)
        button.addTarget(nil, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.systemTeal
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Ciclo de vida de la vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Configuración de la interfaz
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // Dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        // Disable autoresizing masks
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            // Username TextField
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            loginButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    // MARK: - Acciones
    
    @objc private func loginButtonTapped() {
        // Validar campos
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Por favor, ingresa tu nombre de usuario.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor, ingresa tu contraseña.")
            return
        }
        
        // Simulación de autenticación
        authenticateUser(username: username, password: password)
    }
    
    private func authenticateUser(username: String, password: String) {
        // Aquí iría la lógica real de autenticación (API call, Firebase, etc.)
        // Por ahora, simularemos una autenticación exitosa
        if username == "usuarioDemo" && password == "contraseñaDemo" {
            // Navegar a la siguiente pantalla o mostrar éxito
            showAlert(title: "Éxito", message: "¡Has iniciado sesión correctamente!")
        } else {
            // Mostrar error de autenticación
            showAlert(title: "Error", message: "Nombre de usuario o contraseña incorrectos.")
        }
    }
    
    // MARK: - Métodos auxiliares
    
    private func showAlert(title: String = "Atención", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Aceptar", style: .default)
        alertController.addAction(acceptAction)
        present(alertController, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
