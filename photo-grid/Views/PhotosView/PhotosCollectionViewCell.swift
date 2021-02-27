//
//  PhotosCollectionViewCell.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit
import PhotosUI

class PhotosCollectionViewCell: UICollectionViewCell {

    // MARK: - Attributes
    
    @IBOutlet weak var mainImage: UIImageView!
    var assetIdentifier: String!
    
    // MARK: - Class lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        basicSetup()
    }

    // MARK: - Logic
    
    private func basicSetup() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
