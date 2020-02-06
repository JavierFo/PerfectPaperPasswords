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
    
    override func viewDidLoad() {
        
        keylbl.text = stringKey(key)
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        let newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
}
