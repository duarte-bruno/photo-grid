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
    
    @IBOutlet private weak var mainImage: CustomImageView!
    
    // MARK: - Class lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        basicSetup()
    }

    // MARK: - Logic
    
    private func basicSetup() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        //contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    func setup(_ phAsset: PHAsset) {
        mainImage.loadThumbnail(phAsset)
    }
}
