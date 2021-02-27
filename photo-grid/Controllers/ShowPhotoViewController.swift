//
//  ShowPhotoViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 27/02/21.
//

import UIKit
import PhotosUI

class ShowPhotoViewController: UIViewController {

    // MARK: - Attributes

    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var barProgressView: UIProgressView!
    @IBOutlet private weak var pullBarView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var scrollView: UIScrollView!

    var phAsset: PHAsset? = nil
    private var photoService: PhotoService? = nil
    private let options = PHImageRequestOptions()

    // MARK: - Class lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMainImage()
        setupScrollView()
    }

    // MARK: - Logic

    private func setup() {
        view.backgroundColor = Constants.color().darkGray

        pullBarView.backgroundColor = Constants.color().lightGray
        pullBarView.layer.cornerRadius = 1

        activityIndicator.color = Constants.color().blue

        photoService = PhotoService(self)
        photoService?.setImageSize(containerSize: mainImageView.bounds.size)
    }

    private func setupScrollView() {
        guard mainImageView.image == nil else { return }
        scrollView.delegate = self

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

        scrollView.contentSize = .init(width: scrollView.bounds.width, height: scrollView.bounds.height)
    }

    private func setupMainImage() {
        guard mainImageView.image == nil else { return }
        guard let phAsset = phAsset else { return }

        photoService?.fetchPhoto(phAsset, completion: { [weak self] (image) in
            self?.showImage(image)
        })
    }

    private func showImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.mainImageView.image = image

            UIView.animate(withDuration: 0.2) {
                self?.barProgressView.alpha = 0
                self?.mainImageView.alpha = 1.0
            }
        }
    }
}

extension ShowPhotoViewController: PhotoServiceDelegate {
    internal func progressChanged(progress: Float) {
        DispatchQueue.main.async { [weak self] in
            self?.barProgressView.progress = progress
        }
    }
}

extension ShowPhotoViewController: UIScrollViewDelegate {
    internal func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
}
