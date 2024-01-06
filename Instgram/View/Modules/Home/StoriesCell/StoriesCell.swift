//
//  StoriesCell.swift
//  Instgram
//
//  Created by ahlam on 18/12/2023.
//

import UIKit

class StoriesCell: UITableViewCell {

    //MARK: OUTLETES
    @IBOutlet var storiesCollectionView: UICollectionView!
    let storiesList : [Story] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setUpCollection()
    }

    
}

extension StoriesCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func setUpCollection(){
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        
        storiesCollectionView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: "StoryCell")
        


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        9
       //storiesList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
        
        if indexPath.row == 0 {
            cell.addStoryView.isHidden = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addStory))
            cell.addGestureRecognizer(tapGesture)
           // cell.addStoryView.addGestureRecognizer(tapGesture)
        }
        else {
            cell.addStoryView.isHidden = true
        }
        return cell
    }
    
    @objc func addStory(){
      print("add story pressed")
      showImagePickerBottomSheet()
    }
    
    func showImagePickerBottomSheet(){
        guard let topVC = UIApplication.getTopViewController() else { return }
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photosButton = UIAlertAction(title: "Open Photos", style: .default , handler: { action in
            topVC.openCameraGallery(sourceType: .photoLibrary)
        })
        let cameraButton = UIAlertAction(title: "Open Photos", style: .default , handler: { action in
            topVC.openCameraGallery(sourceType: .photoLibrary)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)


        sheet.addAction(photosButton)
        sheet.addAction(cameraButton)
        sheet.addAction(cancelButton)
        
        topVC.present(sheet, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 88, height: 99)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = 4.5
        return UIEdgeInsets(top: 0,
                     left: padding,
                     bottom: 0,
                     right: padding)
    }
    
    
   
}


