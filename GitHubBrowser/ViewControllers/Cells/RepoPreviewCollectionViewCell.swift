//
//  RepoPreviewCollectionViewCell.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit
import SDWebImage

class RepoPreviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var image: UIImageView!

    var repoPreviewViewModel: RepoPreviewCellViewModel? = nil {
        didSet {
            name.text = repoPreviewViewModel?.name
            shortDescription.text = repoPreviewViewModel?.shortDescription
            image.sd_setImage(with: repoPreviewViewModel?.avatarUrl, completed: nil)

            image.layer.cornerRadius = 10
            image.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
