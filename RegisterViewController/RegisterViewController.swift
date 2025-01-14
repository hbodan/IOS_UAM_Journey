//
//  RegisterViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//
import UIKit
import SwiftUI

class RegisterViewController: UIViewController {

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
        
        //configuración Auto Layout
        NSLayoutConstraint.activate([
            //Titulo
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            //Imagen
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])

    }
}
