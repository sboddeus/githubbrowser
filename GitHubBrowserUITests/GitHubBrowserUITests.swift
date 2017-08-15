//
//  GitHubBrowserUITests.swift
//  GitHubBrowserUITests
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import XCTest

class GitHubBrowserUITests: XCTestCase {
    let app = XCUIApplication()
    let waitTime: UInt32 = 3
    let shortWaitTime: UInt32 = 1

    override func setUp() {
        super.setUp()
        // At some point here I would insert a mock API fixture into our app to speed up testin

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        waitForElementToExist(app)
    }

    func testRepoViewLoads() {
        sleep(waitTime)
        XCTAssert(app.collectionViews["reposCollection"].exists, "Repo collection not loaded")
        XCTAssert(app.collectionViews["reposCollection"].cells.count > 0, "Repo could not load cells")
    }

    func testCoreFlow() {
        sleep(waitTime)
        let item = app.collectionViews["reposCollection"].cells.element(boundBy: 3)
        XCTAssert(item.exists, "No repo cells loaded")

        item.tap()
        sleep(shortWaitTime)
        XCTAssert(app.collectionViews["repoDetail"].exists, "Repo detail could not load")

        let close = app.collectionViews["repoDetail"].cells.element(boundBy: 0)
        XCTAssert(close.exists, "View did not load")
        close.tap()

        sleep(shortWaitTime)
        XCTAssert(app.collectionViews["reposCollection"].exists, "Did not make it back to home page")
    }

}
