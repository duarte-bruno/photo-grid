//
//  ListPhotosViewModel.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import PhotosUI

protocol ListPhotosViewModelDelegate: class {
    func libraryAccessGranted()
    func libraryAccessDenied()
    func photosFetched(_ photos: [String])
}

class ListPhotosViewModel {
    
    // MARK: - Attributes
    
    var delegate: ListPhotosViewModelDelegate? = nil
    
    // MARK: - Logic
    
    func requestLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async { [weak self] in
                switch status {
                case .authorized:
                    self?.delegate?.libraryAccessGranted()
                default:
                    self?.delegate?.libraryAccessDenied()
                }
            }
        }
    }
    
    func fetchPhotos(completion: () -> Void) {

        // Sort the images by descending creation date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        // Fetch the image assets
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)

        // If the fetch result isn't empty,
        // proceed with the image request
        if fetchResult.count > 0 {
            let totalImageCountNeeded = 3 // <-- The number of images to fetch
            fetchPhotoAtIndex(0, totalImageCountNeeded, fetchResult)
        }
        
        let photos = ["","","","","","","","","","","","","","","","","","","","","","","","",""]
        delegate?.photosFetched(photos)
    }
    
    // Repeatedly call the following method while incrementing
    // the index until all the photos are fetched
    func fetchPhotoAtIndex(_ index:Int, _ totalImageCountNeeded: Int, _ fetchResult: PHFetchResult<PHAsset>) {

        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        // Perform the image request
        PHImageManager.default().requestImage(for: fetchResult.object(at: index) as PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
            if let image = image {
                // Add the returned image to your array
                self.images += [image]
            }
            // If you haven't already reached the first
            // index of the fetch result and if you haven't
            // already stored all of the images you need,
            // perform the fetch request again with an
            // incremented index
            if index + 1 < fetchResult.count && self.images.count < totalImageCountNeeded {
                self.fetchPhotoAtIndex(index + 1, totalImageCountNeeded, fetchResult)
            } else {
                // Else you have completed creating your array
                print("Completed array: \(self.images)")
            }
        })
    }
}
