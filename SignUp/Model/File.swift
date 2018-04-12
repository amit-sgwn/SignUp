//
//  File.swift
//  SignUp
//
//  Created by Amit on 12/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import Foundation

//making it final to avoid race condition

final class FileIO
{
    static let fileName = "myFileName.txt"
    static var filePath = ""
    static let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)

    static let sharedInstance = FileIO()
    
     private  init()
    {

    }
    func setUp() -> FileIO
    {
        return self
    }
  
    static func setUpDir()
    {
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appending("/" + fileName)
            print("Local path = \(filePath)")
        } else {
            print("Could not find local directory to store file")
            return
        }
    }
  
//    func writeTextToFile(text : String)
//    {
//        do {
//            // Write contents to file
//            try text.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
//        }
//        catch let error as NSError {
//            print("An error took place: \(error)")
//        }
//    }
//
//    static func readTextFromFile() -> String?
//    {
//        var contentFromFile : String? = nil
//        do {
//            // Read file content
//            contentFromFile = try NSString(contentsOfFile: self.filePath, encoding: String.Encoding.utf8.rawValue) as String
//            print(contentFromFile)
//        }
//        catch let error as NSError {
//            print("An error took place: \(error)")
//        }
//        return contentFromFile
//    }
    
    
   
    
    // Read file content. Example in Swift
   
}
