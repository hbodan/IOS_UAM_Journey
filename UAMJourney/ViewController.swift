//
//  ViewController.swift
//  UAMJourney
//
//  Created by User-UAM on 11/15/24.
//
import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        let loginVC = LoginViewController(); self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let registerVC = RegisterViewController(); self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
}
