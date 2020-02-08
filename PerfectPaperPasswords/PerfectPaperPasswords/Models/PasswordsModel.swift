//
//  PasswordsModel.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/7/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

struct PasswordsModel {
    
    var passcodeLength: Int
    var characterSet: String
    
    init(passcodeLength: Int, characterSet: String){
        self.passcodeLength = passcodeLength
        self.characterSet = characterSet
    }
    
}


