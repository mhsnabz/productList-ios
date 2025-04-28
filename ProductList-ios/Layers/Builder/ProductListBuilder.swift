//  ProductListBuilder.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  
import UIKit

protocol ProductListBuilder {
    func build() -> BaseController
}

struct ProductListBuilderImpl: ProductListBuilder {
    func build() -> BaseController {
        let vc = ProductListVC(nibName: ProductListVC.classname, bundle: nil)
        let service = ProductListServiceImpl()
        let useCase = ProductListUseCaseImpl(service: service)
        let vm = ProductListVMImpl(useCase: useCase)
        let provider = ProductListProviderImpl()
        vc.inject(vm: vm,provider: provider)
        return vc
    }
}
