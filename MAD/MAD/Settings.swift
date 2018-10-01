//
//  Settings.swift
//  MAD
//
//  Created by Student on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

public class Settings{
    public var name : String = ""
    public var calories : Float = 0
    public static let instance = Settings()
    
    private init() {
    
    }
}
