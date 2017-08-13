//
//  TestModels.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation
@testable import GitHubBrowser

struct GoodTestDataSource: RepoDataSource {
    static let testOwnerOne = Owner(id: 1, login: "owner one", avatarUrl: "www.google.com")
    static let testRepoOne = Repo(id: 1, name: "Test Repo One", description: "A test repo", owner: testOwnerOne)

    func fetchPublicRepos(since: String?, completion: @escaping ([Repo]?, Error?) -> ()) {
        completion([GoodTestDataSource.testRepoOne], nil)
    }
}

