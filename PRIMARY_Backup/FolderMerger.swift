//
//  FolderMerger.swift
//  PRIMARY_Backup
//
//  Created by David Guerrero on 3/3/17.
//  Copyright © 2017 Primary Color. All rights reserved.
//


import Foundation
import Cocoa

class Folder_Merger
    {
        
        //Create two enumerations to control the type of movement and conflict resolution options
        enum ActionType { case move, copy }
        enum ConflictResolution { case keepSource, keepDestination }
        
        //Declare and initialize a FileManager object
        private let fileManager = FileManager()
        
        
        private var actionType: ActionType!
        private var conflictResolution: ConflictResolution!
        private var deleteEmptyFolders: Bool!
        
        
        //Set Initialization for this class
        init(actionType: ActionType = .move, conflictResolution: ConflictResolution = .keepDestination, deleteEmptyFolders: Bool = false)
            {
                //set user settings from enumerations
                self.actionType = actionType
                self.conflictResolution = conflictResolution
                self.deleteEmptyFolders = deleteEmptyFolders
            }
    
        /**
            Name: merge
            Description: Merge two folders using two paths
     
            Parameters:
            - atPath: The path that will be copied from
            - toPath: The path that will be copied to

            Returns: 
            - Nothing
     
         */
    
        //Function used to merge folders using two String based paths
        func merge(atPath: String, toPath: String)
            {
                //Initialize enumerator object from fileManager object
                let pathEnumerator = fileManager.enumerator(atPath: atPath)
                
                //String array used to store folders
                var folders: [String] = [atPath]
                
                //Move through all the items in the folder
                while let relativePath = pathEnumerator?.nextObject() as? String
                    {
                        //Set curremt path of the item
                        let subItemAtPath = URL(fileURLWithPath: atPath).appendingPathComponent(relativePath).path
                        //Set new path for the item
                        let subItemToPath = URL(fileURLWithPath: toPath).appendingPathComponent(relativePath).path
                        
                        //Use isDir fuction to see if the object is a directory or file
                        //If its a directory
                        if isDir(atPath: subItemAtPath)
                            {
                                //if this setting is on, add the folder to the list of Folder string array
                                if deleteEmptyFolders!
                                    {
                                        //Add path to array
                                        folders.append(subItemAtPath)
                                    }
                                
                                //If this folder does not exist
                                if !isDir(atPath: subItemToPath)
                                    {
                                        do
                                            {
                                                //Create folder
                                                try fileManager.createDirectory(atPath: subItemToPath, withIntermediateDirectories: true, attributes: nil)
                                                print("FolderMerger: directory created: \(subItemToPath)")
                                            }
                                        catch let error
                                            {
                                                //Catch folder creation error
                                                print("ERROR FolderMerger: \(error.localizedDescription)" )
                                            }
                                        
                                    }
                                else
                                    {
                                        //Folder already exists, no need to create new folder
                                        print("FolderMerger: directory \(subItemToPath) already exists" )
                                    }
                            }
                            
                        //If its a file
                        else
                            {
                                //TODO: Explore different options to keep source/keep destination. Currently errors happen when deleting the old files after moving.
                                //If file already exists in path, delete it to move in the new version
                                if isFile(atPath:subItemToPath) && conflictResolution == .keepSource
                                    {
                                        do
                                            {
                                                //Delete thie file
                                                try fileManager.removeItem(atPath: subItemToPath)
                                                print("FolderMerger: file deleted: \(subItemToPath)" )
                                            }
                                        catch let error
                                            {
                                                //Catch file deletion error
                                                print("ERROR FolderMerger: \(error.localizedDescription)")
                                            }
                                    }
                                
                                //Move new version of file over to path
                                do
                                    {
                                        //TODO: Use if statement to determine whether the item should be moved or copied.
                                        // Maybe instead of using the moveItem command, use the copy item and then delete old file
                                        
                                        //Move the file
                                        try fileManager.moveItem(atPath: subItemAtPath, toPath: subItemToPath)
                                        print("FolderMerger: file moved from \(subItemAtPath) to \(subItemToPath)")
                                    }
                                catch let error
                                    {
                                        //Catch file move error
                                        print("ERROR FolderMerger: \(error.localizedDescription)")
                                    }
                            }
                    }
                
                //If this setting is on, will delete all folders in the Folders string array
                if deleteEmptyFolders!
                {
                    //Sort the array of folders
                    folders.sort(by: { (path1, path2) -> Bool in
                        return path1.characters.split(separator: "/").count < path2.characters.split(separator: "/").count
                    })
                    while let folderPath = folders.popLast()
                    {
                        //If the folder is empty
                        if isDirEmpty(atPath: folderPath)
                        {
                            do
                            {
                                //Delete the folder
                                try fileManager.removeItem(atPath: folderPath)
                                print("FoldersMerger: empty dir deleted: \(folderPath)")
                            }
                            catch
                            {
                                //Catch folder deletion error
                                print("ERROR FolderMerger: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
    
    
        /**
            Name: isDir
            Description: Determines whether the path is a directory
         
            Parameters:
            - atPath: The path that will be checked

            Returns: 
            - Boolean: Used by caller
     
         */
    
        private func isDir(atPath: String) -> Bool
        {
            //Declare variable that will hold the return value of fileExist check
            var isDir: ObjCBool = false
            //Check if file exists in path and if its a directory retun it to the isDir boolean variable
            let exist = fileManager.fileExists(atPath: atPath, isDirectory: &isDir)
            
            return exist && isDir.boolValue
        }
    
    
        /**
            Name: isFile
            Description: Determines whether the path is a file
         
            Parameters:
            - atPath: The path that will be checked

            Returns: 
            - Boolean: Used by caller
     
         */
        private func isFile(atPath: String) -> Bool
        {
            //Declare variable that will hold the return value of fileExist check
            var isDir: ObjCBool = false
                  //Check if file exists in path and if its a directory retun it to the isDir boolean variable
            let exist = fileManager.fileExists(atPath: atPath, isDirectory: &isDir)
            
            return exist && !isDir.boolValue
        }
    
    
        /**
            Name: isDirEmpty
            Description: Determines whether the path directory is empty

            Parameters:
            - atPath: The path that will be checked

            Returns: 
            - Boolean: Used by caller
     
         */
    
        private func isDirEmpty(atPath: String) -> Bool
        {
            do
            {
                //Return the number of items in direcory
                return try fileManager.contentsOfDirectory(atPath: atPath).count == 0
            }
            catch _
            {
                return false
            }
        }
    }
