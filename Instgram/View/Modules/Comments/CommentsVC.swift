//
//  CommentsVC.swift
//  Instgram
//
//  Created by ahlam on 01/01/2024.
//

import UIKit

class CommentsVC: UIViewController {

    
    @IBOutlet var commentsTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCommentsTableView()

    }


}

extension CommentsVC : UITableViewDelegate , UITableViewDataSource {
  
    
    
    func setUpCommentsTableView(){
        commentsTV.delegate = self
        commentsTV.dataSource = self
        
        commentsTV.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        return cell
    }
}
