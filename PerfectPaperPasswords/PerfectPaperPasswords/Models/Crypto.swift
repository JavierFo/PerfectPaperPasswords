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

func bit128counter (_ value: UInt128) -> Data {
    var counter = String(value, radix: 2)
    
    while counter.count < 128 {
        counter = "0" + counter
    }
    
    return Data(counter.utf8)
}

func getNumberOfCipheredCounter (_ counter: UInt128, using key: SymmetricKey) -> UInt128? {
    //let counter: UInt128 = 0
    //let key = generateKey()
    let counterThatWillBeCiphered = bit128counter(counter)
    
    guard let cypheredCounter = try? AES.GCM.seal(counterThatWillBeCiphered, using: key) else {
        return nil
    }
    
    let cypheredCounterNumber = ([UInt8](cypheredCounter.ciphertext)).map { (0..<127).contains($0) ? "0" : "1" }
    let cypheredCounterJoinedNumber = try? UInt128("0b"+cypheredCounterNumber.joined())
    
    return cypheredCounterJoinedNumber
}
    
 func getLettersForPassword(key: SymmetricKey) -> String {
    var password = ""
    var counter: UInt128 = 0
    let defaultCharacters = "!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    var characterSet : [String] = [""]
    
    let values = defaultCharacters.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    
    if values != "" {
        characterSet = Array(Set(values)).map({String($0)}).sorted()
    }
    
    for _ in 0..<4 {
        let cipheredCounter = getNumberOfCipheredCounter(counter, using: key) ?? UInt128()
        counter += 1
        
        let characterToAssign = cipheredCounter % UInt128(characterSet.count)
        let letter = Int(characterToAssign)
        password = password + characterSet[letter]
    }
    
    return password
}

func passwordsCollector(key: SymmetricKey) -> [String]{
    
    //var Cards : [String]
    var column = [String]()
    
    for _ in 1 ... 10 {
        
        for _ in 1 ... 7{
            let cell = getLettersForPassword(key: key)
            column.append(cell)
        }
        
    }
    
    return column
}

