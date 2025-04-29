//  ProductDetailVC.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  

import UIKit
import Combine
final class ProductDetailVC: BaseController, ControllerCombineBehaviorallyWithoutComponent {
    typealias V = ProductDetailVM
    private var vm: V?
    
    // Combine operations Binding
    private let inputVM = PassthroughSubject<ProductDetailVMImpl.ProductDetailVMInput, Never>()
    // UI Ref
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    
    deinit { Logger.destroy() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        inputVM.send(.start)
    }
    
    func inject(vm: V) {
        self.vm = vm
    }
}

// MARK: - Binding
extension ProductDetailVC {
    func binding() {
        // Pr Event Binding
        let output = vm?.activityHandler(input: inputVM.eraseToAnyPublisher())
        output?.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] event in // If not needed, DispatchQueue.main can be removed.
            switch event {
            case .isLoading(isShow: let isShow):
                self?.loading(isShow: isShow)
            case .error(error: let error):
                Logger.d(message: "error :\(error.localizedDescription)")
            case .prepareUI(model: let model):
                self?.setupUI(model: model)
            }
        }).store(in: &cancellabes)
    }
}


extension ProductDetailVC {
    private func setupUI(model: ProductListModel?) {
        if let rate = model?.rating?.rate , let rateCount = model?.rating?.count {
            self.setupRating(rate: rate, rateCount: rateCount)
        }
        
        if let price = model?.price , let mainPriceFont = UIFont(name: "AvenirNext-DemiBold", size: 24),
            let secondaryPriceFont = UIFont(name: "AvenirNext-Regular", size: 14) {
            self.priceLbl.setAttributedPrice(price, currencySymbol: "TL", mainFont: mainPriceFont, secondaryFont: secondaryPriceFont)
        }
        
        if let category = model?.category {
            self.category.text = category
        }
        
        if let title = model?.title {
            self.titleLbl.text = title
        }
        
        if let description = model?.description {
            self.descriptionLbl.text = description
        }
        
        self.productImage.loadImage(model?.image)
    }
    
    private func setupRating(rate: Double,rateCount: Int) {
        ratingView.setRating(rate)
        let roundedValue = Double(String(format: "%.2f", rate)) ?? 0.0
        self.rateLbl.text = "(\(rateCount)/\(roundedValue))"
    }
}
