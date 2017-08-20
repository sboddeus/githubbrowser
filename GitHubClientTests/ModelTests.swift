//
//  ModelTests.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 20/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//
import XCTest
import SwiftCheck

@testable import GitHubClient

class ModelTests: XCTestCase {
    func testAll() {
        property("Owners are only equatble by id") <- forAll({ (n1: Int, n2: String, n3: String, n4: String, n5: String) -> Testable in
            return Owner(id: n1, login: n2, avatarUrl: n3) == Owner(id: n1, login: n4, avatarUrl: n5)
        })

        property("Repos are only equatble by id") <- forAll({ (n1: Int, n2: String, n3: String, n4: String, n5: String) -> Testable in
            return Repo(id: n1, name: n2, description: n2, url: n2, owner: Owner(id: n1, login: n2, avatarUrl: n2)) == Repo(id: n1, name: n4, description: n4, url: n5, owner: Owner(id: n1, login: n2, avatarUrl: n2))
        })
    }
}
