//
//  CoordinatorTests.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 15/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Quick
import Nimble

@testable import GitHubBrowser

class CoordinatorTests: QuickSpec {

    override func spec() {
        describe("CoordinatorTests") {
            let coordinator = Coordinator()
            let dummyOneCoordinator = DummyOneCoordinator()
            let dummyTwoCoordinator = DummyTwoCoordinator()

            context("Adding and removing children", {
                it("should add children and retrieve them as children") {
                    coordinator.addChild(dummyOneCoordinator)

                    expect(coordinator.child(ofType: DummyOneCoordinator.self)) === dummyOneCoordinator
                }
                it("should remove children") {
                    coordinator.removeChild(dummyOneCoordinator)

                    expect(coordinator.child(ofType: DummyOneCoordinator.self)).to(beNil())
                }
                it("should be able to retrieve the correct child") {
                    coordinator.addChild(dummyOneCoordinator)
                    coordinator.addChild(dummyTwoCoordinator)

                    expect(coordinator.child(ofType: DummyOneCoordinator.self)) === dummyOneCoordinator
                    expect(coordinator.child(ofType: DummyTwoCoordinator.self)) === dummyTwoCoordinator
                }
            })
        }
    }
}

