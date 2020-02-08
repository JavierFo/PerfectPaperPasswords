//
//  KeysController.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/6/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class KeysController: UIViewController {
    
    @IBOutlet weak var keylbl: UILabel!
    @IBOutlet weak var passwordGeneratorBttn: UIButton!
    
    var newKey = generateKey()
    
    override func viewDidLoad() {
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func createCards(_ sender: UIButton) {
        //let usingNewKey = newKey
        performSegue(withIdentifier: "PasswordSegue", sender: passwordGeneratorBttn)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "PasswordSegue"{
            let sendingKey = segue.destination as! CardsController
            sendingKey.mainKey = newKey
        }
    }
    
}


