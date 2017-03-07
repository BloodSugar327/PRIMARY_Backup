//
//  Custom_Functions.swift
//  PRIMARY_Backup
//
//  Created by David Guerrero on 3/3/17.
//  Copyright © 2017 Primary Color. All rights reserved.
//

import Foundation
import Cocoa


//Same as the InStr() function in VB that will return the position of a character within a string.
func InStr(find: String, inString: String) -> Int
{
    
    //String that will be searched
    let string = inString
    //Sought for character
    let characterToFind: Character = find[find.startIndex]
    
    //If the character is found withing the string
    if let idx = string.characters.index(of: characterToFind)
    {
        //Let pos equal the array slot distance from the beggining of the string to the index point.
        let characterIndex = string.characters.distance(from: string.startIndex, to: idx) as Int
        //Print result to the console and return the value
        print("Found \(characterToFind) at position \(characterIndex)")
        return characterIndex

    }
    //If the character is not found withing the string
    else
    {
        //Print not found result to the console and 0
        print("Not found")
        return 0
    }

}

//Extension to the string construct that will return the position of a character within a string.
//This is a different but close take on the VB function, but using Swift's extension to implement it.
extension String
{
    //Return the index of the first instance of String within a String
    func index(of target: String) -> Int?
    {
        //If the the string being sought for is found within the String calling this function
        if let range = self.range(of: target)
        {
            //The number of characters from the start of the string to the first letter of the string being sought for
            let stringIndex = characters.distance(from: startIndex, to: range.lowerBound) as Int
            
            //Print result to the console and return the value
            print("Found \(self) at position \(stringIndex)")
            return stringIndex
            
        }
        //If not found
        else
        {
            //Return nothing
            return nil
        }
        
    }
    
        //Return the index of the last instance of String within a String
    func lastIndex(of target: String) -> Int?
    {
        //If the the string being sought for is found within the String calling this function; starting from the end
        if let stringRange = self.range(of: target, options: .backwards)
        {
            
            //The number of characters from the start of the string to the first letter of the string being sought for
            let stringIndex = characters.distance(from: startIndex, to: stringRange.lowerBound) as Int
            
            //Print result to the console and return the value
            print("Found \(self) at position \(stringIndex)")
            return characters.distance(from: startIndex, to: stringRange.lowerBound)
            
        }
        //If not found
        else
        {
            //Return nothing
            return nil
            
        }
        
    }
}

