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
    var imageSelectedByUser:Bool = false
    var existingUser: UserEntity?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(tapGesture)
        //profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        
        userDetailConfiguration()
    }


    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        self.present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageSelectedByUser = true
        self.dismiss(animated: true)
    }

}


// MARK: - Alerts
extension RegisterViewController{
    func openAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)

        alert.addAction(okButton)

        self.present(alert, animated: true)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}



// MARK: - Button Click Handler
extension RegisterViewController{
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if !imageSelectedByUser{
            openAlert(title: "Alert", message: "Please select profile image")
            return
        }

        guard let firstName = firstNameField.text, !firstName.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your First Name")
            return
        }

        guard let lastName = lastNameField.text, !lastName.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Last Name")
            return
        }

        guard let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your Phone Number")
            return
        }

        guard let password = passwordField.text, !password.isEmpty else {
            openAlert(title: "Alert", message: "Please enter your password")
            return
        }
        
        var imageName = ""
        if let existingUser{
            //Update
            imageName = existingUser.imageName ?? ""
        }else{
            //Add
            imageName = UUID().uuidString
        }
        
        var newUser = UserModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, password: password, imageName: imageName)
        
        //user thakle update hobe na thakle add
        if let existingUser{
            //Update
            databaseManager.updateUser(user: newUser, userEntity: existingUser)
            saveImageToDocumentDirectory(imageName: imageName)
            showAlert(message: "User Updated")
        }else{
           //Add
            saveImageToDocumentDirectory(imageName: imageName)
            databaseManager.addUser(newUser)
            showAlert(message: "User Added")
        }
   
        firstNameField.text = ""
        lastNameField.text = ""
        phoneNumberField.text = ""
        passwordField.text = ""
    }

    func saveImageToDocumentDirectory(imageName: String){
        let fileURL = URL.documentsDirectory.appending(component: imageName).appendingPathExtension("png")
        
        if let data = profileImageView.image?.pngData(){
            do{
                try data.write(to: fileURL) //save   [image ke data te convert kore data fileURL e write kore dibo, tahole path e data te png format e store hobe image ]
            }catch{
                print("Saving image to Document Ditrctory error: \(error)")
            }
        }
    }
}

// MARK: - Update user

extension RegisterViewController{
    func userDetailConfiguration(){
        
        if let existingUser {
            navigationItem.title = "Update user"
            firstNameField.text = existingUser.firstName
            lastNameField.text = existingUser.lastName
            phoneNumberField.text = existingUser.phoneNumber
            passwordField.text = existingUser.password
            
            let imageURL = URL.documentsDirectory.appending(components: existingUser.imageName ?? "").appendingPathExtension("png")
            profileImageView.image = UIImage(contentsOfFile: imageURL.path)
            
            registerButton.setTitle("Update", for: .normal)
            
            imageSelectedByUser = true
            
        }else{
            navigationItem.title = "Add user"
            registerButton.setTitle("Register", for: .normal)
        }
    }
}

