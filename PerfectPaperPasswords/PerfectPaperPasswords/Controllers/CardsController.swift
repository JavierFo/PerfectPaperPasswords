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
    
    @IBOutlet weak var keyLabel: UILabel!
    
    private let dataModel = DataModel()
    private let keyChainSequenceKey = "sequenceKeyKey"
    private let keyChainPasswordArrayKey = "passwordArrayKey"
    
    var mainKey : SymmetricKey? = nil
    var stringMainKey : String?
    var characterSet : String?
    var passwordLenght : Int?
    var passwordArray : [[String]]?
    var storedPasswordArray : String?
    var passwordThatWasStored : [[String]]?
    var passwordsState: SavedPasswords?
    
    var finalPasswordToBePrinted : [[String]]?
        
    override func viewWillAppear(_ animated: Bool) {
        let state = passwordsState
        
        if state == .savingPasswords{
            keyLabel.text = stringMainKey
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.delegate = self
        
        if let passwordStoredInKeyChain = storedPasswordArray{
            passwordThatWasStored = passwordsStringToArray(stringToConvert: passwordStoredInKeyChain)
        }
        
        guard let mainKey_ = mainKey, let characters_ = characterSet, let passwordlenght_ = passwordLenght else { return }
        dataModel.requestData(with: mainKey_, characters: characters_, passwordlenght: passwordlenght_)
        
        let state = passwordsState
        
        if state == .newPasswords {
            keyLabel.text = stringKey(mainKey_)
        }
        
        if state == .savingPasswords{
            keyLabel.text = stringMainKey
        }
        
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if let mainKey_ = mainKey{
        
            if let savedMainKey = stringKey(mainKey_){
                KeychainWrapper.standard.set(savedMainKey, forKey: keyChainSequenceKey)
            }
        }
        
        if let PasswordsArray = passwordArray {
            let passwordStringToSaveInKeyChain = passwordsArrayToString(arrayToParse: PasswordsArray)
            KeychainWrapper.standard.set(passwordStringToSaveInKeyChain, forKey: keyChainPasswordArrayKey)
        }

    }
    
    func passwordsArrayToString(arrayToParse array: [[String]]) -> String {
        var sendingArrayEncoded : String = ""
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(array) {
        
            if let arrayEncoded = String(data: jsonData, encoding: .utf8){
                sendingArrayEncoded = arrayEncoded
            }
        }
        return sendingArrayEncoded
    }
    
    func passwordsStringToArray(stringToConvert string: String) -> [[String]] {
        var gettingDecodedString : [[String]] = [[]]
        
        let data = Data(string.utf8)
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String]] {
                gettingDecodedString = json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return gettingDecodedString
    }
}

extension CardsController: DataModelDelegate{
    func didRecieveDataUpdate(data: [[String]]) {
        passwordArray = data
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
        
        if let passwordlenght = passwordLenght {
            if passwordlenght > 4 {
                cell.passwordLabel.font = UIFont.systemFont(ofSize: 8.0)
            }
        }
        
        let state = passwordsState
        
        if state == .newPasswords {
            finalPasswordToBePrinted = passwordArray
        }else if state == .savingPasswords{
            finalPasswordToBePrinted = passwordThatWasStored
        }
                
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.passwordLabel.text = finalPasswordToBePrinted?[indexPath.section][indexPath.item]
        
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

