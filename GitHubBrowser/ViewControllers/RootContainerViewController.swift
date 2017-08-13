//
//  RootContainerViewController.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Cartography

class RootContainerViewController: UIViewController {
    public private(set) weak var currentViewController: UIViewController?

    func show(viewController: UIViewController) {
        addChildView(of: viewController)

        if let currentViewController = currentViewController {
            UIView.transition(from: currentViewController.view, to: viewController.view, duration: 0.3, options: .transitionCrossDissolve) { _ in
                self.removeChildView(of: currentViewController)
                self.currentViewController = viewController
            }
        } else {
            viewController.view.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                viewController.view.alpha = 1
            }, completion: { _ in
                self.currentViewController = viewController
            })
        }
    }

    private func addChildView(of viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        constrain(viewController.view) { view in
            view.edges == view.superview!.edges
        }
        viewController.didMove(toParentViewController: self)
    }

    private func removeChildView(of viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}
