//
//  GitHubClientTests.swift
//  GitHubClientTests
//
//  Created by Sye Boddeus on 14/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//
import Quick
import Nimble

@testable import GitHubClient

class GitHubClientTests: QuickSpec {

    override func spec() {
        let fixture = GitHubFixture()
        describe("GitHubClientTests") {
            context("model deserialisation") {
                it("should deserialise repos") {
                    let repos = fixture.publicRepos

                    expect(repos?.count) == 100
                }
                it("should deserialise a detailed repo") {
                    let detailedRepo = fixture.detailedRepo

                    expect(detailedRepo?.id) == 1
                    expect(detailedRepo?.url) == "https://api.github.com/repos/mojombo/grit"
                    expect(detailedRepo?.description) == "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby."
                    // We should continue testing the remaining elements

                }
                it("should deserialise an owner") {
                    let owner = fixture.owner

                    expect(owner?.id) == 1
                    expect(owner?.avatarUrl) == "https://avatars0.githubusercontent.com/u/1?v=4"
                    expect(owner?.login) == "mojombo"
                }
            }
        }
    }
}

