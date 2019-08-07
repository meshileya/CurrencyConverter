//
//  CountryListCell.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class CountryListCell : UICollectionViewCell {
    
    var item: String? {
        didSet {
            if let model = item {
                textLabel.text = model
            }
        }
    }
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .primaryColor
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.sizeToFit()
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView (){
        sizeToFit()
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 2.0);
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        
        addSubview(textLabel)
        
        addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
}
