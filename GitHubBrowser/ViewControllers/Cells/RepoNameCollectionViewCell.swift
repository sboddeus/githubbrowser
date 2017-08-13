//
//  RepoNameCollectionViewCell.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

class RepoNameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var vm: RepoDetailCellViewModel? = nil {
        didSet {
            name.text = vm?.name
            descriptionLabel.text = vm?.shortDescription
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
