//
//  Fixture.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 14/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Himotoki
@testable import GitHubClient

// This could be invovled to include complete API HTTP stubbing
// In its complete form, it would allow us to test the complete network stack
// but this will be limited to deserialistion for now
struct GitHubFixture {
    var publicRepos: [Repo]? {
        if let json = try? JSONSerialization.jsonObject(with: Data(contentsOf: Bundle(for: Foo.self).url(forResource: "repos", withExtension: "json")!)) {
            return try? [Repo].decode(json)
        }

        return nil
    }


    var detailedRepo: RepoDetailed? {
        if let json = try? JSONSerialization.jsonObject(with: Data(contentsOf: Bundle(for: Foo.self).url(forResource: "repoOne", withExtension: "json")!)) {
            return try? RepoDetailed.decodeValue(json)
        }

        return nil
    }

    var owner: Owner? {
        if let json = try? JSONSerialization.jsonObject(with: Data(contentsOf: Bundle(for: Foo.self).url(forResource: "owner", withExtension: "json")!)) {
            return try? Owner.decodeValue(json)
        }

        return nil
    }


    // This is a dummy class that simple enables us to use
    // Bundle(for: AnyClass) to return the correct bundle
    class Foo {}
}

extension String: Error {}
