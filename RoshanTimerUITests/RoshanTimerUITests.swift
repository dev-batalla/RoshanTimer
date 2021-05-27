//
//  RoshanTimerUITests.swift
//  RoshanTimerUITests
//
//  Created by Jay Batalla on 5/27/21.
//

import XCTest

class RoshanTimerUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialText() {
        XCTAssert(app.staticTexts["Killed Roshan"].isHittable)
        XCTAssert(app.staticTexts["Killed Aegis"].isHittable)
        XCTAssert(app.staticTexts["Roshan is Alive"].isHittable)
        XCTAssert(app.staticTexts["The Aegis of the Immortal has not been dropped"].isHittable)
    }
    
    func testRoshanTimer() {
        app.buttons["Killed Roshan"].tap()
        
        XCTAssert(app.staticTexts["Roshan is Dead"].isHittable)
        XCTAssert(app.staticTexts["The Aegis of the Immortal is Up"].isHittable)
    }
    
    func testAegisKilled() {
        app.buttons["Killed Roshan"].tap()
        app.buttons["Killed Aegis"].tap()
        
        XCTAssert(app.staticTexts["The Aegis of the Immortal is Down"].isHittable)
    }
}
