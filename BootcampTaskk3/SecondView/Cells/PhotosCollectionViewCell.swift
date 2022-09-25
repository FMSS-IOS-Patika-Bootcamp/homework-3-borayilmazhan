//
//  PhotosCollectionViewCell.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 23.09.2022.
//

import UIKit
import Kingfisher


class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photosImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func setup(url: String){
        self.backgroundColor = .red
        photosImageView.kf.setImage(with: URL(string: url))
    }
}
