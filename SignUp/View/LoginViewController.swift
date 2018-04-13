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
    
    var loginModel : LoginViewModel?
    
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
        shakeTextField (textField : textField, numberOfShakes : 1, direction: 3.0, maxShakes : 6)
    }
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let emailtext = email.text else
        {
            
            animateTextField(textField: email)
            showAlert(title: "Alert", message: "Enter Email", buttonTitle: "Dismiss")
            return
        }
        if !emailtext.isEmail
        {
            animateTextField(textField: email)
            showAlert(title: "Alert", message: "Enter Email", buttonTitle: "Dismiss")
            return
        }
        
        guard let phonenumber = phoneNumber.text, let password = passWord.text else {
            return
        }
        
        if !phonenumber.isPhone()
        {
            animateTextField(textField: phoneNumber)
            showAlert(title: "failed", message: "Invalid PhoneNumber", buttonTitle: "Dismiss")
            return
        }
        if !password.isValidPassword
        {
            animateTextField(textField: passWord)
            showAlert(title: "failed", message: "Invalid Password", buttonTitle: "Dismiss")
            return
        }
        
        loginModel = LoginViewModel(name: nil, email: emailtext, phoneNumber: phonenumber, password: password)
        
        
        if loginModel!.checkIfAnyUserExist(email: emailtext, phonenumber: phonenumber, password: password)
        {
            if loginModel!.checkAuth()
            {
                print("Success")
            }
            else
            {
                print("Failed ")
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

extension LoginViewModel
{
    convenience init(name : String? = nil , email : String , phoneNumber : String ,password : String) {
        self.init(user: User(name: nil, phonenumber: phoneNumber, email: email, password: password))
    }
}
