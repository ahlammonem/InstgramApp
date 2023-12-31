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
    
    override func viewWillAppear(_ animated: Bool) {
    
      navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
   
    
    
    
    


}

//MARK: TABLE EXTENSION FOR STORIES AND POSTS
extension HomeVC : UITableViewDelegate , UITableViewDataSource  {
   
 
    
    func setUpTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self

        
        homeTableView.register(UINib(nibName: "StoriesCell", bundle: nil), forCellReuseIdentifier: "StoriesCell")
        homeTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
     
        if indexPath.row == 0 {
            
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath) as! StoriesCell
            cell.selectionStyle = .none
           
            return cell
        }
        
        else {
      
         let cell = homeTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(postOwnerStackTapped))
            
            cell.postOwnerStack.addGestureRecognizer(tapGesture)
            cell.selectionStyle = .none
            return cell
        }
        

      
    
    }
    
    @objc func postOwnerStackTapped() {
        
     let vc = ProfileVC()
        
    navigationController?.pushViewController(vc, animated: true)
    }
    

}


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 99
        }
        else {
            return UITableView.automaticDimension
          
        }
    }
    
    
   

