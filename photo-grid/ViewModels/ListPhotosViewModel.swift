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
    func photosFetched(_ photos: PHFetchResult<PHAsset>)
}

class ListPhotosViewModel {
    
    // MARK: - Attributes
    
    var delegate: ListPhotosViewModelDelegate? = nil
    var photos: PHFetchResult<PHAsset>? = nil
    
    // MARK: - Logic
    
    func requestLibraryAccess() {
        PhotoService.requestLibraryAccess { (authorized) in
            DispatchQueue.main.async { [weak self] in
                if authorized {
                    self?.delegate?.libraryAccessGranted()
                } else {
                    self?.delegate?.libraryAccessDenied()
                }
            }
        }
    }
    
    func fetchPhotos() {
        PhotoService.fetchPhotos { (result) in
            DispatchQueue.main.async { [weak self] in
                self?.photos = result
                self?.delegate?.photosFetched(result)
            }
        }
    }
}
