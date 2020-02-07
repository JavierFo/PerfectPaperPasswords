//
//  PasswordsGenerator.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/6/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CryptoKit

protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: [[String]])
}

class DataModel {
    
      weak var delegate: DataModelDelegate?
    
      func requestData(with key: SymmetricKey) {
        
        let data = PasswordsCollector(with: key)
         delegate?.didRecieveDataUpdate(data: data)
      }
}

func PasswordsCollector(with key: SymmetricKey) -> [[String]] {
    
    var celda = [[String]]()
    
    //let rows = [String]()
    
    for _ in 1 ... 10 {
        var column = [String]()
        
        for _ in 1 ... 7{
            let cell = getLettersForPassword(key: key)
            column.append(cell)
        }
        
       // celda[rows[row_index]] = column
        celda.append(column)
    }
    
    return celda
}




