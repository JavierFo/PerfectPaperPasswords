//
//  ViewController.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/4/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CryptoKit

class CardsController : UIViewController {

    @IBOutlet weak var cardsCollection: UICollectionView!
    //var passwordsWillBePrinted : [String]!
    
    private let dataModel = DataModel()
    var mainKey : SymmetricKey? = nil
    var passwordArray : [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.delegate = self
        dataModel.requestData(with: mainKey!)
        //print("\n\n\nMain Key: \(stringKey(mainKey!))\n\n\n")
    }
}

extension CardsController: DataModelDelegate{
    func didRecieveDataUpdate(data: [[String]]) {
        passwordArray = data
        //print(passwordArray ?? 0)
    }
    
}

extension CardsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PasswordViewCell", for: indexPath) as? PasswordViewCell else { fatalError("Unable to dequeue Password View Cell")}
        
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.passwordLabel.text = passwordArray?[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40,height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }

}

