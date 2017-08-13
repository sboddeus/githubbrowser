//
//  RepoDetailViewModel.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation

struct RepoDetailViewModel {
    private let dataSource: RepoDataSource

    init(dataSource: RepoDataSource) {
        self.dataSource = dataSource
    }
}
