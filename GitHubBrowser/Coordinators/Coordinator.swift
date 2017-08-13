//
//  Coordinator.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Foundation

class Coordinator {
    private(set) var children: [Coordinator] = []
    var completion: (() -> Void)?

    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        if let index = children.index(where: { $0 === coordinator }) {
            children.remove(at: index)
        }
    }

    func child<T: Coordinator>(ofType: T.Type) -> T? {
        return children.first { $0 is T } as? T
    }
}
