//
//  RepoPreviewCellViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import GitHubClient

struct RepoPreviewCellViewModel {
    private let repo: Repo

    init(repo: Repo) {
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
}
