//
//  InitialViewController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 25/02/21.
//

import UIKit

class InitialViewController: UIViewController {

    // MARK: - Attributes
    
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var madeByLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMainScreen()
        startAnimation()
    }
    
    // MARK: - Logic
    
    private func setup() {
        madeByLabel.textColor = Constants.color().lightGray
        nameLabel.textColor = Constants.color().blue
        view.backgroundColor = Constants.color().black
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.7, animations: {
            self.logoImage.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.7) {
                self.madeByLabel.alpha = 1.0
                self.nameLabel.alpha = 1.0
            }
        })
    }
    
    private func showMainScreen() {
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let listPhotosViewController = ListPhotosViewController()

            let navigation = UINavigationController(rootViewController: listPhotosViewController)
            navigation.modalPresentationStyle = .fullScreen
            navigation.modalTransitionStyle = .crossDissolve
            navigation.isNavigationBarHidden = true

            self.navigationController?.present(navigation, animated: true, completion: nil)
        }
    }
}
