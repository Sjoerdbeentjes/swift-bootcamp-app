//
//  EventExplorerTests.swift
//  EventExplorerTests
//
//  Created by Sjoerd Beentjes on 11-11-15.
//  Copyright © 2015 Sjoerd Beentjes. All rights reserved.
//

import XCTest
@testable import EventExplorer

class EventExplorerTests: XCTestCase {
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        // Success case.
        let potentialItem = Event(name: "Newest meal", photo: nil)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Event(name: "", photo: nil)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Event(name: "Really bad rating", photo: nil)
        XCTAssertNotNil(badRating)
    }
    
}
