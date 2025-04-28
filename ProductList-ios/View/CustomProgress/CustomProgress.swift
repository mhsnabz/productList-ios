//
//  CustomProgress.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit
import Lottie
public class CustomProgress: UIView {
    @IBOutlet weak var progress: LottieAnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    
    private func commonInit() {
        if let subView = Bundle.main.loadNibNamed(CustomProgress.classname, owner: self,options: nil)?.first as? UIView {
            subView.frame = bounds
            addSubview(subView)
            progress.loopMode = .loop
        }
    }
        
    func loading(isShow: Bool){
        if isShow{
            progress.play()
        }else{
            progress.stop()
        }
    }
}
