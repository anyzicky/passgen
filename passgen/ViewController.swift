//
//  ViewController.swift
//  passgen
//
//  Created by Денис Сураев on 11.07.17.
//  Copyright © 2017 Денис Сураев. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let arPosible = [
        "alpha" : "abcdefghijklmnopqrstuvwxyz",
        "alphaUpper" : "ABCDEFGHJKMNPQRSTUVWXYZ",
        "digits" : "0123456789",
        "chars" : "!@#$%&*?"
    ]
    
    var pass = [
        "alpha" : "",
        "alphaUpper" : "",
        "digits" : "",
        "chars" : ""
    ]

    
    @IBOutlet weak var passLength: NSTextField!
    @IBOutlet weak var upperSupport: NSButton!
 
    @IBOutlet weak var sliderLength: NSSlider!
    @IBOutlet weak var charsSupport: NSButton!
    @IBOutlet weak var digitsSupport: NSButton!
    @IBOutlet weak var lblCurrentPassword: NSTextField!
    @IBOutlet weak var btnGenerate: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //userSelect = alpha
        pass["alpha"] = arPosible["alpha"]
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func slider(_ sender: Any) {
        passLength.intValue = sliderLength.intValue
    }
    
    @IBAction func addDigits(_ sender: Any) {
        if(digitsSupport.state == 1) {
            pass["digits"] = arPosible["digits"]
        } else {
            pass["digits"] = ""
        }
    }
    
    @IBAction func addChars(_ sender: Any) {
        if(charsSupport.state == 1) {
            pass["chars"] = arPosible["chars"]
        } else {
            pass["chars"] = ""
        }
    }
    
    @IBAction func addUpperAlpha(_ sender: Any) {
        if(upperSupport.state == 1) {
            pass["alphaUpper"] = arPosible["alphaUpper"]
        } else {
            pass["alphaUpper"] = ""
        }
    }

    func saveToClipboard(text: String) -> Void {
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(text, forType: NSPasteboardTypeString)
    }
    
    func showNotification(pass: String) -> Void {
        let notification = NSUserNotification()
        notification.identifier = "cpsd"
        notification.title = "Copied"
        notification.subtitle = "You generate " + pass
        //notification.informativeText = "This is a test"

        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }
    
    @IBAction func generate(_ sender: Any) {
        
        var allowedChars = pass["alpha"]! + pass["alphaUpper"]! + pass["digits"]! + pass["chars"]!
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        let lengthPass = UInt32(passLength.intValue)

        var randomPass = ""
        
        for _ in 1...lengthPass {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomPass += String(newCharacter)
        }
        
        saveToClipboard(text: randomPass)
        
        showNotification(pass: randomPass)
        
        lblCurrentPassword.stringValue = randomPass
    }
}

