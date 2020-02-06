//
//  Cripto.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/6/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CryptoKit

func generateKey() -> SymmetricKey{
    let key = SymmetricKey(size: .bits256)
    return key
}

func stringKey(_ key: SymmetricKey) -> String? {
    key.withUnsafeBytes { Data(Array($0)).base64EncodedString() }
}
