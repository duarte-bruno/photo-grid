//
//  ListPhotosViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit
import PhotosUI

class ListPhotosViewController: UIViewController {

    // MARK: - Attributes
    
    @IBOutlet private weak var photosView: PhotosView!
    @IBOutlet private weak var tabBar: CustomTabBar!
    
    private var viewModel = ListPhotosViewModel()
    private var cameraService: CameraService?
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showGrid()
    }
    
    // MARK: - Logic
    
    private func setup() {
        photosView.delegate = self

        tabBar.delegate = self

        viewModel.delegate = self
        viewModel.requestLibraryAccess()

        view.backgroundColor = Constants.color().black

        cameraService = CameraService(self)
    }

    private func showGrid() {
        photosView.showCollectionBottom()
        if self.photosView.alpha == 0 {
            UIView.animate(withDuration: 0.1) {
                self.photosView.alpha = 1.0
            }
        }
    }
}

extension ListPhotosViewController: ListPhotosViewModelDelegate {

    internal func libraryAccessGranted() {
        // TODO: Remove the denied view
    }
    
    internal func libraryAccessDenied() {
        // TODO: create the denied view
    }
}

extension ListPhotosViewController: PhotosViewDelegate {

    internal func showPhotoDetail(phAsset: PHAsset) {
        let viewController = ShowPhotoViewController()
        viewController.phAsset = phAsset
        present(viewController, animated: true)
    }

    internal func showDeleteAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}

extension ListPhotosViewController: CustomTabBarDelegate {

    internal func showCamera() {
        cameraService?.showCamera(self)
    }
}

extension ListPhotosViewController: CameraServiceDelegate {

    internal func didTakePhoto(_ image: UIImage) {
        PhotoService.addPhotoToLibrary(image)
    }
}
