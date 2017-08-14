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
            context("publicRepos deserialisation") {
                let repos = fixture.publicRepos

                it("should deserialise repos") {
                    expect(repos?.count) == 100
                }
            }
            context("detailed repo") {
                let detailedRepo = fixture.detailedRepo

                it("should deserialise a detailed id") {
                    expect(detailedRepo?.id) == 1
                }
                it("should deserialise a url") {
                    expect(detailedRepo?.url) == "https://api.github.com/repos/mojombo/grit"
                }
                it("should deserialise a description") {
                    expect(detailedRepo?.description) == "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby."
                }
                // We should continue testing the remaining elements
            }
            context("owner") {
                let owner = fixture.owner

                it("should deserialise an id") {
                    expect(owner?.id) == 1
                }
                it("should deserialise and avatar") {
                    expect(owner?.avatarUrl) == "https://avatars0.githubusercontent.com/u/1?v=4"
                }
                it("should deserialise a login") {
                    expect(owner?.login) == "mojombo"
                }
            }
        }
    }
}

