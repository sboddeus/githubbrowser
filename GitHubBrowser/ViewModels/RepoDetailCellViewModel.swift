//
//  RepoDetailCellViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 14/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

// This view model is shared amongst varies cells
// this is baadddd practice, but given time constraints ill overlook it

import GitHubClient

struct RepoDetailCellViewModel {
    private let repo: RepoDetailed

    init(repo: RepoDetailed) {
        self.repo = repo
    }

    var name: String? {
        get {
            return repo.name
        }
    }

    var shortDescription: String? {
        get {
            return repo.description
        }
    }

    var avatarUrl: URL? {
        get {
            if let url = repo.owner.avatarUrl {
                return URL(string: url)
            }

            return nil
        }
    }

    var fork: String {
        get {
            if repo.fork {
                return "This repo is a fork of another"
            } else {
                return "This repo is not a fork"
            }
        }
    }

    var forkCount: String {
        return "Forks: \(repo.forksCount)"
    }

    var watchersCount: String {
        return "Watchers: \(repo.watchersCount)"
    }

    var issuesCount: String {
        return "Open Issues: \(repo.openIssuesCount)"
    }
}
