//
//  Owner.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki

public struct Owner {
    public let id: Int
    public let login: String?
    public let avatarUrl: String?
}

extension Owner: Decodable {
    public static func decode(_ e: Extractor) throws -> Owner {
        return try Owner(id: e <| "id",
                        login: e <|? "login",
                        avatarUrl: e <|? "avatar_url")
    }
}

extension Owner: Hashable {
    public static func ==(lhs: Owner, rhs: Owner) -> Bool {
        return lhs.id == rhs.id
    }

    public var hashValue: Int {
        return id
    }
}
