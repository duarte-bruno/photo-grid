//
//  ListPhotosViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit

class ListPhotosViewController: UIViewController {

    // MARK: - Attributes
    
    @IBOutlet private weak var photosView: PhotosView!
    @IBOutlet private weak var tabBar: CustomTabBar!
    
    private var viewModel = ListPhotosViewModel()
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Logic
    
    private func setup() {
        photosView.delegate = self
        
        viewModel.delegate = self
        viewModel.requestLibraryAccess()
        view.backgroundColor = Constants.color().black
    }
}

extension ListPhotosViewController: ListPhotosViewModelDelegate {

    internal func libraryAccessGranted() {
        viewModel.fetchPhotos()
    }
    
    internal func libraryAccessDenied() {
        let alert = UIAlertController(title: "Denied", message: "Denied", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    internal func photosFetched(_ photos: [String]) {
        photosView.photos = photos
        photosView.reloadData()
    }
}

extension ListPhotosViewController: PhotosViewDelegate {

    internal func didSelect(photo: String) {
    }
    
    internal func loadMoreData() {
        //viewModel.fetchPhotos()
    }
    
    internal func refreshContent() {
    }
}
