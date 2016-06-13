//
//  Hour.swift
//  Weather
//
//  Created by John Stuart on 6/11/16.
//  Copyright © 2016 John Stuart. All rights reserved.
//

import Foundation

class Hour {
    
    // MARK: Properties
    var time : NSDate
    var temperature : String
    var icon : String
    
    init() {
        // Initialize stored properties.
        self.time = NSDate()
        self.temperature = ""
        self.icon = ""
    }
    
    init?(time: NSDate, temperature: String, icon : String) {
        // Initialize stored properties.
        self.time = time
        self.temperature = temperature
        self.icon = icon
        
        if temperature.isEmpty || icon.isEmpty {
            return nil
        }
    }
    
}