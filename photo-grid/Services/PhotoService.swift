//
//  PhotoService.swift
//  photo-grid
//
//  Created by Bruno Duarte on 26/02/21.
//

import PhotosUI

class PhotoService {
    
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

    /// Fetch all photos from Library
    static func fetchPhotos(completion: (PHFetchResult<PHAsset>) -> Void) {
        
        // Sort the images by descending creation date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        // Fetch the image assets
        completion(PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions))
    }
    
    /// Fetch the thumbnail of a specif image
    static func fetchThumbnail(for phAsset: PHAsset, imageSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false // to fetch only the thumbnail
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.deliveryMode = .highQualityFormat
        
        PHImageManager.default().requestImage(for: phAsset, targetSize: imageSize, contentMode: PHImageContentMode.aspectFill, options: requestOptions) { (image, _) in
            completion(image)
        }
    }
}
