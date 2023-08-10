//
//  LoginViewModel.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 1/8/23.
//

import UIKit

final class LoginViewModel{
    
    private weak var loginView: LoginViewController?
    
    init(loginView: LoginViewController){
        self.loginView = loginView
    }

    func login(email: String, password: String){
        DispatchQueue.main.async {
            self.loginView?.navigateToTabBar()
        }
    }
    
    func verifyEmailAndPassword(email: String?, password: String?) -> Bool{
        if (!(email == "" || password == "")){
            return verifyEmail(email: email!) && verifyPassword(password: password!)
        }
        else{
            return false
        }
    }
        
    //EMAIL VERIFICATION
    
    func verifyEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func verifyPassword(password: String) -> Bool{
        //PASSWORD VERIFICATION: AT LEAST 8 CHARS LONG, ONE UPPERCASE, ONE SPECIAL CHAR AND A NUMBER
        /*
         ^                         Start anchor
         (?=.*[A-Z])               Ensure string has one uppercase letter
         (?=.*[!@#$&*])            Ensure string has one special case letter.
         (?=.*[0-9])               Ensure string has one digit.
         .{8}                      Ensure string is of length 8.
         $                         End anchor.
         */
        let regex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }

}
