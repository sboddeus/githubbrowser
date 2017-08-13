//
//  RepoPreviewCellViewModelTests.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Quick
import Nimble

@testable import GitHubBrowser

class RepoPreviewCellViewModelTests: QuickSpec {

    override func spec() {
        describe("RepoReposCollectionViewModelTests") {
            let vm = RepoPreviewCellViewModel(repo: GoodTestDataSource.testRepoOne)

            context("Getting data from a good data source") {

                it("should be able to produce the correct data from the Repo object") {
                    expect(vm.avatarUrl) == URL(string: GoodTestDataSource.testRepoOne.owner.avatarUrl!)
                    expect(vm.shortDescription) == GoodTestDataSource.testRepoOne.description
                    expect(vm.name) == GoodTestDataSource.testRepoOne.name
                }
            }
        }
    }
}

