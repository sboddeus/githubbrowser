//
//  ReposCollectionViewController.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

enum PublicRepoCellIdentifier: String {
    case header
    case search
    case repo
}

protocol ReposCollectionViewControllerDelegate: class {
    func userDidSelect(repo: RepoDetailViewModel)
}

final class ReposCollectionViewController: UICollectionViewController {

    weak var delegate: ReposCollectionViewControllerDelegate? = nil

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.sectionHeadersPinToVisibleBounds = true

        return flowLayout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView?.collectionViewLayout = flowLayout
        registerCells()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.load { [weak self] in
            self?.setupBindings()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var viewModel: ReposCollectionViewModel? = nil {
        didSet {
            guard isViewLoaded else { return }
            viewModel?.load { [weak self] in
                self?.setupBindings()
            }
        }
    }

    private func setupBindings() {
        collectionView?.reloadSections([RepoSection.repos.rawValue])
    }

    // MARK: UICollectionViewDataSource

    enum RepoSection: Int {
        case header = 0
        case search = 1
        case repos = 2
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch RepoSection(rawValue: section)! {
        case .repos:
            return viewModel?.repoViewModels?.count ?? 0
        default:
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch RepoSection(rawValue: indexPath.section)! {
        case .header:
            return headerCell(collectionView: collectionView, indexPath: indexPath)
        case .search:
            return searchCell(collectionView: collectionView, indexPath: indexPath)
        case .repos:
            return repoCell(collectionView: collectionView, indexPath: indexPath)
        }
    }

    // Helpers

    private func registerCells() {
        collectionView?.register(UINib(nibName: "RepoPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PublicRepoCellIdentifier.repo.rawValue)
        collectionView?.register(UINib(nibName: "RepoHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PublicRepoCellIdentifier.header.rawValue)
        collectionView?.register(UINib(nibName: "RepoSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PublicRepoCellIdentifier.search.rawValue)
    }

    private func headerCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PublicRepoCellIdentifier.header.rawValue, for: indexPath)
    }

    private func searchCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicRepoCellIdentifier.search.rawValue, for: indexPath)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8.0
        return cell
    }

    private func repoCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicRepoCellIdentifier.repo.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoPreviewCollectionViewCell else { return cell }

        repoCell.repoPreviewViewModel = viewModel?.repoViewModels?[indexPath.item]

        return repoCell
    }
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch RepoSection(rawValue: indexPath.section)! {
        case .repos:
            if let repoDetailVM = viewModel?.detailViewModel(itemIndex: indexPath.item) {
                delegate?.userDidSelect(repo: repoDetailVM)
            }
        default:
            break
        }
    }

}

extension ReposCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch RepoSection(rawValue: indexPath.section)! {
        case .header:
            return CGSize(width: view.frame.size.width, height: 80)
        case .search:
            return CGSize(width: view.frame.size.width-40, height: 40)
        case .repos:
            return CGSize(width: view.frame.size.width, height: 70)
        }

    }
}

extension ReposCollectionViewController: StoryboardInstantiatiable {
    static let storyboardName: String = "Main"
    static let storyboardIdentifier: String? = "ReposCollectionViewController"
    static let storyboardBundle: Bundle? = nil
}
