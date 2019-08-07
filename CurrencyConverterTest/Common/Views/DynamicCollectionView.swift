//
//  DynamicCollectionView.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let size = self.contentSize
        return size
    }
}
