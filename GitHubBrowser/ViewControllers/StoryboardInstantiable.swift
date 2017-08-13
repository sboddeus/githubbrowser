//
//  StoryboardInstantiable.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiatiable {

    static var storyboardName: String { get }
    static var storyboardIdentifier: String? { get }
    static var storyboardBundle: Bundle? { get }

    static func makeController() -> Self
}

extension StoryboardInstantiatiable {
    static func makeController() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)

        if let storyboardIdentifier = storyboardIdentifier {
            return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}
