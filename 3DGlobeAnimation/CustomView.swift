//
//  CustomView.swift
//  WorlRotaionAnimation
//
//  Created by Rathod on 7/7/20.
//  Copyright © 2020 Rathod. All rights reserved.
//

import UIKit

class MaskView: UIView {
    
    private let rootLayer = CALayer()
    
    // MARK: - Initializers
    override public init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    private func commonInit() {
        rootLayer.masksToBounds = true
        self.layer.addSublayer(rootLayer)
        
        setupRootLayer()
    }
    
    // MARK: - Setup Layers
    private func setupRootLayer() {
        rootLayer.cornerRadius = 30
        rootLayer.backgroundColor = UIColor.green.cgColor
    }
}
