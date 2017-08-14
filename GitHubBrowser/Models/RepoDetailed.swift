//
//  RepoDetailed.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

public struct RepoDetailed {
    public let id: Int
    public let name: String?
    public let description: String?
    public let url: String?
    public let fork: Bool
    public let forksCount: Int
    public let watchersCount: Int
    public let openIssuesCount: Int
    public let owner: Owner
}

extension RepoDetailed: Decodable {
    public static func decode(_ e: Extractor) throws -> RepoDetailed {
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
