//
//  CustomTabBar.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit

protocol CustomTabBarDelegate: class {
    func homeSelected()
    func photoSelected()
}

class CustomTabBar: UIView {
    
    // MARK: - Attributes
    
    @IBOutlet var view: UIView!
    @IBOutlet private weak var homeImage: UIImageView!
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
    
    @IBAction func homeButtonTap(_ sender: UIButton) {
        setSelected(homeImage)
        setUnselected(photoImage)
        delegate?.homeSelected()
    }
    
    @IBAction func photoButtonTap(_ sender: UIButton) {
        setSelected(photoImage)
        setUnselected(homeImage)
        delegate?.photoSelected()
    }
    
    // MARK: - Logic
    
    private func setup() {
        setupView()
    }
    
    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomTabBar", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        
        view.backgroundColor = Constants.color().darkGray
        view.layer.cornerRadius = 25 // half of view's height
        setupButtons()
    }
    
    private func setupButtons() {
        setSelected(homeImage)
        setUnselected(photoImage)
    }
    
    private func setSelected(_ image: UIImageView) {
        image.setImageColor(Constants.color().blue)
    }
    
    private func setUnselected(_ image: UIImageView) {
        image.setImageColor(Constants.color().lightGray)
    }
}
