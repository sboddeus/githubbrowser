//
//  Repo.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

struct Repo {
    let id: Int
    let name: String?
    let description: String?
    let url: String
    let owner: Owner
}

extension Repo: Decodable {
    static func decode(_ e: Extractor) throws -> Repo {
        return try Repo(id: e <| "id",
                        name: e <|? "full_name",
                        description: e <|? "description",
                        url: e <| "url",
                        owner: e <| "owner")
    }
}
