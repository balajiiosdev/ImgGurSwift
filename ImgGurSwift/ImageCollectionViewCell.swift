//
//  ImageCollectionViewCell.swift
//  ImgGurSwift
//
//  Created by Balaji on 28/09/16.
//  Copyright © 2016 Balaji. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var titleBGView: UIView!
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.titleLabel.text = ""
        self.pointsLabel.text = ""
        super.prepareForReuse()
    }
}
