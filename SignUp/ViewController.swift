//
//  ViewController.swift
//  SignUp
//
//  Created by Amit on 12/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signUpAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(controller, animated: true, completion: nil)
    }
    
}

