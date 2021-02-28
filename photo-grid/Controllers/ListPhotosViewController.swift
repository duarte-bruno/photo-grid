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

    @IBOutlet weak var accessAlertView: UIView!
    @IBOutlet weak var accessAlertButton: UIButton!

    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.requestLibraryAccess()
    }

    // MARK: - Action

    @IBAction func accessAlertButtonAction(_ sender: UIButton) {
        guard let settingsAppURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
    }

    // MARK: - Logic
    
    private func setup() {
        setupView()
        setupAccessAlertView()
    }

    private func setupView() {
        photosView.delegate = self
        tabBar.delegate = self
        viewModel.delegate = self
        view.backgroundColor = Constants.color().black
        cameraService = CameraService(self)
    }

    private func setupAccessAlertView() {
        accessAlertButton.setTitleColor(Constants.color().blue, for: .normal)
        accessAlertButton.layer.borderWidth = 1
        accessAlertButton.layer.borderColor = Constants.color().blue.cgColor
        accessAlertButton.layer.cornerRadius = 5
    }

    private func showGrid() {
        photosView.showCollectionBottom()
        if self.photosView.alpha == 0 {
            UIView.animate(withDuration: 0.1) {
                self.photosView.alpha = 1.0
            }
        }
    }

    private func showAccessAlertView() {
        guard accessAlertView.alpha != 1.0 else { return }

        accessAlertView.isHidden = false
        UIView.animate(withDuration: 0.1) {
            self.accessAlertView.alpha = 1.0
        }
    }

    private func hideAccessAlertView() {
        guard accessAlertView.alpha != 0 else { return }

        UIView.animate(withDuration: 0.7, animations: {
            self.accessAlertView.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.7) {
                self.accessAlertView.isHidden = true
            }
        })
    }
}

extension ListPhotosViewController: ListPhotosViewModelDelegate {

    internal func libraryAccessGranted() {
        hideAccessAlertView()
        photosView.start()
        showGrid()
    }
    
    internal func libraryAccessDenied() {
        showAccessAlertView()
    }
}

extension ListPhotosViewController: PhotosViewDelegate {

    internal func showPhotoDetail(phAsset: PHAsset) {
        let viewController = ShowPhotoViewController()
        viewController.phAsset = phAsset
        present(viewController, animated: true)
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
