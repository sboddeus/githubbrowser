//
//  TestModels.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

@testable import GitHubClient
@testable import GitHubBrowser

import SwiftCheck


// Test Data Sources and Models
struct GoodTestDataSource: RepoDataSource {
    static let testOwnerOne = Owner(id: 1, login: "owner one", avatarUrl: "www.google.com")
    static let testRepoOne = Repo(id: 1, name: "Test Repo One", description: "A test repo", url: "www.google.com", owner: testOwnerOne)
    static let testDetailedRepoOne = RepoDetailed(id: 1, name: "Test Repo One", description: "A test repo", url: "www.google.com", fork: false, forksCount: 10, watchersCount: 10, openIssuesCount: 10, owner: testOwnerOne)

    func fetchPublicRepos(since: String?, completion: @escaping ([Repo]?, Error?) -> ()) {
        completion([GoodTestDataSource.testRepoOne], nil)
    }

    func fetchRepoDetails(url: URL, completion: @escaping (RepoDetailed?, Error?) -> ()) {
        completion(GoodTestDataSource.testDetailedRepoOne, nil)
    }
}

// Test Coordinators

class DummyOneCoordinator: Coordinator {}
class DummyTwoCoordinator: Coordinator {}

// Arbitrary generation

extension Owner: Arbitrary {
    public static var arbitrary: Gen<Owner> {
        return Gen.compose(build: { c in
            return Owner(id: c.generate(), login: c.generate(), avatarUrl: c.generate())
        })
    }
}

extension Repo: Arbitrary {
    public static var arbitrary: Gen<Repo> {
        return Gen.compose(build: { c in
            return Repo(id: c.generate(), name: c.generate(), description: c.generate(), url: c.generate(), owner: c.generate())
        })
    }
}
