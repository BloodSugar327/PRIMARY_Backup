//
//  Custom_Functions.swift
//  PRIMARY_Backup
//
//  Created by David Guerrero on 3/3/17.
//  Copyright © 2017 Primary Color. All rights reserved.
//

import Foundation
import Cocoa


/**
    Name: InStr
    Description: Same as the InStr() function in VB that will return the position of a character within a string.

    Parameters:
    - find: The string that is being looked for
    - inString: The string being searched

    Returns: 
    - Int: The index of found string, or 0 if string was not found

 */

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


/*********************************************************************************************************************
**********************************************************************************************************************
 
 Custom Extensions to the String contruct with different purposes

**********************************************************************************************************************
**********************************************************************************************************************/


extension String
    {
    
        /**
            Name: index
            Description: Find the index of the first instance of String within a String

            Parameters:
            - of taget: The string that is being looked for

            Returns: 
            - Int: Index of the first letter in found string
     
         */
    
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
    
    
        /**
            Name: lastIndex
            Description: Find the index of the last instance of String within a String

            Parameters:
            - of taget: The string that is being looked for

            Returns: 
            - Int: An integer that is the index of the first letter in found string
     
         */
    
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
    
        /**
            Name: left
            Description: Trim a certain number of characters from the left side of the string

            Parameters:
            - lenght: The number of characters to return from the left

            Returns: 
            - String: A string containing the specified number of characters in original string starting from the left
     
         */
    
        func left(lenght: Int) -> String?
            {
                //If the Integer is not bigger than the string lenght
                if self.characters.count >= lenght
                    {
                        //If the number is not 0
                        if lenght > 0
                            {
                                //The start of the range is the first index of the string
                                let start = self.startIndex
                                //The end of the range is the distance from the startIndex to the Integer that was input
                                let end = self.index(self.startIndex, offsetBy: lenght)
                                //Assign the range to a variable
                                let range = start..<end
                    
                                //String variable will hold the new substring from range
                                let leftString = self.substring(with: range)
                        
                                //Return the new string
                                return leftString
                            }
                        //The number was 0
                        else
                            {
                                //Return a blank string
                                return ""
                            }
                    }
                else
                    {
                        
                         return ""
                    }
            }
    
    /**
     Name: right
     Description: Trim a certain number of characters from the right side of the string
     
     Parameters:
     - lenght: The number of characters to return from the right
     
     Returns:
     - String: A string containing the specified number of characters in original string starting from the right
     
     */
    func right(lenght: Int) -> String?
        {
            //If the Integer is not bigger than the string lenght
            if self.characters.count >= lenght
                {
                    //If the number is not 0
                    if lenght > 0
                        {
                            //The start of the range is the indexNumber from the endIndex minus the Integer
                            let start = self.index(self.endIndex, offsetBy: lenght * -1)
                            //The end of the range is the last index of the string
                            let end = self.endIndex
                            //Assign the range to a variable
                            let range = start..<end
                            
                            //String variable will hold the new substring from range
                            let leftString = self.substring(with: range)
                            
                            //Return the new string
                            return leftString
                        }
                    //The number was 0
                    else
                        {
                            //Return a blank string
                            return ""
                        }
                }
            else
                {
                    return ""
                }
            
            
        }
    
    }

