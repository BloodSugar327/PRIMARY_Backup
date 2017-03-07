//
//  ViewController.swift
//  PRIMARY_Backup
//
//  Created by David Guerrero on 3/2/17.
//  Copyright © 2017 Primary Color. All rights reserved.
//  Source code on GitHub repository

import Cocoa
import Foundation

class ViewController: NSViewController
{

    @IBOutlet weak var copyFrom: NSTextField!
    @IBOutlet weak var copyTo: NSTextField!
    @IBOutlet weak var copyFromPath: NSPathControl!
    @IBOutlet weak var copyToPath: NSPathControl!
    @IBOutlet weak var startButton: NSButton!
    
    var fromURL:URL!
    var toURL:URL!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any?
    {
        didSet
        {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonPressed(_ sender: Any)
    {

        //If the copyFrom path is not empty
        if copyFromPath.url  != nil
        {
        
            //If the copyTo path is not empyy
            if  copyToPath.url != nil
            {
                //Assign NSPathControl values to the URL variables
                fromURL = copyFromPath.url
                toURL = copyToPath.url
                
                //Show the fromURL on the copyFrom box for debugging
                copyFrom.stringValue = fromURL.absoluteString
                
            }
            
        }
        
        //Declare and initialize the custom Folder_Merger class
        let merger = Folder_Merger(actionType: .copy, conflictResolution: .keepSource)
    
        //Merge the folders using the fromURl and toURL variables
        merger.merge(atPath: fromURL.path, toPath: toURL.path)
        
        
    }
    
    //Displays an Alert box on screen for the user to dismiss
    func dialogAlert(alert: String, text: String) -> Bool
    {
        //Initialize an NSAlert object
        let myPopup: NSAlert = NSAlert()
        
        //Set the alert message to the alert variable
        myPopup.messageText = alert
        
        //Set the informativeText to the body text variable
        myPopup.informativeText = text
        
        //Set alert style
        myPopup.alertStyle = NSAlertStyle.critical
        
        //Dialog will only have 1 button to dismiss
        myPopup.addButton(withTitle: "Ok")
        
        //Return whether the button was clicked to dismiss the dialog
        return myPopup.runModal() == NSAlertFirstButtonReturn
        
    }
    
      //Displays an question with a YES/NO button to dismiss
    func dialogOKCancel(question: String, text: String) -> Bool
    {
        //Initialize an NSAlert object
        let myPopup: NSAlert = NSAlert()
        
         //Set the alert message to a question variable
        myPopup.messageText = question
        
        //Set the informativeText to the body text variable
        myPopup.informativeText = text
        
        //Set alert style
        myPopup.alertStyle = NSAlertStyle.warning
        
        //Dialog will have two buttons
        myPopup.addButton(withTitle: "Yes")
        myPopup.addButton(withTitle: "No")
        
        //Return whather the first button was clicked to dismiss the dialog
        return myPopup.runModal() == NSAlertFirstButtonReturn
    }
    
    //Function with a PopUp panel to choose a folder, will return a URL variable
    func popUpSelect() -> URL
    {
    
        //Initialize a new NSOpenPanel object
        let myBrowser: NSOpenPanel = NSOpenPanel()
        
        //Panel browser cannot choose files, but can directories
        myBrowser.canChooseFiles = false
        myBrowser.canChooseDirectories = true
        
        //Show the panel rowser
        myBrowser.runModal()
        
        //Save the result to a URL variable
        let result = myBrowser.url
        
        //Return the variable
        return result!

    }
    
    //Simple function that wll move files from one URL to another using the FileManager
    func MoveFiles(moveFrom: URL, moveTo: URL)
    {
        
        //Begin Error catching
        do
        {
           //Initialize a new FileManager object
            let myfileManager: FileManager = FileManager()
            
            //Catch error on this line, Try to move files from one URL to another
            try myfileManager.copyItem(at: moveFrom, to: moveTo)
            
            
        }
        catch
        {
        
        //Let user know file transfer failed via button that was pressed.
        startButton.title = "Failed"
        
        }
    
    }
    
}

