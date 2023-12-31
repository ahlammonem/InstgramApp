//
//  BottomSheet.swift
//  Instgram
//
//  Created by ahlam on 31/12/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showBottomSheet(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Open Photos", style: .default))
           alert.addAction(UIAlertAction(title: "Open Camera", style: .default))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           present(alert, animated: true, completion: nil)
    }
}

