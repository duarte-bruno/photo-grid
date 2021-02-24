//
//  ListPhotosViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit

class ListPhotosViewController: UIViewController {

    private var viewModel = ListPhotosViewModel()
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = viewModel.viewTitle
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = viewModel.viewTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
