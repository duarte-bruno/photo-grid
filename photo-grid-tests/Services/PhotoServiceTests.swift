//
//  PhotoServiceTests.swift
//  photo-grid-tests
//
//  Created by Bruno Duarte on 01/03/21.
//

import XCTest
import PhotosUI
@testable import photo_grid

class PhotoServiceTests: XCTestCase {

    // MARK: - Attributes

    var authorizationStatus: PHAuthorizationStatus?
    let photoService = PhotoService()

    let defaultTimeout = 10.0

    // MARK: - Setups

    override func setUp() {
        checkPhotoLibraryAuthorization()
    }

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
    }

    // MARK: - Helpers

    private func checkPhotoLibraryAuthorization() {
        let expectation = XCTestExpectation(description: "Check photo library authorization status")
        PHPhotoLibrary.requestAuthorization { (status) in
            self.authorizationStatus = status
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }

    private func checkAuthorized(line: UInt) throws {
        try XCTSkipIf(authorizationStatus != .authorized, "Photo library access status should BE set to .authorized", line: line)
    }

    private func checkDenied(line: UInt) throws {
        try XCTSkipIf(authorizationStatus != .denied, "Photo library access status should NOT BE set to .authorized", line: line)
    }

    private func checkHasPhotos(line: UInt) throws {
        let result = PHAsset.fetchAssets(with: PHFetchOptions())
        try XCTSkipIf(result.count == 0, "Photo library should have at least 1 photo", line: line)
    }

    private func checkHasNoPhotos(line: UInt) throws {
        let result = PHAsset.fetchAssets(with: PHFetchOptions())
        try XCTSkipIf(result.count > 0, "Photo library should be empty", line: line)
    }

    // MARK: - Tests

    func testRequestingLibraryAccessAllowed() throws {
        // Given
        try checkAuthorized(line: #line)

        // When
        let expectation = XCTestExpectation(description: "Check requestLibraryAccess callback")
        photoService.requestLibraryAccess { (authorization) in

            // Then
            XCTAssert(self.photoService.isLibraryAccessAllowed == true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }

    func testRequestingLibraryAccessDenied() throws {
        // Given
        try checkDenied(line: #line)

        // When
        let expectation = XCTestExpectation(description: "Check requestLibraryAccess callback")
        photoService.requestLibraryAccess { (authorization) in

            // Then
            XCTAssert(self.photoService.isLibraryAccessAllowed == false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: defaultTimeout)
    }

    func testFetchingAllPhotosWithSomePhotos() throws {
        // Given
        try checkAuthorized(line: #line)
        try checkHasPhotos(line: #line)

        // When
        photoService.fetchAllPhotos()

        // Then
        XCTAssert(photoService.fetchResult.count > 0)
    }

    func testFetchingAllPhotosWithoutPhotos() throws {
        // Given
        try checkAuthorized(line: #line)
        try checkHasNoPhotos(line: #line)

        // When
        photoService.fetchAllPhotos()

        // Then
        XCTAssert(photoService.fetchResult.count == 0)
    }
}
