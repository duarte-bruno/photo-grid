//
//  UIImageViewExtension.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit

extension UIImageView {

    func setImageColor(_ color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
