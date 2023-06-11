//
//  RegisterViewController.swift
//  UserCoreDataProject2
//
//  Created by Sadia on 11/6/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameField.text, !firstName.isEmpty else{
            openAlert(title: "Alert", message: "Please enter your First Name")
            return
        }
        
        guard let lastName = lastNameField.text, !lastName.isEmpty else{
            openAlert(title: "Alert", message: "Please enter your Last Name")
            return
        }
        
        guard let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty else{
            openAlert(title: "Alert", message: "Please enter your Phone Number")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else{
            openAlert(title: "Alert", message: "Please enter your password")
            return
        }
    }
    
    func openAlert(title: String, message: String) -> Void {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            
            alert.addAction(okButton)
           
            self.present(alert, animated: true)
        }

}
