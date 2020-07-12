//
//  ViewController.swift
//  WorlRotaionAnimation
//
//  Created by Rathod on 7/7/20.
//  Copyright © 2020 Rathod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var vwImgContainer: UIView! {
        didSet {
            vwImgContainer.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tempVwHeight: NSLayoutConstraint!
    @IBOutlet weak var imgFirst: UIImageView! {
        didSet {
            imageHeightAfterAspectFit = imgFirst.imageSizeAfterAspectFit.height
        }
    }
    
    let circularMaskLayer = CAShapeLayer()
    let gradient = CAGradientLayer()
    
    var imageHeightAfterAspectFit: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempVwHeight.constant = imageHeightAfterAspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpMaskAndGradientLayer()
    }
    
    func setUpMaskAndGradientLayer() {
        //MARK:- Setup Shape Layer i.e assign circular Bezier Path to CAShapeLayer
        let circularPath = UIBezierPath(ovalIn: CGRect(x: tempView.bounds.width/2 - (imageHeightAfterAspectFit / 2),
                                                       y: tempView.bounds.height/2  - (imageHeightAfterAspectFit / 2),
                                                       width: imageHeightAfterAspectFit,
                                                       height: imageHeightAfterAspectFit))
        circularMaskLayer.path = circularPath.cgPath
        gradient.frame = circularPath.bounds
        tempView.layer.mask = circularMaskLayer
        
        //MARK:- Setup Gradient Layer i.e assign circular Bezier Path to CAShapeLayer
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.5, y: 1.5)
        /* calculation for Blue color in HSB is as follows
         hue - value for Blue in degrees divide by 360 ex. 218/360 = 0.60
         saturation - in percentage 1 = 100%
         brightness - in percentage 1 = 100%
         alpha - transparency 1 = 100% means non transparent
         */
        gradient.colors = [UIColor.clear.cgColor, UIColor(hue: 0.60 , saturation: 1, brightness: 0.90, alpha: 0.5).cgColor]
        gradient.locations = [0, 0.5]
        tempView.layer.addSublayer(gradient)
        
        animateTheWorld()
    }
    
    func animateTheWorld() {
        UIView.animate(withDuration: 10,
                       delay: 0,
                       options: [.repeat, .curveLinear],
                       animations: {
                        self.vwImgContainer.transform = CGAffineTransform(translationX: 300, y: 0)
        }, completion: nil)
    }
}

extension UIImageView {

    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat

        guard let image = image else { return frame.size }

        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)

            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth

            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        return .init(width: newWidth, height: newHeight)
    }
}
