//
//  CoreCoordinator.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit
import GitHubClient

final class CoreCoordinator: Coordinator {
    fileprivate var rootContainerViewController: RootContainerViewController!

    func start(window: UIWindow, application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) {
        guard let rootContainerViewController = window.rootViewController as? RootContainerViewController else {
            fatalError("App doesn't have a root container view controller")
        }
        self.rootContainerViewController = rootContainerViewController

        showPublicRepos()
    }

    private func showPublicRepos() {
        let vc = ReposCollectionViewController.makeController()
        vc.viewModel = ReposCollectionViewModel(dataSource: GitHubRepoDataSource())
        vc.delegate = self
        
        rootContainerViewController.show(viewController: vc)
    }

    fileprivate func showDetail(repo: RepoDetailViewModel) {
        let vc = RepoDetailCollectionViewController.makeController()
        vc.viewModel = repo
        vc.delegate = self

        rootContainerViewController.push(viewController: vc)
    }

}

extension CoreCoordinator: RepoDetailCollectionViewControllerDelegate {
    func userDidClose() {
        rootContainerViewController.pop()
    }
}

extension CoreCoordinator: ReposCollectionViewControllerDelegate {
    func userDidSelect(repo: RepoDetailViewModel) {
        showDetail(repo: repo)
    }
}
