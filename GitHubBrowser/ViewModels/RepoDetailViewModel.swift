//
//  RepoDetailViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation

class RepoDetailViewModel {
    private let dataSource: RepoDataSource

    private let repo: Repo
    var detail: RepoDetailed?

    var cellViewModel: RepoDetailCellViewModel? {
        if let detail = detail {
            return RepoDetailCellViewModel(repo: detail)
        }

        return nil
    }

    init(repo: Repo, dataSource: RepoDataSource) {
        self.repo = repo
        self.dataSource = dataSource
        self.detail = nil
    }

    func load(completion: @escaping (() -> ())) {
        dataSource.fetchRepoDetails(url: URL(string: repo.url)!) { (detail, error) in
            if let error = error {
                print(error)
            }

            self.detail = detail

            completion()
        }
    }
}
