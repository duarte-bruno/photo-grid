//
//  ListPhotosViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit

class ListPhotosViewController: UIViewController {

    // MARK: - Attributes
    
    private var viewModel = ListPhotosViewModel()
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Logic
    
    func setup() {
        viewModel.sender = self
        viewModel.requestLibraryAccess()
        view.backgroundColor = Constants.color().black
    }
    
    func showAccessDeniedAlert() {
        let alert = UIAlertController(title: "Denied", message: "Denied", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPhotoList() {
        let alert = UIAlertController(title: "Authorized", message: "Authorized", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
