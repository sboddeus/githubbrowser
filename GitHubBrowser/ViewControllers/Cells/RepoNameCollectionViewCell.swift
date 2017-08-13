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

    var repoPreviewViewModel: RepoPreviewCellViewModel? = nil {
        didSet {
            name.text = repoPreviewViewModel?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
