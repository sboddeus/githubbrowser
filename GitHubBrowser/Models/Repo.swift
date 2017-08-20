//
//  Repo.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

public struct Repo {
    public let id: Int
    public let name: String?
    public let description: String?
    public let url: String
    public let owner: Owner
}

extension Repo: Decodable {
    public static func decode(_ e: Extractor) throws -> Repo {
        return try Repo(id: e <| "id",
                        name: e <|? "full_name",
                        description: e <|? "description",
                        url: e <| "url",
                        owner: e <| "owner")
    }
}

extension Repo: Hashable {
    public static func ==(lhs: Repo, rhs: Repo) -> Bool {
        return lhs.id == rhs.id
    }

    public var hashValue: Int {
        return id
    }
}
