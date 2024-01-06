//
//  ProfileVC.swift
//  Instgram
//
//  Created by ahlam on 11/12/2023.
//

import UIKit

protocol ProfileVCProtocol {
   
}

class ProfileVC: NibVC {

    
    @IBOutlet var galleryCollectionView: UICollectionView!
    
    private var presenter: ProfilePresenterProtocol?
   
     override init() {
         super.init()
         presenter = ProfilePresenter(delegate: self)
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpGalleryCollection()
    }
    
    
    func setUpView(){
        self.title = "Profile"
    }
    
    
    @IBAction func editProfileButtonDidPressed(_ sender: Any) {
        let vc = EditProfileVC()
        navigationController?.pushViewController(vc, animated: true)
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

// MARK: - [Presenter] -> [View]

extension ProfileVC: ProfileVCProtocol {
    
}

