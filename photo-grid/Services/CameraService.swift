//
//  CameraService.swift
//  photo-grid
//
//  Created by Bruno Duarte on 27/02/21.
//

import Foundation
import AVFoundation
import UIKit

protocol CameraServiceDelegate: class {
    func didTakePhoto(_ image: UIImage)
}

class CameraService: NSObject {

    // MARK: - Attributes

    var delegate: CameraServiceDelegate?
    private var imagePicker = UIImagePickerController()

    // MARK: - Class lifecycle

    init(_ delegate: CameraServiceDelegate? = nil) {
        self.delegate = delegate
        super.init()

        setup()
    }

    // MARK: - Logic

    private func setup() {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
    }

    func showCamera(_ sender: UIViewController) {
        // Check camera authorization status
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            presentCamera(sender)
            return

        case .notDetermined:
            requestCameraPemission(sender)
            return

        default:
            alertCameraAccessNeeded(sender)
            return
        }
    }

    private func presentCamera(_ sender: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            sender.present(self.imagePicker, animated: true)
        }
    }

    private func requestCameraPemission(_ sender: UIViewController) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
            if accessGranted {
                self.presentCamera(sender)
            }
        })
    }

    private func alertCameraAccessNeeded(_ sender: UIViewController) {
        guard let settingsAppURL = URL(string: UIApplication.openSettingsURLString) else { return }
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))

        sender.present(alert, animated: true, completion: nil)
    }
}

extension CameraService: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        delegate?.didTakePhoto(image)
    }
}
