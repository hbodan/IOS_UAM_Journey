//
//  RegisterViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//
import UIKit

class RegisterViewController: UIViewController {

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

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Correo electrónico"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
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

    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirmar contraseña"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrarse", for: .normal)
        button.addTarget(nil, action: #selector(registerButtonTapped), for: .touchUpInside)
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
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(registerButton)
        
        // Ocultar el teclado al tocar fuera de los campos
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupConstraints() {
        // Desactivar autoresizing masks
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        NSLayoutConstraint.activate([
            // Username TextField
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),

            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            // Confirm Password TextField
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            // Register Button
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 25),
            registerButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    // MARK: - Acciones

    @objc private func registerButtonTapped() {
        // Validar campos
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Por favor, ingresa un nombre de usuario.")
            return
        }
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Por favor, ingresa un correo electrónico válido.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor, ingresa una contraseña.")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text, password == confirmPassword else {
            showAlert(message: "Las contraseñas no coinciden.")
            return
        }
        
        // Simulación de registro
        registerUser(username: username, email: email, password: password)
    }

    private func registerUser(username: String, email: String, password: String) {
        // Aquí iría la lógica real de registro (API call, Firebase, etc.)
        // Por ahora, simularemos un registro exitoso
        showAlert(title: "Registro exitoso", message: "¡Bienvenido, \(username)!")
        // Navegar a la siguiente pantalla o actualizar la interfaz
    }

    // MARK: - Métodos auxiliares

    private func isValidEmail(_ email: String) -> Bool {
        // Validación básica de correo electrónico
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

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
