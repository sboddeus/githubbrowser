//
//  RepoOwnerCollectionViewCell.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import UIKit

class RepoOwnerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!

    var vm: RepoDetailCellViewModel? = nil {
        didSet {
            avatarImage.sd_setImage(with: vm?.avatarUrl, completed: nil)
            name.text = vm?.name

            avatarImage.layer.cornerRadius = 10
            avatarImage.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
