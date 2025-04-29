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
    
    private var model: ProductListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = UIImage()
        productName.text = ""
        sellerCount.setTitle("", for: .normal)
        discountRate.text = ""
        followerCount.text = ""
        model = nil
        productPrice.attributedText = nil
    }
    
    func setupUI(model: ProductListModel) {
        self.model = model
        productImage.loadImage(model.image)
        productName.text = model.title ?? ""
        sellerCount.setTitle("\(model.sellerCount) seller(s)", for: .normal)
        discountRate.text = "%\(model.discountRate)"
        followerCount.text = "\(model.followerCount) follower(s)"
        
        if let mainPriceFont = UIFont(name: "AvenirNext-DemiBold", size: 24),
              let secondaryPriceFont = UIFont(name: "AvenirNext-Regular", size: 14) {
            productPrice.setAttributedPrice(model.price ?? 0, currencySymbol: "$", mainFont: mainPriceFont, secondaryFont: secondaryPriceFont)
        }
        
    }
    
}
