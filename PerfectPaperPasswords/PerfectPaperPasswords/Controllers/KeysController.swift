//
//  KeysController.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/6/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CryptoKit

class KeysController: UIViewController {
    
    @IBOutlet weak var keylbl: UILabel!
    @IBOutlet weak var passwordGeneratorBttn: UIButton!
    @IBOutlet weak var characterSetTextField: UITextField!
    @IBOutlet weak var CharacterSetButton: UIButton!
    @IBOutlet weak var passwordlenghtLabel: UILabel!
    @IBOutlet weak var passwordLenghtStepper: UIStepper!
    @IBOutlet weak var savedCards: UIButton!
    
    
    var newKey = generateKey()
            
    var configuration = PasswordsModel(passcodeLength: 4, characterSet: "!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz")

    var retrievedPasswords_ = CardsController()
    var retrievedKey_ = CardsController()
    var passwordState = CardsController()
    
    let cardsController = CardsController()
    
    var areThereSavedCards : Bool = false
    
    override func viewDidLoad() {
        keylbl.text = stringKey(newKey)
        characterSetTextField.text = configuration.characterSet
        passwordLenghtStepper.maximumValue = 6
        passwordLenghtStepper.minimumValue = 1
        passwordLenghtStepper.autorepeat = false
        passwordLenghtStepper.wraps = false
        passwordLenghtStepper.value = 4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //savedPasswordsAlert(withTitleAndMessage: "Hey!", message: "Wanna have Passwords?")
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func createCards(_ sender: UIButton) {
        performSegue(withIdentifier: "PasswordSegue", sender: passwordGeneratorBttn)
    }
    
    @IBAction func resetCharacterSet(_ sender: UIButton) {
        characterSetTextField.text = configuration.characterSet
    }
    
    @IBAction func changePasswordLenght(_ sender: UIStepper) {
        configuration.passcodeLength = Int(sender.value)
        passwordlenghtLabel.text = String(configuration.passcodeLength)
        
    }
    
    @IBAction func SaveCards(_ sender: UIButton) {
        performSegue(withIdentifier: "SavedCards", sender: savedCards)
    }
    
    
//    func savedPasswordsAlert(withTitleAndMessage title:String, message:String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "Generate New Passwords", style: UIAlertAction.Style.default, handler: nil))
//
//        alert.addAction(UIAlertAction(title: "Get Stored Passwords", style: UIAlertAction.Style.cancel, handler: {
//            action in
//
//            let cardsController = CardsController(nibName: "CardsController", bundle: nil)
//
//            cardsController.passwordsState = .savingPasswords
//
//            let retrievedKey: String? = KeychainWrapper.standard.string(forKey: "sequenceKeyKey")
//            cardsController.stringMainKey = retrievedKey
//            //print(retrievedKey)
//
//            let retrievedPasswords : String? = KeychainWrapper.standard.string(forKey: "passwordArrayKey")
//            cardsController.storedPasswordArray = retrievedPasswords
//            //print(retrievedPasswords)
//
//            self.navigationController?.pushViewController(self.cardsController, animated: true)
//            self.present(self.cardsController, animated: true)
//        }))
//
//        self.present(alert, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "PasswordSegue"{
            let sendingKey = segue.destination as! CardsController
            sendingKey.mainKey = newKey
            let sendingCharacters = segue.destination as! CardsController
            sendingCharacters.characterSet = characterSetTextField.text
            let sendingPasswordLenght = segue.destination as! CardsController
            sendingPasswordLenght.passwordLenght = configuration.passcodeLength
            let passwordState_ = segue.destination as! CardsController
            passwordState_.passwordsState = .newPasswords

        }
        
        if segue.identifier == "SavedCards"{
            let retrievedKey_ = segue.destination as! CardsController
            let retrievedKey: String? = KeychainWrapper.standard.string(forKey: "sequenceKeyKey")
            retrievedKey_.stringMainKey = retrievedKey
            
            let retrievedPasswords_ = segue.destination as! CardsController
            let retrievedPasswords : String? = KeychainWrapper.standard.string(forKey: "passwordArrayKey")
            retrievedPasswords_.storedPasswordArray = retrievedPasswords
            
            let cardsController_ = segue.destination as! CardsController
            cardsController_.passwordsState = .savingPasswords
            
        }
    }
    
}


