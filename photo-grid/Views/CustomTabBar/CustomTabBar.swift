//
//  CustomTabBar.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit

protocol CustomTabBarDelegate: class {
    func showCamera()
}

class CustomTabBar: UIView {
    
    // MARK: - Attributes
    
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var photoImage: UIImageView!
    
    weak var delegate: CustomTabBarDelegate?
    
    // MARK: - Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Actions
    
    @IBAction private func photoButtonTap(_ sender: UIButton) {
        delegate?.showCamera()
    }
    
    // MARK: - Logic
    
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomTabBar", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds

        view.backgroundColor = Constants.color().black
        backView.layer.cornerRadius = 23

        photoImage.setImageColor(Constants.color().black)
    }
}
