//
//  UIImageViewExtension.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit
import PhotosUI

extension UIImageView {
    
    /// Set a tint to the image
    func setImageColor(_ color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

class CustomImageView: UIImageView {

    private var phAsset = PHAsset()
    
    /// Fetch the thumnail from photo library
    func loadThumbnail(_ phAsset: PHAsset) {

        self.phAsset = phAsset
        self.image = UIImage(named: "image-ref")
        
        PhotoService.fetchThumbnail(for: phAsset, imageSize: self.bounds.size) { (thumbnail) in
            guard let thumbnail = thumbnail else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = thumbnail
            }
        }
    }
}
