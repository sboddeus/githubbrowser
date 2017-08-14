//
//  Repo.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Quick
import Nimble
import GitHubClient

@testable import GitHubBrowser

class ReposCollectionViewModelTests: QuickSpec {

    override func spec() {
        describe("RepoReposCollectionViewModelTests") {
            let testDataSource = GoodTestDataSource()
            let vm = ReposCollectionViewModel(dataSource: testDataSource)
            vm.load {}

            context("Getting data from a good data source") {
                it("should have one repo") {
                    expect(vm.repos?.count) == 1
                }
                it("should be able to product the correct data from the Repo object") {
                    let firstRepo = vm.repos?[0]
                    expect(firstRepo?.description) == GoodTestDataSource.testRepoOne.description
                    expect(firstRepo?.id) == GoodTestDataSource.testRepoOne.id
                    expect(firstRepo?.name) == GoodTestDataSource.testRepoOne.name
                    expect(firstRepo?.owner.id) == GoodTestDataSource.testRepoOne.owner.id
                }
                it("should be able to map repos to repo preview viewModels") {
                    expect(vm.repoViewModels?.count) == 1

                    let firstRepoPreview = vm.repoViewModels?[0]
                    expect(firstRepoPreview?.avatarUrl?.absoluteString) == GoodTestDataSource.testOwnerOne.avatarUrl
                }
            }
        }
    }
}
