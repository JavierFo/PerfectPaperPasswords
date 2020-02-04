//
//  ViewController.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/4/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let number : UInt128 = 333
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print(number.bitWidth)
        
    }


}

