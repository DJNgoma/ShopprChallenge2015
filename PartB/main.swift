//
//  main.swift
//  PartB
//
//  Created by Daliso Ngoma on 02/07/2015.
//  Copyright © 2015 Daliso Ngoma. All rights reserved.
//

import Foundation

var testToken = ""
var objectArr = [String]()

// Part B

func readFromFile() -> Bool{
    
    // For reading from file
    let file = "file.txt"
    
    if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [String] {
        let dir = dirs[0] //documents directory
        let path = dir.stringByAppendingPathComponent(file);
        
        //reading
        do {
            testToken = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            return true
        } catch {
            print("File not found!")
            return false
        }
    } else {
        return false
    }
    
}

// isAlpha used to check if searchTerm is only alpha
func isAlpha(searchTerm: NSString) -> Bool {
    let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z].*",
        options: [.AllowCommentsAndWhitespace])
    
    return regex.firstMatchInString(searchTerm as String, options:[],
        range: NSMakeRange(0, searchTerm.length)) == nil && searchTerm != ""
}

// isRealNum used to check if searchTerm is only realNum
func isDouble(searchTerm: NSString) -> Bool {
    if (searchTerm.doubleValue - floor(searchTerm.doubleValue) > 0.000001) { // 0.000001 can be changed depending on the level of precision you need
        return true
    }
    return false
}

// isNum used to check if searchTerm is only integer
func isInt(searchTerm: NSString) -> Bool {
    let regex = try! NSRegularExpression(pattern: ".*[^0-9].*",
        options: [.AllowCommentsAndWhitespace])
    
    return regex.firstMatchInString(searchTerm as String, options:[],
        range: NSMakeRange(0, searchTerm.length)) == nil && searchTerm != ""
}

// isAlphaNum used to check if searchTerm is only alphaNum
func isAlphaNum(searchTerm: NSString) -> Bool {
    let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*",
        options: [.AllowCommentsAndWhitespace])
    
    return regex.firstMatchInString(searchTerm as String, options:[],
        range: NSMakeRange(0, searchTerm.length)) == nil && searchTerm != ""
}

func addAndStripWhitespace() {
    // Declaration to initialise tokenised variable into array
    objectArr = split(testToken.characters){$0 == ","}.map(String.init)
    
    // Loop used to strip the spaces out. - Put in function
    for i in 0...objectArr.count-1 {
        objectArr[i] = objectArr[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

func checkValue(searchTerm: String) {
    if isAlphaNum(searchTerm) {
        if isAlpha(searchTerm) {
            print((searchTerm as String) + " - alphabetical strings")
        } else if isInt(searchTerm) {
            print((searchTerm as String) + " - integer")
        } else {
            print((searchTerm as String) + " - alphanumeric")
        }
        
    } else if isDouble(searchTerm) {
        print((searchTerm as String) + " - real numbers")
    } else {
        print((searchTerm as String) + " - unknown type")
        
    }
}

// Used for testing that the tokenised data is properly recieved
func idendentifyData() {
    for i in 0...objectArr.count-1 {
        var variableToIdentify: NSString
        variableToIdentify = objectArr[i]
        checkValue(variableToIdentify as String)
    }
}

func main() {
    if readFromFile() {
        addAndStripWhitespace()
        idendentifyData()
    } else {
        print("Error in running program")
    }
    // Uncomment to get user input
    //var keyboard = NSFileHandle.fileHandleWithStandardInput()
    //var inputData = keyboard.availableData
}

main()

