//
//  PasswordsModel.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/7/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CryptoKit

struct PasswordsModel {
    
    let passcodeLength: Int
    let characterSet: [String]
    
    init(passcodeLength: Int, characterSet: [String]){
        self.passcodeLength = passcodeLength
        self.characterSet = characterSet
    }
    
}


