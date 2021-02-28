//
//  PhotoService.swift
//  photo-grid
//
//  Created by Bruno Duarte on 26/02/21.
//

import PhotosUI

protocol PhotoServiceDelegate: class {
    func progressChanged(progress: Float)
}

class PhotoService: NSObject {

    // MARK: - Attributes

    var fetchResult: PHFetchResult<PHAsset>!
    private var assetCollection: PHAssetCollection!
    let imageManager = PHCachingImageManager()
    private var imageSize: CGSize!
    private var delegate: PhotoServiceDelegate?
    private let options = PHImageRequestOptions()

    // MARK: - Class lifecycle

    init(_ delegate: PhotoServiceDelegate? = nil) {
        self.delegate = delegate
        super.init()

        if delegate != nil {
            setup()
        }
    }

    // MARK: - Logic

    private func setup() {
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { [weak self] progress, _, _, _ in
            self?.delegate?.progressChanged(progress: Float(progress))
        }
    }

    /// Request the access to Photo Library
    static func requestLibraryAccess(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                completion(true)
            default:
                completion(false)
            }
        }
    }

    func fetchAllPhotos() {
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
    }

    func fetchPhoto(_ phAsset: PHAsset, completion: @escaping (UIImage) -> Void) {
        PHImageManager.default().requestImage(
            for: phAsset,
            targetSize: imageSize,
            contentMode: .aspectFit,
            options: options,
            resultHandler: { image, _ in
                guard let image = image else { return }
                completion(image)
        })
    }

    func setImageSize(containerSize: CGSize) {
        let scale = UIScreen.main.scale
        imageSize = CGSize(width: containerSize.width * scale, height: containerSize.height * scale)
    }

    func requestThumbnail(_ asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { (image, _) in
            completion(image)
        }
    }

    static func addPhotoToLibrary(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized, let imageData = image.jpegData(compressionQuality: 1.0) else { return }

            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: imageData, options: PHAssetResourceCreationOptions())
            }, completionHandler: nil)
        }
    }

    // MARK: - Cache Logic

    func computeCache(_ addedRects: [CGRect], _ removedRects: [CGRect], _ collectionView: UICollectionView) {
        let addedAssets = addedRects
            .flatMap { rect in collectionView.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        let removedAssets = removedRects
            .flatMap { rect in collectionView.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }

        // Update the assets the PHCachingImageManager is caching.
        imageManager.startCachingImages(for: addedAssets,
                                        targetSize: imageSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: imageSize, contentMode: .aspectFill, options: nil)
    }
}
