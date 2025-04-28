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
extension ProductListProviderImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        //self.collectionView?.register(UINib(nibName: <#CellNibName#>.classname, bundle: nil), forCellWithReuseIdentifier: <#CellNibName#>.classname)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = dataList[section]
        switch section {
        case .headerSection(rows: let rows): return rows.count
        case .listSection(rows: let rows): return rows.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = dataList[indexPath.section]
        switch section {
        case .headerSection(rows: let rows):
            return UICollectionViewCell()
        case .listSection(rows: let rows):
            return UICollectionViewCell()
        /*case .defaultSection(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            default: return UICollectionViewCell()
            }*/
        }
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
