//
//  HTTPStub.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 20/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation
import Dispatch
import Alamofire

// Based on https://github.com/ishkawa/APIKit/blob/3.0.0/Tests/APIKitTests/TestComponents/HTTPStub.swift
// and https://github.com/mdiep/Tentacle/blob/0.5.1/Tests/TentacleTests/HTTPStub.swift
class HTTPStub: NSObject {
    static let shared: HTTPStub = HTTPStub()

    var stubRequests: ((URLRequest) -> FixtureType)!
    private var fixture: FixtureType!

    static func initializeStub() {
        if self == HTTPStub.self {
            URLProtocol.registerClass(StubProtocol.self)
        }
    }

    private override init() {
        super.init()
    }

    fileprivate class StubProtocol: URLProtocol {
        private var isCancelled = false

        // MARK: - URLProtocol

        override static func canInit(with: URLRequest) -> Bool {
            return true
        }

        override static func canonicalRequest(for request: URLRequest) -> URLRequest {
            HTTPStub.shared.fixture = HTTPStub.shared.stubRequests(request)
            return request
        }

        override func startLoading() {
            let queue = DispatchQueue.global(qos: .default)

            queue.asyncAfter(deadline: .now() + 0.01) {
                guard !self.isCancelled else {
                    return
                }

                let fixture = HTTPStub.shared.fixture!

                let response = HTTPURLResponse(url: fixture.url, statusCode: fixture.statusCode, httpVersion: "HTTP/1.1", headerFields: [:])!
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: fixture.data)
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }

        override func stopLoading() {
            isCancelled = true
        }
    }
}

extension HTTPStub {
    static var HTTPStubManager: Alamofire.SessionManager {
        let confirguration = URLSessionConfiguration.default
        confirguration.protocolClasses?.insert(StubProtocol.self, at: 0)
        return Alamofire.SessionManager(configuration: confirguration)
    }
}
