//
//  animateImageCollection.swift
//  colllectionView
//
//  Created by Imcrinox Mac on 22/12/1444 AH.
//

import Foundation

struct animateImageCollection {
    private let imagePaths = ["1","2","3","4","5"]
    var images : [AnimationCellModel]
    
    init() {
        images = imagePaths.map { AnimationCellModel(imagePath: $0) }
    }
}
