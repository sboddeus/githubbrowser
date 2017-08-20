//
//  Fixture.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 20/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation
@testable import GitHubClient

protocol FixtureType {
    var url: URL { get }
    var statusCode: Int { get }
}

extension FixtureType {
    var statusCode: Int {
        return 200
    }
}

extension FixtureType {
    /// The filename used for the local fixture, without an extension
    private func filename(withExtension ext: String) -> String {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        var filteredComponents = (components.path as NSString)
            .pathComponents
            .dropFirst()
        if filteredComponents.last == "/" {
            filteredComponents = filteredComponents.dropLast()
        }

        let path = filteredComponents
            .joined(separator: "-")

        let query = components.queryItems?
            .map { item in
                if let value = item.value {
                    return "\(item.name)-\(value)"
                } else {
                    return item.name
                }
            }
            .joined(separator: "-")

        if let query = query, query != "" {
            return "\(path).\(query).\(ext)"
        }
        return "\(path).\(ext)"
    }

    /// The filename used for the local fixture's data.
    var dataFilename: String {
        return filename(withExtension: Fixture.DataExtension)
    }

    /// The filename used for the local fixture's HTTP response.
    var responseFilename: String {
        return filename(withExtension: Fixture.ResponseExtension)
    }

    private func fileURL(withExtension ext: String) -> URL {
        let filename = self.filename(withExtension: ext) as NSString

        let bundle = Bundle(for: HTTPStub.self)
        return bundle.url(forResource: filename.deletingPathExtension, withExtension: filename.pathExtension)!
    }

    /// The URL of the fixture's data within the test bundle.
    var dataFileURL: URL {
        return fileURL(withExtension: Fixture.DataExtension)
    }

    /// The URL of the fixture's HTTP response within the test bundle.
    var responseFileURL: URL {
        return fileURL(withExtension: Fixture.ResponseExtension)
    }

    /// The data from the endpoint.
    var data: Data {
        return (try! Data(contentsOf: dataFileURL))
    }

    /// The HTTP response from the endpoint.
    var response: HTTPURLResponse {
        let data = try! Data(contentsOf: responseFileURL)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! HTTPURLResponse
    }

    /// The JSON from the Endpoint.
    var JSON: Any {
        return try! JSONSerialization.jsonObject(with: data)
    }

    /// Decode the fixture's JSON as an object of the returned type.
//    func decode<T: Decodable>() -> T {
//        return try! T.decodeValue(JSON)
//    }
}

struct Fixture {
    fileprivate static let DataExtension = "json"
    fileprivate static let ResponseExtension = "response"

    static var allFixtures: [FixtureType] = [
        Owner(),
        Repo(),
        RepoCollection()
    ]

    /// Returns the fixture for the given URL, or nil if no such fixture exists.
    static func fixtureForURL(_ url: URL) -> FixtureType? {
        return allFixtures.first { $0.url == url }
    }

    struct Owner: FixtureType {
        var url: URL {
            return URL(string: "https://api.github.com/users/mojombo")!
        }
    }

    struct Repo: FixtureType {
        var url: URL {
            return URL(string: "https://api.github.com/repos/mojombo/grit")!
        }
    }

    struct RepoCollection: FixtureType {
        var url: URL {
            return URL(string: "https://api.github.com/repositories")!
        }
    }
}
