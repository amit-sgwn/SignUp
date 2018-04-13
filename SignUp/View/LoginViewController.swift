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
    
    func animateTextField(textField : UITextField)
    {
        shakeTextField(textField : textField, numberOfShakes : 1, direction: 3.0, maxShakes : 6)
    }
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let emailtext = email.text else
        {
            animateTextField(textField: email)
            showAlert(title: "Alert", message: "Enter Email", buttonTitle: "Dismiss")
            return
        }
        
        guard let phonenumber = phoneNumber.text, let password = passWord.text else {
            animateTextField(textField: phoneNumber)
            animateTextField(textField: passWord)

             showAlert(title: "failed", message: "Invalid Credential", buttonTitle: "Dismiss")
            return
        }
        
        if phonenumber.isPhone(), password.isValidPassword
        {
            if let text = checkLogin(email: emailtext, phonenumber: phonenumber, password: nil)
            {
                var stringretrived = StringManupulator(stringret: text)
                print("name : \(stringretrived.getName())")
                print("email \(stringretrived.getEmail())")
                print("pass : \(stringretrived.getPassWord())")
                print("phone : \(stringretrived.getPhoneNumber())")
                showAlert(title: "Success", message: "Logged In", buttonTitle: "Dismiss")
            }
            else
            {
                showAlert(title: "failed", message: "Invalid Credential", buttonTitle: "Dismiss")
            }
            
        }
        else
        {
            showAlert(title: "failed", message: "Invalid PhoneNumber or PassWord", buttonTitle: "Dismiss")
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
    
    func checkLogin(email : String , phonenumber : String? , password : String?) -> String?
    {
        return readTextFromFile()
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

extension LoginViewController
{
    func shakeTextField (textField : UITextField, numberOfShakes : Int, direction: CGFloat, maxShakes : Int) {
        
        let interval : TimeInterval = 0.03
        
        UIView.animate(withDuration: interval, animations: { () -> Void in
            textField.transform = CGAffineTransform(translationX: 5 * direction, y: 0)
            textField.backgroundColor = UIColor.red
        }, completion: { (aBool :Bool) -> Void in
            
            if (numberOfShakes >= maxShakes) {
                textField.transform =  CGAffineTransform.identity
                textField.backgroundColor = UIColor.white
                textField.becomeFirstResponder()
                return
            }
            
            self.shakeTextField(textField: textField, numberOfShakes: numberOfShakes + 1, direction: direction * -1, maxShakes: maxShakes )
            
        })
        
    }
}
