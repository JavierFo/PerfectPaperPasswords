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
    let key = generateKey()
    let counter: UInt128 = 0
    
    override func viewDidLoad() {
        
        keylbl.text = stringKey(key)
        let cipheredNumber = getNumberOfCipheredCounter(counter, using: key)
        //print("cipheredNumber: \(cipheredNumber ?? 0)\n\n\n")
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        let newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func createCards(_ sender: UIButton) {
        
        let password = getLettersForPassword(key: key)
        print("\nPassword: \(password)")
        let passwordsArray = passwordsCollector(key: key)
        print("\n\n\nPassword Array: \(passwordsArray)")
    }
    
    
}
