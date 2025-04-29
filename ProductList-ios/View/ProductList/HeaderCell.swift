//
//  HeaderCell.swift
//  ProductList-ios
//
//  Created by srbrt on 29.04.2025.
//

import UIKit
import Combine
class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = [ProductListModel]()
    private var userInteraction: PassthroughSubject<ProductListVC.UserInteraction,Never>?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userInteraction = nil
        dataSource.removeAll()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HeaderItemCell.classname, bundle: nil), forCellWithReuseIdentifier: HeaderItemCell.classname)
        pageControl.currentPage = 0
    }
    
    func setupUI(dataSource: [ProductListModel],userInteraction: PassthroughSubject<ProductListVC.UserInteraction,Never>?) {
        self.dataSource = dataSource
        self.userInteraction = userInteraction
        pageControl.numberOfPages = dataSource.count
        pageControl.isHidden = dataSource.count <= 1
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        DispatchQueue.main.async {[weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
    }
    
    private func calculateCurrentPage() -> Int {
        let pageWidth = collectionView.frame.width
        guard pageWidth > 0, !dataSource.isEmpty else { return 0 }
        let currentPage = Int(round(collectionView.contentOffset.x / pageWidth))
        
        return max(0, min(currentPage, dataSource.count - 1))
    }
    
    private func updatePageControl() {
        let currentPage = calculateCurrentPage()
        if pageControl.currentPage != currentPage {
            pageControl.currentPage = currentPage
        }
    }
    
    private func scrollToPage(index: Int, animated: Bool) {
        guard index >= 0 && index < dataSource.count else { return }
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        scrollToPage(index: currentPage, animated: true)
    }
}

extension HeaderCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderItemCell.classname, for: indexPath) as! HeaderItemCell
        cell.setupUI(model: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = dataSource[indexPath.row].id , let userInteraction {
            userInteraction.send(.didSelectProduct(id: id))
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updatePageControl()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControl()
    }
}
