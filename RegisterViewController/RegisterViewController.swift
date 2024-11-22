//
//  RegisterViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/16/24.
//
import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // Configurar la vista
        let label = UILabel()
        label.text = "Register View"
        label.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        label.textAlignment = .right
        
        self.view.addSubview(label)
    }
}
