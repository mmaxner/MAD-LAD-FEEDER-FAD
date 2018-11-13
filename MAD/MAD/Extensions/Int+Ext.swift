//
//  Int+Ext.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-12.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

extension Int {
    public var internationalize: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: self)
    }
}
