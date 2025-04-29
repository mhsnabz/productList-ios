//
//  Extension+UILabel.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit

extension UILabel {
    func setAttributedPrice(_ price: Double,currencySymbol: String,mainFont: UIFont,secondaryFont: UIFont, mainColor: UIColor = .label,secondaryColor: UIColor = .darkGray,locale: Locale = Locale(identifier: "en_US")) {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = locale

        guard let formattedPriceString = formatter.string(from: NSNumber(value: price)) else {
            self.font = mainFont
            self.textColor = mainColor

            self.text = String(format: "%,2f %@", price, currencySymbol)
            print("Hata: Fiyat formatlanamadı.")
            return
        }

        let decimalSeparator = formatter.decimalSeparator ?? ","
        var mainPart = formattedPriceString
        var secondaryPart = ""

        if let separatorRange = formattedPriceString.range(of: decimalSeparator) {
            mainPart = String(formattedPriceString[..<separatorRange.lowerBound])
            secondaryPart = String(formattedPriceString[separatorRange.lowerBound...]) + " " + currencySymbol
        } else {
            mainPart = formattedPriceString
             secondaryPart = "\(decimalSeparator)00" + " " + currencySymbol
        }


        let mainAttributes: [NSAttributedString.Key: Any] = [
            .font: mainFont,
            .foregroundColor: mainColor
        ]

        let secondaryAttributes: [NSAttributedString.Key: Any] = [
            .font: secondaryFont,
            .foregroundColor: secondaryColor
            // .baselineOffset: 2
        ]

         let finalAttributedString = NSMutableAttributedString(string: mainPart, attributes: mainAttributes)
        let secondaryAttributedString = NSAttributedString(string: secondaryPart, attributes: secondaryAttributes)
        finalAttributedString.append(secondaryAttributedString)

        self.attributedText = finalAttributedString
    }
}
