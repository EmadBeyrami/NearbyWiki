//
//  CustomCollectionViewCell.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/4/21.
//

import UIKit

protocol CustomCollectionViewCell: UICollectionViewCell {
    associatedtype CellViewModel
    func configureCellWith(_ item: CellViewModel)
    func configCellSize(item: CellViewModel) -> CGSize
}
