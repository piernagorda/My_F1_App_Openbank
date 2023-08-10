//
//  SettingsViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var f1Button: UIButton?

    convenience init() {
        self.init(nibName: "SettingsView", bundle:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    @IBAction func visitF1Page(){
        let url = URL(string: "https://www.f1.com")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func shareWithFriends(){
        showShareSheet()
        
    }
    
    @IBAction func logout() {
        showLogOutAlert()
    }

    // MARK: - Metodos utilizados por las @IBActions y configuración de botones
    
    private func setUpButtons(){
            
        self.logOutButton?.layer.borderColor = UIColor.red.cgColor
        self.logOutButton?.layer.borderWidth = 1.5
        self.logOutButton?.layer.cornerRadius = 10.0
        self.logOutButton?.layer.masksToBounds = true
        self.logOutButton?.setImage(UIImage(named: "logout"), for: .normal)
        
        self.shareButton?.layer.borderColor = UIColor.white.cgColor
        self.shareButton?.layer.borderWidth = 1.5
        self.shareButton?.layer.cornerRadius = 10.0
        self.shareButton?.layer.masksToBounds = true
        
        self.f1Button?.layer.borderColor = UIColor.white.cgColor
        self.f1Button?.layer.borderWidth = 1.5
        self.f1Button?.layer.cornerRadius = 10.0
        self.f1Button?.layer.masksToBounds = true
    }
    
    private func showShareSheet(){
        let text = "Check out the My F1 App!"
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func showLogOutAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        let no = UIAlertAction(title: "No", style: .default)
        alert.addAction(ok)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
}
