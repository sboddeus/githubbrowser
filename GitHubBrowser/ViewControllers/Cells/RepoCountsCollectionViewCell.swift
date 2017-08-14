//
//  RepoCountsCollectionViewCell.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

class RepoCountsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var vm: RepoDetailCellViewModel? = nil {
        didSet {
            watchersLabel.text = vm?.watchersCount
            issuesLabel.text = vm?.issuesCount
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
