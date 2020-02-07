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
    
    
    let key = generateKey()
//   private let dataModel = DataModel()
//    var passwordArray : [String] = []
    
    override func viewDidLoad() {
 
        
        keylbl.text = stringKey(key)
//        dataModel.delegate = self
//        dataModel.requestData(with: key)
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        let newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func createCards(_ sender: UIButton) {
       // performSegue(withIdentifier: "PasswordSegue", sender: passwordGeneratorBttn)
    }
}

//extension KeysController: DataModelDelegate{
//
//    func didRecieveDataUpdate(data: [String]) {
//
//        passwordArray = data
//
//    }
//
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier ==  "PasswordSegue"{
////            let passwordsWillBeSentto = segue.destination as! CardsController
////            passwordsWillBeSentto.passwordsWillBePrinted = passwordArray
////        }
////    }
//
//}


