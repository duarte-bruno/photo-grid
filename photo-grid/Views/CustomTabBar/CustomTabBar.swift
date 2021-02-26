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
        setSelected(photoImage)
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
        
        view.backgroundColor = Constants.color().black
        backView.layer.cornerRadius = 23
        
        setupButtons()
    }
    
    private func setupButtons() {
        setSelected(photoImage)
    }
    
    private func setSelected(_ image: UIImageView) {
        image.setImageColor(Constants.color().black)
    }
}
