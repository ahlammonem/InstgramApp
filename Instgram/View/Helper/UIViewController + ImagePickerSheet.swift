////
////  BottomSheet.swift
////  Instgram
////
////  Created by ahlam on 31/12/2023.
////
//
//import Foundation
//import UIKit
//
//extension UIViewController {
//    
//    func showImagePickerBottomSheet(){
//        guard let topVC = UIApplication.getTopViewController() else { return }
//        
//        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        
//        let photosButton = UIAlertAction(title: "Open Photos", style: .default , handler: { action in
//            topVC.openCameraGallery(sourceType: .photoLibrary)
//        })
//        let cameraButton = UIAlertAction(title: "Open Camera", style: .default , handler: { action in
//            topVC.openCameraGallery(sourceType: .camera)
//        })
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
//
//
//        sheet.addAction(photosButton)
//        sheet.addAction(cameraButton)
//        sheet.addAction(cancelButton)
//        
//        topVC.present(sheet, animated: true)
//    }
//}
//
