//
//  RepoDetailCollectionViewController.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 12/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

enum RepoDetailCellIdentifier: String {
    case close
    case name
    case description
    case fork
    case counts
    case owner
}

protocol RepoDetailCollectionViewControllerDelegate: class {
    func userDidClose()
}

final class RepoDetailCollectionViewController: UICollectionViewController {

    weak var delegate: RepoDetailCollectionViewControllerDelegate? = nil

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

    var viewModel: RepoDetailViewModel? = nil {
        didSet {
            guard isViewLoaded else { return }
            viewModel?.load {
                self.setupBindings()
            }
        }
    }

    var cellViewModel: RepoDetailCellViewModel? = nil

    private func setupBindings() {
        collectionView?.reloadData()
    }

    func registerCells() {
        collectionView?.register(UINib(nibName: "RepoNameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RepoDetailCellIdentifier.name.rawValue)
        collectionView?.register(UINib(nibName: "RepoForkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RepoDetailCellIdentifier.fork.rawValue)
        collectionView?.register(UINib(nibName: "RepoOwnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RepoDetailCellIdentifier.owner.rawValue)
        collectionView?.register(UINib(nibName: "RepoCountsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RepoDetailCellIdentifier.counts.rawValue)
    }

    // MARK: UICollectionViewDataSource

    enum RepoDetailSection: Int {
        case name = 0
        case fork = 1
        case counts = 2
        case owner = 3
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch RepoDetailSection(rawValue: indexPath.section)! {
        case .name:
            return nameCell(collectionView: collectionView, indexPath: indexPath)
        case .fork:
            return forkCell(collectionView: collectionView, indexPath: indexPath)
        case .counts:
            return countsCell(collectionView: collectionView, indexPath: indexPath)
        case .owner:
            return ownerCell(collectionView: collectionView, indexPath: indexPath)
        }
    }

    // Helpers
    private func nameCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoDetailCellIdentifier.name.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoNameCollectionViewCell else { return cell }

        repoCell.vm = viewModel?.cellViewModel

        return repoCell
    }

    private func forkCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoDetailCellIdentifier.fork.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoForkCollectionViewCell else { return cell }

        repoCell.vm = viewModel?.cellViewModel

        return repoCell
    }

    private func countsCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoDetailCellIdentifier.counts.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoCountsCollectionViewCell else { return cell }

        repoCell.vm = viewModel?.cellViewModel
        
        return repoCell
    }

    private func ownerCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoDetailCellIdentifier.owner.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoOwnerCollectionViewCell else { return cell }

        repoCell.vm = viewModel?.cellViewModel
        
        return repoCell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidClose()
    }

}

extension RepoDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch RepoDetailSection(rawValue: indexPath.section)! {
        case .name:
            return CGSize(width: view.frame.size.width, height: 160)
        case .fork:
            return CGSize(width: view.frame.size.width, height: 120)
        case .counts:
            return CGSize(width: view.frame.size.width, height: 120)
        case .owner:
            return CGSize(width: view.frame.size.width, height: 300)
        }
    }
}

extension RepoDetailCollectionViewController: StoryboardInstantiatiable {
    static let storyboardName: String = "Main"
    static let storyboardIdentifier: String? = "RepoDetailCollectionViewController"
    static let storyboardBundle: Bundle? = nil
}
