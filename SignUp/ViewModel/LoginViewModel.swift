//
//  LoginViewModel.swift
//  SignUp
//
//  Created by Amit on 13/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import Foundation


class LoginViewModel
{
    var user : User
    lazy var stringRetrivedFromFile : String? = {readTextFromFile()}()
    lazy var stringManupulater : StringManupulator = { StringManupulator(stringret : stringRetrivedFromFile ?? "" )}()
    init(user : User) {
        self.user = user
    }
    
    
    func checkIfAnyUserExist(email : String , phonenumber : String? , password : String?) -> Bool
    {
        return stringRetrivedFromFile != nil ? true : false
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
    
    func getStringManupulator(text : String) -> StringManupulator
    {
        return StringManupulator(stringret: text)
    }
    
    func checkAuth() -> Bool
    {
        var phone : String?
        var pass : String?
        guard let email = stringManupulater.getEmail() , let phonenumber = stringManupulater.getPhoneNumber() , let password = stringManupulater.getPassWord()
        else
        {
            return false
        }
      
        if (user.email == email && user.password == password) || (user.email == email && user.phoneNumber == phonenumber)
        {
            return true
        }
        else
        {
            return false
        }
    }

}

