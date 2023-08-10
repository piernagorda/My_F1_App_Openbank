//
//  LoginViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 1/8/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var loadDataButton: UIButton?
    
    private var loginModel: LoginViewModel?
    private let action = UIAlertAction(title: "OK", style: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadiusButtons()
        setViewModel()
    }
    
    @IBAction func loginButtonPressed(){
        //Decirle al LoginModel que verifique, no aqui
        if (loginModel!.verifyEmailAndPassword(email: emailField!.text, password: passwordField!.text) ){
            loginModel?.login(email: emailField!.text!, password: passwordField!.text!)
        }
        else{
            showAlertWrongData()
        }
    }
    
    @IBAction func loadDataPressed(){
        self.emailField?.text = "javier@correo.com"
        self.passwordField?.text = "Pepito2*"
    }
    
    private func setViewModel() {
        
        self.loginModel = LoginViewModel(loginView: self)
    }
    
    
    func navigateToTabBar(){
        let tabBarController = TabBarController()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    
    //OTHER FUNCTIONS
    
    private func setCornerRadiusButtons(){
        emailField?.layer.cornerRadius = 15.0
        emailField?.layer.masksToBounds = true
        passwordField?.layer.cornerRadius = 15.0
        passwordField?.layer.masksToBounds = true
        loginButton?.layer.cornerRadius = 15
        loadDataButton?.layer.cornerRadius = 15
    }
    
    private func showAlertWrongData(){
        let alert = UIAlertController(title: "Check the data", message: "Make sure the email is valid and the password has 1 uppercase, 1 number, 1 special character and is at least 8 characters long", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
