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
        // Setup Mocking
        HTTPStub.initializeStub()
        HTTPStub.shared.stubRequests = { request in
            return Fixture.fixtureForURL(request.url!)!
        }

        let dataSource = GitHubRepoDataSource(manager: HTTPStub.HTTPStubManager)

        var repository: RepoDetailed? = nil
        var repoCollection: [Repo]? = nil
        var owner: Owner? = nil

        waitUntil { done in
            dataSource.fetchRepoDetails(url: URL(string: "https://api.github.com/repos/mojombo/grit")!) { (repo, error) in
                repository = repo
                owner = repo?.owner
                done()
            }
        }

        waitUntil { done in
            dataSource.fetchPublicRepos(since: nil) { (repos, error) in
                repoCollection = repos
                done()
            }
        }

        describe("GitHubClientTests") {
            context("publicRepos deserialisation") {
                it("should deserialise repos") {
                    expect(repoCollection?.count) == 100
                }
            }
            context("detailed repo") {
                it("should deserialise a detailed id") {
                    expect(repository?.id) == 1
                }
                it("should deserialise a url") {
                    expect(repository?.url) == "https://api.github.com/repos/mojombo/grit"
                }
                it("should deserialise a description") {
                    expect(repository?.description) == "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby."
                }
                // We should continue testing the remaining elements
            }
            context("owner") {
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

