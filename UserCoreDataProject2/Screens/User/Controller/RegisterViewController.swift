//
//  RegisterViewController.swift
//  UserCoreDataProject2
//
//  Created by Sadia on 11/6/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var databaseManager = DatabaseManager()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Add User"
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
        
//        guard let profileImage = passwordField.text, !password.isEmpty else{
//            openAlert(title: "Alert", message: "Please enter your password")
//            return
//        }
        
        let users = UserModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, password: password)
        
        databaseManager.addUser(users)
        showAlert()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func openAlert(title: String, message: String) -> Void {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            
            alert.addAction(okButton)
           
            self.present(alert, animated: true)
        }
    func showAlert(){
        let alert = UIAlertController(title: nil, message: "User Added", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                
                self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           self.dismiss(animated: true)
       }
    
}


