//
//  main.swift
//  PartA
//
//  Created by Daliso Ngoma on 02/07/2015.
//  Copyright © 2015 Daliso Ngoma. All rights reserved.
//

import Foundation

// Variables used in for randomized objects
let alpha: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" // Alphabetic String
let integer = "0123456789" // Numerical String
let alphaNum = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" // Alphanumeric
let fileSize = 10_000_000 // 1 unit = 1 byte

var tokenizedData = ""

// Function used to get a random figure
func randomStringWithType (input: NSString) -> NSString {
    let randomNum = Int(arc4random_uniform(15)+1)
    //let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString(capacity: randomNum)
    
    for (var i=0; i < randomNum; i++){
        let length = UInt32 (input.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", input.characterAtIndex(Int(rand)))
    }
    
    return randomString
}

// Function used to get a random float number
func randomRealNum() -> NSString {
    
    let randomPos = Int(arc4random_uniform(8))
    let randomDecimals = Int(arc4random_uniform(UInt32(randomPos)))
    var randomDecimalPos: Double = 10.0
    for _ in 1...UInt32(randomPos)+1 {
        randomDecimalPos *= 10.0
    }
    let randomFloat = CGFloat(Double(arc4random())/randomDecimalPos)
    let randomStringDouble = String(format: "%.\(randomDecimals)f", randomFloat)
    
    return randomStringDouble
}

// Function used to add spaces to a string
func addSpaces(string: String) -> String{
    var frontSpaces = ""
    var backSpaces = ""
    let frontNumSpaces = Int(arc4random_uniform(10))
    let backNumSpaces = Int(arc4random_uniform(UInt32(10-frontNumSpaces)))
    
    if frontNumSpaces != 0 {
        for _ in 1...frontNumSpaces {
            frontSpaces+=" "
        }
    }
    if backNumSpaces != 0 {
        for _ in 1...backNumSpaces {
            backSpaces+=" "
        }
    }
    return (frontSpaces + string + backSpaces)
}

// Function used to add random objects to a string
func randomizeObjects() {
    
    // Used to randomise values
    var randCase: UInt32
    
    var tempString = ""
    
    while(true) {
        if tempString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= fileSize {
            break
        }
        randCase = arc4random_uniform(4)
        switch(randCase) {
            
            // Alpha
        case 0:
            tempString += addSpaces(randomStringWithType(alpha) as String) + ","
            break
            // Numeric
        case 1:
            tempString += addSpaces(randomStringWithType(integer) as String) + ","
            break
            // AlphaNumeric
        case 2:
            tempString += addSpaces(randomStringWithType(alphaNum) as String) + ","
            break
            // RealNumber
        case 3:
            tempString += addSpaces(randomRealNum() as String) + ","
            break
        default:
            tempString += addSpaces("@@") + ","
            break
        }
    }
    
    // Overrides previous testtoken
    tokenizedData = tempString
    
}

func writeToFile(string: String) {
    
    // For writing to a file
    let file = "file.txt"
    
    if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [String] {
        let dir = dirs[0] //documents directory
        let path = dir.stringByAppendingPathComponent(file);
        let text = string
        
        //writing
        try! text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding);
    }
    
}

func main() {
    randomizeObjects()
    writeToFile(tokenizedData)
}

main()


