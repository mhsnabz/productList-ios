//  ProductListProvider.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  

import UIKit
import Combine

protocol ProductListProvider : CollectionViewProvider where T == ProductListVMImpl.SectionType, I == IndexPath {
    func activityHandler(input: AnyPublisher<ProductListProviderImpl.ProductListProviderInput, Never>) -> AnyPublisher<ProductListProviderImpl.ProductListProviderOutput, Never>
}

final class ProductListProviderImpl: NSObject, ProductListProvider {
    typealias T = ProductListVMImpl.SectionType
    typealias I = IndexPath
    var dataList: [ProductListVMImpl.SectionType] = []
    
    // Binding
    private let output = PassthroughSubject<ProductListProviderOutput, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private weak var collectionView: UICollectionView?
    
  
    private enum Layout {
        static let estimatedCellHeight: CGFloat = 54
    }
}

// MARK: - EventType
extension ProductListProviderImpl {
    enum ProductListProviderOutput {
        case didSelect(indexPath: IndexPath)
    }
    
    enum ProductListProviderInput {
        case setupUI(collectionView: UICollectionView), prepareCollectionView(data: [ProductListVMImpl.SectionType])
    }
}

// MARK: - Binding
extension ProductListProviderImpl {
    func activityHandler(input: AnyPublisher<ProductListProviderInput, Never>) -> AnyPublisher<ProductListProviderOutput, Never> {
        input.sink { [weak self] eventType in
            switch eventType {
            case .setupUI(let collectionView):
                self?.setupUI(collectionView)
            case .prepareCollectionView(let data):
                self?.prepareCollectionView(data: data)
            default: break
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
}

// MARK: - UI Setup
extension ProductListProviderImpl {
    private func setupUI(_ collectionView: UICollectionView) {
        setupCollectionView(collectionView: collectionView)
    }
}

// MARK: - TableView Setup And Delegation
extension ProductListProviderImpl: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func setupCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib(nibName: ProductCell.classname, bundle: nil), forCellWithReuseIdentifier: ProductCell.classname)
        self.collectionView?.register(UINib(nibName: HeaderCell.classname, bundle: nil), forCellWithReuseIdentifier: HeaderCell.classname)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = dataList[section]
        switch section {
        case .listSection(rows: let rows): return rows.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = dataList[indexPath.section]
        switch section {
        case .listSection(rows: let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .product(model: let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.classname, for: indexPath) as! ProductCell
                cell.setupUI(model: model)
                return cell
            case .headerProduct(model: let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.classname, for: indexPath) as! HeaderCell
                cell.setupUI(dataSource: model)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = dataList[indexPath.section]
        switch section {
        case .listSection(rows: let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .headerProduct:
                return CGSize(width: collectionView.frame.width, height: 224)
            case .product:
                return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.width * 0.71)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    func prepareCollectionView(data: [ProductListVMImpl.SectionType]) {
        self.dataList = data
        reloadCollectionView()
    }
}
