//
//  SignUpViewController.swift
//  SignUp
//
//  Created by Amit on 12/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    //lazy var signUpModel : Sign
//    var sharedfile : FileIO?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self
        self.phoneNumber.delegate = self
        self.email.delegate = self
        self.password.delegate = self
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func animateTextField(textField : UITextField)
    {
        shakeTextField(textField : textField, numberOfShakes : 1, direction: 3.0, maxShakes : 6)
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        
        var stringToStore : String?
    
        guard let name = userName.text , let phoneno = phoneNumber.text, let emailtext = email.text ,let  pass = password.text  else {
            self.showAlert(title: "Alert", message: "Enter all Field", buttonTitle: "Dismiss")
            return
        }
        
        if !phoneno.isPhone()
        {
            shakeTextField (textField : phoneNumber, numberOfShakes : 1, direction: 3.0, maxShakes : 6)
          //  showAlert(title: "Alert", message: "Invalid PhoneNumber", buttonTitle: "Dismiss")
            return
        }
        if !emailtext.isEmail
        {
            animateTextField(textField : email)
            showAlert(title: "Alert", message: "Invalid Email", buttonTitle: "Dismiss")
            return
        }
        if !pass.isValidPassword
        {
            animateTextField(textField : password)
            showAlert(title: "Alert", message: "Invalid Email", buttonTitle: "Dismiss")
            return
        }
       
        stringToStore = "\(name),\(phoneno),\(pass),\(emailtext)"
      //  FileIO.sharedInstance.writeTextToFile(text: sharedfile!)
        writeTexttoFile(text : stringToStore!)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
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
    
    
    func writeTexttoFile(text : String)
    {
        let file = "file.txt" //this is the file. we will write to and read from it
        
     //   let text = "some text" //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
            
            //reading
//            do {
//                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//            }
//            catch {/* error handling here */}
        }
    }
    
}

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }

}


extension SignUpViewController
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
