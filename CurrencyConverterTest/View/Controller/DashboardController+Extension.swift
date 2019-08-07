//
//  DashboardController+Extension.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

extension DashboardController{
    //Select the currency you want to convert from
    @objc func onFromTapped(){
        isSelectedFrom(status: true)
        collectionView.isHidden = false
    }
    
    //Select the currency you want to convert to.
    @objc func onToTapped(){
        isSelectedFrom(status: false)
        collectionView.isHidden = false
    }
    
    //Define the size of items
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.items.count;
    }
    
    //Each cell that will be created.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CountryListCell
        let countryCode = self.items[indexPath.item].countryCode
        cell.item = "  ".flag(country: countryCode) + countryCode + "    ▼"
        
        return cell
    }
    //Size of each cell on the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 50)
    }
    //Setting the edge for the collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left:0, bottom: 10, right: 0)
    }
    //Define the action that takes place once an item has been selected on the collectionview
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountry = self.items[indexPath.item]
        let selectedCountryCode = selectedCountry!.countryCode
        self.collectionView.isHidden = true
        if fromIsSelected{
            fromCountryCurrencyLabel.text = "  ".flag(country: selectedCountryCode) + selectedCountryCode + "    ▼"
        }else{
            toCountryCurrencyLabel.text = "  ".flag(country: selectedCountryCode) + selectedCountryCode + "    ▼"
        }
    }
    
    //Carry out the calculation as the user inputs the data
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstCurrencyField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            print(updatedText)
            secondCurrencyField.text = String((Double(updatedText ) ?? 0.0) * (selectedCountry?.countryRate ?? 0.0))
            
            return updatedText.count <= 30
            
        }
        if textField == secondCurrencyField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            print(updatedText)
            firstCurrencyField.text = String((Double(updatedText ) ?? 0.0) / (selectedCountry?.countryRate ?? 0.0))
            
            return updatedText.count <= 30
        }
        return true
        
    }
    
    //Delegate result for the expected event
    func isSelectedFrom(status: Bool) {
        fromIsSelected = status
    }
    
    //Communicate with fixer.io
    func initData(){
        ApiService().currencyListCall(){
            (result, data, error) in
            if result{
                self.items = data
                self.collectionView.reloadData()
            }
            
        }
    }
}
