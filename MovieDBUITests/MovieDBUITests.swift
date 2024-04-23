//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Mai Hassen on 20/04/2024.
//

import XCTest

final class MovieDBUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
        app = nil
    }
    
    func testOpenDetails() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().collectionViews["Sidebar"].staticTexts["Godzilla x Kong: The New Empire"].tap()
        XCTAssert(app.staticTexts["Godzilla x Kong: The New Empire"].exists)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
