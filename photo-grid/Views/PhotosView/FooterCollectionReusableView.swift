//
//  FooterCollectionReusableView.swift
//  photo-grid
//
//  Created by Bruno Duarte on 28/02/21.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {

    // MARK: - Attributes

    @IBOutlet weak var label: UILabel!

    // MARK: - Logic

    func setup(photosCount: Int) {
        label.textColor = Constants.color().darkGray

        if photosCount == 0 {
            label.text = "No photos found"
        } else {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal

            guard let formattedNumber = numberFormatter.string(from: NSNumber(value: photosCount)) else { return }

            label.text = "\(formattedNumber) Photos"
        }
    }
}
