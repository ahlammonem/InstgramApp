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
        }
        else {
            cell.addStoryView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 88, height: 99)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0,
                     left: 4.5,
                     bottom: 0,
                     right: 4.5)
    }
    
    
   
}
