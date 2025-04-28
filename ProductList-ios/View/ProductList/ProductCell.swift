//
//  ProductCell.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var sellerCount: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var discountRate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
