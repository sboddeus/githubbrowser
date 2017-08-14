//
//  RepoDetailCellViewModelTests.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 14/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Quick
import Nimble

@testable import GitHubBrowser

class RepoDetailCellViewModelTests: QuickSpec {
    override func spec() {
        describe("RepoDetailCollectionViewModelTests") { 
            let vm = RepoDetailCellViewModel(repo: GoodTestDataSource.testDetailedRepoOne)

            context("Data Presentations", { 
                it("should transform fork") {
                    expect(vm.fork) == "This repo is not a fork"
                    expect(vm.forkCount) == "Forks: 10"
                }

                it("should transform the avatar url") {
                    expect(vm.avatarUrl) == URL(string: "www.google.com")
                }

                it("should transform the description") {
                    expect(vm.shortDescription) == "A test repo"
                }

                it("should transform the watchers count") {
                    expect(vm.watchersCount) == "Watchers: 10"
                }

                it("should transform the open issues count") {
                    expect(vm.issuesCount) == "Open Issues: 10"
                }
            })
        }
    }
}
