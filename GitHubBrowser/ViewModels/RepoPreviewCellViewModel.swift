//
//  RepoPreviewCellViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation

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
}
