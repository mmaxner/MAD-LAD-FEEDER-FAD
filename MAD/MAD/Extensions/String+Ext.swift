//
//  String+Ext.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-13.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

extension String {
    public var number: Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = numberFormatter.number(from: self)
        return Int(truncating: number ?? 0)
    }
}
