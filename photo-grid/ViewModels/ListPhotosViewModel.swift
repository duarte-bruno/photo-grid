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
}

class ListPhotosViewModel {
    
    // MARK: - Attributes
    
    var delegate: ListPhotosViewModelDelegate? = nil
    var photoService: PhotoService?
    
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
}
