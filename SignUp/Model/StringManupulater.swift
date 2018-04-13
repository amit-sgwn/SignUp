//
//  StringManupulater.swift
//  SignUp
//
//  Created by Amit on 13/04/18.
//  Copyright © 2018 Novanet. All rights reserved.
//

import Foundation


class StringManupulator
{
    var retrivedString : String
    
    init(stringret : String)
    {
        self.retrivedString = stringret
    }
    lazy var indexsofCommas :  [String.Index] = { self.retrivedString.indexes(of: ",")}()
    func getName()-> String?
    {
        let range = retrivedString.startIndex..<indexsofCommas[0]
        return String(retrivedString[range])
    }

    func getPhoneNumber() -> String?
    {
        let nextIndex = retrivedString.index(indexsofCommas[0], offsetBy: 1)
        let range = nextIndex..<indexsofCommas[1]
        return String(retrivedString[range])
    }

    func getPassWord() -> String?
    {
        let nextIndex = retrivedString.index(indexsofCommas[1], offsetBy: 1)
        let range = nextIndex..<indexsofCommas[2]
        return String(retrivedString[range])
    }

    func getEmail() -> String?
    {
        let nextIndex = retrivedString.index(indexsofCommas[2], offsetBy: 1)
        let range = nextIndex..<retrivedString.endIndex
        return String(retrivedString[range])
    }
}

extension StringProtocol where Index == String.Index {
    func index<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound  ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
