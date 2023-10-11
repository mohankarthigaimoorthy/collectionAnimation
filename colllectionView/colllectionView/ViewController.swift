//
//  ViewController.swift
//  colllectionView
//
//  Created by Imcrinox Mac on 22/12/1444 AH.
//

import UIKit

extension Array {
    func safeIndex(_ i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}
class ViewController: UICollectionViewController {

    private struct StoryBoard {
        static let CellIdentifier = "animationCollectionViewCell"
        static let NibName = "animationCollectionViewCell"
    }
    
    private struct Constants {
        static let AnimationDuration: Double = 0.5
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
        
    }
    
    @IBOutlet var collectionViewAnimation: UICollectionView!
    
    var imageCollection: animateImageCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageCollection = animateImageCollection()
        collectionViewAnimation.register(UINib(nibName: StoryBoard.NibName, bundle: nil), forCellWithReuseIdentifier: StoryBoard.CellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.CellIdentifier, for: indexPath) as? animationCollectionViewCell,
              let viewModel = imageCollection.images.safeIndex(indexPath.item) else {
            return UICollectionViewCell()
        }
        cell.prepareCell(viewModel)
        return cell
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? animationCollectionViewCell else {
            return
        }
        self.handleAnimationCellSelected(collectionView, cell: cell)
    }
    
    private func handleAnimationCellSelected(_ collectionView: UICollectionView, cell: animationCollectionViewCell) {
        cell.handleCellSelected()
        cell.backButtonTapped = self.backBtnDidTouch
        
        let animations = {
            cell.frame = self.view.bounds
        }
        
        let completion: (_ finished: Bool) -> () = { _ in
            collectionView.isScrollEnabled = false
        }
        
        UIView.animate(withDuration: Constants.AnimationDelay, delay: Constants.AnimationDelay, usingSpringWithDamping: Constants.AnimationSpringDamping, initialSpringVelocity: Constants.AnimationInitialSpringVelocity,options: [], animations: animations, completion: completion)
    }
    
    func backBtnDidTouch() {
        guard let indexPath = self.collectionView!.indexPathsForSelectedItems else {
            return
        }
        collectionView!.isScrollEnabled = true
        collectionView!.reloadItems(at: indexPath)
    }
}

