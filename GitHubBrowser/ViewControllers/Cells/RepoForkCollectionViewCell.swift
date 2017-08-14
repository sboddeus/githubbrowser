//
//  RepoForkCollectionViewCell.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

class RepoForkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!

    var vm: RepoDetailCellViewModel? = nil {
        didSet {
            forkLabel.text = vm?.fork
            forkCountLabel.text = vm?.forkCount
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
