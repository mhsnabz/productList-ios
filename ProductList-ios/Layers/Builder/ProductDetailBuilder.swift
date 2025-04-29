//  ProductDetailBuilder.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  
import UIKit

protocol ProductDetailBuilder {
    func build(id: Int) -> BaseController
}

struct ProductDetailBuilderImpl: ProductDetailBuilder {
    func build(id: Int) -> BaseController {
        let vc = ProductDetailVC(productId: id)
        let service = ProductDetailServiceImpl()
        let useCase = ProductDetailUseCaseImpl(service: service)
        let vm = ProductDetailVMImpl(useCase: useCase)
        vc.inject(vm: vm)
        return vc
    }
}
