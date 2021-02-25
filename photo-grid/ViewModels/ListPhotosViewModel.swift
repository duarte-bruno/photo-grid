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
}
