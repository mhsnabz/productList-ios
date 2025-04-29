//
//  HeaderCell.swift
//  ProductList-ios
//
//  Created by srbrt on 29.04.2025.
//

import UIKit
import AdvancedPageControl
class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = [ProductListModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HeaderItemCell.classname, bundle: nil), forCellWithReuseIdentifier: HeaderItemCell.classname)
    }
    
    func setupUI(dataSource: [ProductListModel]) {
        self.dataSource = dataSource
        pageControl.numberOfPages = dataSource.count
        pageControl.currentPage = 0
        pageControl.isHidden = dataSource.count <= 1
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
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            updatePageControl()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControl()
    }
}
