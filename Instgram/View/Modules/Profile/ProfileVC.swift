//
//  ProfileVC.swift
//  Instgram
//
//  Created by ahlam on 11/12/2023.
//

import UIKit

class ProfileVC: NibVC {

    @IBOutlet var galleryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.title = "wallpapers4k"
        setUpGalleryCollection()
    }



}


//MARK: COLLECTION EXTENSION FOR GALLERY
extension ProfileVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    
    func setUpGalleryCollection(){
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        galleryCollectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemWidth = (collectionView.frame.width - 2) / 3 
        return CGSize(width: itemWidth, height: itemWidth)
      
    }
    
    
}
