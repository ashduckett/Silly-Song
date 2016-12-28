//
//  ViewController.swift
//  Silly Song
//
//  Created by Ash Duckett on 28/12/2016.
//  Copyright © 2016 Ash Duckett. All rights reserved.
//

import UIKit

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

func shortNameFromName(name: String) -> String {
    var result = String()
    
    // Take the name and make it lowercase. Also convert any characters with accents, etc., to
    // their non-accented versions.
    let lowercaseName = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
    
    // Define a set of characters that represent vowels
    let charSet = CharacterSet(charactersIn: "aeiou")
    
    // If we find a vowel, grab its index, then use that index to strip the consonants before
    // it, otherwise just return the lowercased name
    if let indexOfFirstVowel = lowercaseName.rangeOfCharacter(from: charSet)?.lowerBound {
        result = lowercaseName.substring(from: indexOfFirstVowel)
    } else {
        result = lowercaseName
    }
    
    return result
}

// Here is the part of our ViewController class that takes care of the name text field's
// delegation. By conforming to the UITextFieldDelegate protocol, setting self to be the delegate
// of the text field inside viewDidLoad, we are able to tell the text field to kill the keyboard
// when the Done button gets hit.
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    // An outlet used to access the field the user will enter their name into
    @IBOutlet weak var nameField: UITextField!
    
    // An outlet used to display the generated lyrics
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure we set nameField's delegate so the keyboard will vanish and editing will
        // end on the name field.
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        // Set up a template
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        // If a name has been entered (it's an optional) then use it to set the lyrics on screen
        if let name = nameField.text {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
        }
        
        
        
    }
}

