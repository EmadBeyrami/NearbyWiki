//
//  ImageViewCell.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/4/21.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    // MARK: TRAIT COLLECTION (Dark and Light)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageView.layer.borderColor = UIColor.blueBerryBlue.cgColor
    }
    
    // MARK: - View setup
    func setupView() {
        imageView.layer.cornerRadius = 15
        imageView.layer.borderColor = UIColor.blueBerryBlue.cgColor
    }
    
}

// MARK: - Cell delegate
extension ImageViewCell: CustomCollectionViewCell {
    func configCellSize(item: PageImageModel) -> CGSize {
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth / 4.5
        return CGSize(width: cellWidth, height: 1202)
    }
    
    func configureCellWith(_ item: PageImageModel) {
        if let url = URL(string: item.source) {
            imageView.load(url: url)
        }
    }
}
