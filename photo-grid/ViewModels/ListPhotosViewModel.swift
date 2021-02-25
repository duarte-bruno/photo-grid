//
//  ListPhotosViewModel.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import PhotosUI

class ListPhotosViewModel {
    
    // MARK: - Attributes
    
    var sender: ListPhotosViewController? = nil
    
    // MARK: - Logic
    
    func requestLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async { [weak self] in
                switch status {
                case .authorized:
                    self?.sender?.showPhotoList()
                default:
                    self?.sender?.showAccessDeniedAlert()
                }
            }
        }
    }
}
