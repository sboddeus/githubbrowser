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
    }

    // MARK: UICollectionViewDataSource

    enum RepoDetailSection: Int {
        case name = 0
        case description = 1
        case fork = 2
        case counts = 3
        case owner = 4
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch RepoDetailSection(rawValue: indexPath.section)! {
        case .name:
            return nameCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }

    // Helpers
    private func nameCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoDetailCellIdentifier.name.rawValue, for: indexPath)

        guard let repoCell = cell as? RepoNameCollectionViewCell else { return cell }

        repoCell.vm = viewModel?.cellViewModel

        return repoCell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidClose()
    }

}

extension RepoDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }
}

extension RepoDetailCollectionViewController: StoryboardInstantiatiable {
    static let storyboardName: String = "Main"
    static let storyboardIdentifier: String? = "RepoDetailCollectionViewController"
    static let storyboardBundle: Bundle? = nil
}
