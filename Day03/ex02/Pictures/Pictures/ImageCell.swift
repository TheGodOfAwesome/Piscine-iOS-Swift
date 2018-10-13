//
//  ImageCell.swift
//  Pictures
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/05.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ImageView: UIImageView!
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            ImageView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        ImageView.layer.borderColor = UIColor.blue.cgColor
        isSelected = false
    }

}
