//
//  StarRatingView.swift
//  ProductList-ios
//
//  Created by srbrt on 29.04.2025.
//

import Foundation
import UIKit

class StarRatingView: UIView {
    @IBOutlet weak var ratingView: UIStackView!
    private let maxStars = 5
    private var starImageViews: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    private func loadFromNib() {
        guard let subView = Bundle.main.loadNibNamed(StarRatingView.classname, owner: self, options: nil)?.first as? UIView else { return }
        subView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subView)
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStars()
    }

    private func setupStars() {
        ratingView.arrangedSubviews.forEach {
            ratingView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        starImageViews.removeAll()
        for _ in 0..<maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemYellow
            imageView.image = UIImage(systemName: "star")
            ratingView.addArrangedSubview(imageView)
            starImageViews.append(imageView)
        }
    }

    func setRating(_ rating: Double) {
        for (index, imageView) in starImageViews.enumerated() {
            let starPosition = Double(index) + 1
            if rating >= starPosition {
                imageView.image = UIImage(systemName: "star.fill")
            } else if rating >= starPosition - 0.5 {
                imageView.image = UIImage(systemName: "star.lefthalf.fill")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
    }
}
