//
//  Owner.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

struct Owner {
    let id: Int
    let login: String?
    let avatarUrl: String?
}

extension Owner: Decodable {
    static func decode(_ e: Extractor) throws -> Owner {
        return try Owner(id: e <| "id",
                        login: e <|? "login",
                        avatarUrl: e <|? "avatar_url")
    }
}
