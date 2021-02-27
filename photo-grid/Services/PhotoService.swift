//
//  PhotoService.swift
//  photo-grid
//
//  Created by Bruno Duarte on 26/02/21.
//

import PhotosUI

class PhotoService: NSObject {

    // MARK: - Attributes

    var fetchResult: PHFetchResult<PHAsset>!
    private var assetCollection: PHAssetCollection!
    let imageManager = PHCachingImageManager()
    private var thumbnailSize: CGSize!

    // MARK: - Logic

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

    func setThumbnailSize(cellSize: CGSize) {
        let scale = UIScreen.main.scale
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
    }

    func requestThumbnail(_ asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil) { (image, _) in
            completion(image)
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
                                        targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
    }
}
