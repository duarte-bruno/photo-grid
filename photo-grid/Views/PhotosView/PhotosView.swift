//
//  PhotosView.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit

protocol PhotosViewDelegate: class {
    func didSelect(photo: String)
    func loadMoreData()
    func refreshContent()
}

class PhotosView: UIView {
    
    // MARK: - Attributes
    
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let cellIdentifier = "PhotosCollectionViewCell"
    var photos: [String] = []
    weak var delegate: PhotosViewDelegate?
    
    // MARK: - Class lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Actions

    @objc func refreshContent() {
        if let viewController = delegate {
            viewController.refreshContent()
        }
    }
    
    // MARK: - Logic
    
    private func setup() {
        setupView()
        setupCollectionView()
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
        collectionView.dataSource = self

        let itemWidth = (UIScreen.main.bounds.width - 30) / 3
        let heightProportion = CGFloat(1.0)
        let itemHeight = itemWidth * heightProportion

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)

        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5

        collectionView.collectionViewLayout = layout

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Constants.color().lightBlue
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        //collectionView.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotosCollectionViewCell

        //cell.setupCell(with: movies[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = delegate {
            viewController.didSelect(photo: photos[indexPath.row])
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            if let viewController = delegate {
                viewController.loadMoreData()
            }
        }
    }
}
