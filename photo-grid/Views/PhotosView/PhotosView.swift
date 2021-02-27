//
//  PhotosView.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit
import PhotosUI

protocol PhotosViewDelegate: class {
    func showPhotoDetail(phAsset: PHAsset)
}

class PhotosView: UIView {
    
    // MARK: - Attributes

    @IBOutlet private weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

    weak var delegate: PhotosViewDelegate?

    private let photoService = PhotoService()
    private let cellIdentifier = "PhotosCollectionViewCell"
    private var previousPreheatRect = CGRect.zero
    private var didShowCollectionBottom = false

    // MARK: - Class lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    // MARK: - Logic
    
    private func setup() {
        setupView()

        resetCachedAssets()
        photoService.fetchAllPhotos()
        PHPhotoLibrary.shared().register(self)

        setupCollectionView()
        photoService.setImageSize(containerSize: collectionViewFlowLayout.itemSize)

        updateCachedAssets()
    }

    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("PhotosView", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)

        let itemSize = (view.bounds.inset(by: view.safeAreaInsets).width - 30) / 3
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        collectionViewFlowLayout.minimumInteritemSpacing = 5
        collectionViewFlowLayout.minimumLineSpacing = 5
    }
    
    /// Starts the collection from bottom up
    func showCollectionBottom() {
        guard !didShowCollectionBottom else { return }
        didShowCollectionBottom = true

        let contentSize = collectionView.collectionViewLayout.collectionViewContentSize
        if (contentSize.height > collectionView.bounds.size.height) {
            let targetContentOffset = CGPoint(x: 0.0, y: contentSize.height - collectionView.bounds.size.height)
            collectionView.setContentOffset(targetContentOffset, animated: false)
        }
    }

    // MARK: - Cache Logic

    fileprivate func resetCachedAssets() {
        photoService.imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }

    private func updateCachedAssets() {
        guard view.superview != nil && view.window != nil else { return }

        // The window you prepare ahead of time is twice the height of the visible rect.
        let visibleRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)

        // Update only if the visible area is significantly different from the last preheated area.
        let delta = abs(preheatRect.midY - previousPreheatRect.midY)
        guard delta > view.bounds.height / 3 else { return }

        // Compute the assets to start and stop caching.
        let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
        photoService.computeCache(addedRects, removedRects, collectionView)

        // Store the computed rectangle for future comparison.
        previousPreheatRect = preheatRect
    }

    private func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added: [CGRect], removed: [CGRect]) {
        if old.intersects(new) {
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY,
                                 width: new.width, height: new.maxY - old.maxY)]
            }
            if old.minY > new.minY {
                added += [CGRect(x: new.origin.x, y: new.minY,
                                 width: new.width, height: old.minY - new.minY)]
            }
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY,
                                   width: new.width, height: old.maxY - new.maxY)]
            }
            if old.minY < new.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY,
                                   width: new.width, height: new.minY - old.minY)]
            }
            return (added, removed)
        } else {
            return ([new], [old])
        }
    }
}

extension UICollectionView {
    func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoService.fetchResult.count
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotosCollectionViewCell

        let asset = photoService.fetchResult.object(at: indexPath.row)
        cell.assetIdentifier = asset.localIdentifier

        photoService.requestThumbnail(asset) { (image) in
            guard let image = image else { return }
            if cell.assetIdentifier == asset.localIdentifier {
                cell.mainImage.image = image
            }
        }
        return cell
    }

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showPhotoDetail(phAsset: photoService.fetchResult.object(at: indexPath.row))
    }
}

extension PhotosView: UIScrollViewDelegate {

    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCachedAssets()
    }
}

extension PhotosView: PHPhotoLibraryChangeObserver {

    internal func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: photoService.fetchResult) else { return }

        DispatchQueue.main.sync {
            photoService.fetchResult = changes.fetchResultAfterChanges

            // If we have incremental changes, animate them in the collection view.
            if changes.hasIncrementalChanges {
                guard let collectionView = self.collectionView else { fatalError() }
                // Handle removals, insertions, and moves in a batch update.
                collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes, !removed.isEmpty {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, !inserted.isEmpty {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })

                if let changed = changes.changedIndexes, !changed.isEmpty {
                    collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                }
            } else {
                // Reload the collection view if incremental changes are not available.
                collectionView.reloadData()
            }
            resetCachedAssets()
        }
    }
}
