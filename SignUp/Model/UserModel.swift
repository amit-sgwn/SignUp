//
//  UserModel.swift
//  SignUp
//
//  Created by Amit on 12/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import Foundation

struct User
{
    var name : String?
    var phoneNumber : String
    var email : String
    var password : String
    
    init(name : String? , phonenumber : String, email : String , password : String)
    {
        if let name = name
        {
             self.name = name
        }
        self.phoneNumber = phonenumber
        self.email = email
        self.password = password
    }
}



enum typeAction {
    case SignUp,Login
}
