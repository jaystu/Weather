//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by John Stuart on 6/11/16.
//  Copyright © 2016 John Stuart. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class WeatherTests: XCTestCase {
    
    // Tests to confirm that the Hour initializer returns nil when temperature or icon is empty
    func testHourInitialization() {
        // Success case.
        let potentialHour = Hour(time: NSDate(), temperature: "75", icon: "clear-day")
        XCTAssertNotNil(potentialHour)
        
        // Failure cases.
        let noTemperature = Hour(time: NSDate(), temperature: "", icon: "clear-day")
        XCTAssertNil(noTemperature, "Empty temperature is invalid")
        
        let noIcon = Hour(time: NSDate(), temperature: "75", icon: "")
        XCTAssertNil(noIcon, "Empty icon is invalid")
        
        let noTempOrIcon = Hour(time: NSDate(), temperature: "", icon: "")
        XCTAssertNil(noTempOrIcon, "Both temperature and icon are empty and therefore invalid")
    }
    
}
