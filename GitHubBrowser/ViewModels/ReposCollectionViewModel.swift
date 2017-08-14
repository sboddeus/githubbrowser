//
//  ReposCollectionViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation
import GitHubClient

class ReposCollectionViewModel {
    private let dataSource: RepoDataSource

    var repos: [Repo]? = nil {
        didSet {
            if let repos = repos {
                self.repoViewModels = repos.map({ RepoPreviewCellViewModel(repo: $0)})
            } else {
                self.repoViewModels = nil
            }
        }
    }

    var repoViewModels: [RepoPreviewCellViewModel]? = nil

    func detailViewModel(itemIndex: Int) -> RepoDetailViewModel? {
        if let repo = repos?[itemIndex] {
            return RepoDetailViewModel(repo: repo, dataSource: dataSource)
        }

        return nil
    }

    init(dataSource: RepoDataSource) {
        self.dataSource = dataSource
    }

    func load(completion: @escaping (() -> ())) {
        dataSource.fetchPublicRepos(since: nil) { (repositories, error) in
            if let repositories = repositories {
                self.repos = repositories
            } else {
                print(error?.localizedDescription)
            }

            completion()
        }
    }
}
