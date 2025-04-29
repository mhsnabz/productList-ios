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
        // 1. NumberFormatter ile fiyatı string'e çevir
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


        // 3. NSAttributedString niteliklerini tanımla
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

// MARK: - Kullanım Örneği

/*
 // ViewController'ınızın içinde:
 let priceLabel = UILabel()
 let priceValue: Double = 109.95
 let currency = "TL" // Veya "$" , "€"

 // Fontları tanımla (Kendi font isimlerinizi ve boyutlarınızı kullanın)
 guard let mainPriceFont = UIFont(name: "AvenirNext-Bold", size: 24), // Ana kısım için büyük ve kalın
       let secondaryPriceFont = UIFont(name: "AvenirNext-Medium", size: 16) else { // Kuruş/Sembol için küçük ve normal/orta
     fatalError("Fontlar yüklenemedi!")
 }

 // Extension'ı çağır
 priceLabel.setAttributedPrice(
     priceValue,
     currencySymbol: currency,
     mainFont: mainPriceFont,
     secondaryFont: secondaryPriceFont,
     mainColor: .black,        // Ana renk
     secondaryColor: .darkGray, // İkincil renk (daha soluk)
     locale: Locale(identifier: "tr_TR") // Türkçe formatlama (örn: 109,95 TL)
     // locale: Locale(identifier: "en_US") // Amerikan formatlama (örn: 109.95 $)
 )

 // priceLabel'ı view'a ekleyin ve constraintlerini ayarlayın
 view.addSubview(priceLabel)
 // ... Auto Layout kodları ...
*/
