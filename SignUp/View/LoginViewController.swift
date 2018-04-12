//
//  LoginViewController.swift
//  SignUp
//
//  Created by Amit on 12/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
//    var emmailId : String?
//    var
    override func viewDidLoad() {
        super.viewDidLoad()

        self.email.delegate = self;
        self.phoneNumber.delegate = self;
        self.passWord.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let email = email.text else  {
            showAlert(title: "Alert", message: "Enter Email", buttonTitle: "Dismiss")
            return
        }
        
        if let phonenumber = phoneNumber.text
        {
            if phonenumber.isPhone()
            {
                if checkLogin(email: email, phonenumber: phonenumber, password: nil)
                {
                    showAlert(title: "Success", message: "Logged In", buttonTitle: "Dismiss")
                }
                else
                {
                    showAlert(title: "failed", message: "Invalid Credential", buttonTitle: "Dismiss")
                }
                
            }
            else
            {
                showAlert(title: "failed", message: "Invalid PhoneNumber", buttonTitle: "Dismiss")
            }
        }
        
        
        if let password = passWord.text
        {
            if password.isValidPassword
            {
                if checkLogin(email: email, phonenumber: nil, password: password)
                {
                    showAlert(title: "Success", message: "Logged In", buttonTitle: "Dismiss")
                }
                else
                {
                    showAlert(title: "failed", message: "Invalid Credential", buttonTitle: "Dismiss")
                }
                
            }
            else
            {
                showAlert(title: "failed", message: "Invalid Password", buttonTitle: "Dismiss")
            }
        }
        
    
        
    }
    

    func showAlert(title : String, message : String, buttonTitle : String)
    {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: buttonTitle)
        alert.show()
    }
    
    func checkLogin(email : String , phonenumber : String? , password : String?) -> Bool
    {
        var textStored =  readTextFromFile()
        print(textStored)
        return true
    }
    
    
    func readTextFromFile() -> String?
    {
        let file = "file.txt" //this is the file. we will write to and read from it
        
        var text : String? = nil//just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)

            
                        do {
                            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                            text = text2
                        }
                        catch {/* error handling here */}
        }
        return text
        
    }
    

}
