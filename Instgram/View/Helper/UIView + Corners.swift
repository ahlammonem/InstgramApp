//
//  UIView + Corners.swift
//  Instgram
//
//  Created by ahlam on 18/12/2023.
//

import Foundation
import UIKit

extension UIView {
    

    
    @IBInspectable
     var cornerRadius: CGFloat {
        get {
           return layer.cornerRadius
        }
        set {
           layer.cornerRadius = newValue
        }
     }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }


  @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    
}
