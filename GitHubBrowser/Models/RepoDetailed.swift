//
//  RepoDetailed.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

struct RepoDetailed {
    let id: Int
    let name: String?
    let description: String?
    let url: String?
    let fork: Bool
    let forksCount: Int
    let watchersCount: Int
    let openIssuesCount: Int
    let owner: Owner
}

extension RepoDetailed: Decodable {
    static func decode(_ e: Extractor) throws -> RepoDetailed {
        return try RepoDetailed(id: e <| "id",
                        name: e <|? "full_name",
                        description: e <|? "description",
                        url: e <| "url",
                        fork: e <| "fork",
                        forksCount: e <| "forks_count",
                        watchersCount: e <| "watchers_count",
                        openIssuesCount: e <| "open_issues",
                        owner: e <| "owner")
    }
}
