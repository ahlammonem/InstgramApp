//
//  HomeVC.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//

import UIKit

class HomeVC: NibVC {

    //MARK: OULTLETES
    @IBOutlet var homeTableView: UITableView!
    
    //MARK: PROPERTIES
    let postsList : [Post] = []
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
    }


}

//MARK: TABLE EXTENSION FOR STORIES AND POSTS
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func setUpTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(UINib(nibName: "StoriesCell", bundle: nil), forCellReuseIdentifier: "StoriesCell")
        homeTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    
       // homeTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        if indexPath.row == 0 {
     
          cell =  tableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath)
        }
        else {
          cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
          
        }
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 99
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    
   
}
