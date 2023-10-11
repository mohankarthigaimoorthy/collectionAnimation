//
//  animationCollectionViewCell.swift
//  colllectionView
//
//  Created by Imcrinox Mac on 22/12/1444 AH.
//

import UIKit

class animationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
 
    var backButtonTapped: (() -> Void)?
    
    func prepareCell(_ viewmode: AnimationCellModel) {
        contentImage.image = UIImage(named: viewmode.imagePath)
        contentTextView.isScrollEnabled = false
        backBtn.isHidden = true
        addTapEventHandler()
    }
    
    func handleCellSelected() {
        contentTextView.isScrollEnabled = false
        backBtn.isHidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    private func addTapEventHandler() {
        backBtn.addTarget(self, action: #selector(backBtnDidTouch(_:)), for: .touchUpInside)
    }
    
    @objc func backBtnDidTouch(_ sender: UIGestureRecognizer) {
        backButtonTapped?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
