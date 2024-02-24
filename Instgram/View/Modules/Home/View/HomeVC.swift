//
//  HomeVC.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//

import UIKit
import FittedSheets
import FirebaseDatabaseInternal
import FirebaseAuth
import Kingfisher


class HomeVC: NibVC{

    //MARK: OULTLETES
    @IBOutlet var homeTableView: UITableView!
    
    //MARK: PROPERTIES
    var postsList : [Post] = []
    private let imagePicker = UIImagePickerController()
    private var needToAddPost: Bool = true
    private var ref: DatabaseReference?
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
        setupNavigation()
        imagePicker.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadPosts()
    }
    
    func loadPosts(){
        ref = Database.database().reference()
        guard let ref else {return}
        
        let currentUser = Auth.auth().currentUser
        guard let uid = currentUser?.uid else { return }
        
        self.postsList.removeAll()
        ref.child("Posts").observe(.value, with: { (snapshot) -> Void in
          print(snapshot)
            for childSnap in snapshot.children.allObjects as! [DataSnapshot] {
            
                self.postsList.append(Post(data: childSnap))
            }
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        })
    }
    
    private func setupNavigation() {
        let addImage = UIImage(named: "ic_add")
        let favoriteImage = UIImage(named: "ic_like")
        let chatImage = UIImage(named: "ic_chat")
        let navLogoImage = UIImage(named: "app_logo")
        let logoImageView = UIImageView(image: navLogoImage)
        logoImageView.contentMode = .scaleAspectFit
        
        let chatButton = UIBarButtonItem(
            image: chatImage,
            style: .plain,
            target: self,
            action: #selector(addPressedAddButton))
        
      
        let favoriteButton = UIBarButtonItem(
            image: favoriteImage,
            style: .plain,
            target: self,
            action: #selector(addPressedAddButton))
        
        let addButton = UIBarButtonItem(
            image: addImage,
            style: .plain,
            target: self,
            action: #selector(addPressedAddButton))
        
        
        let navLogo = UIBarButtonItem(
            image: navLogoImage,
            style: .plain,
            target: self,
            action: nil)
       
        navigationItem.rightBarButtonItems = [chatButton , favoriteButton , addButton]
        navigationItem.titleView = logoImageView
    }
    
    @objc func addPressedAddButton() {
        showImagePickerBottomSheet(needToAddPost: true)
    }
    
    func pickImage(with source: UIImagePickerController.SourceType){
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
        }
    
    
    
    
    func showImagePickerBottomSheet(needToAddPost:Bool){
        
        self.needToAddPost = needToAddPost
   
           let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
   
           let photosButton = UIAlertAction(title: "Open Photos", style: .default , handler: { action in
               self.pickImage(with: .photoLibrary)
           })
           let cameraButton = UIAlertAction(title: "Open Camera", style: .default , handler: { action in
               self.pickImage(with: .camera)
           })
           let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
   
    
           sheet.addAction(photosButton)
           sheet.addAction(cameraButton)
           sheet.addAction(cancelButton)
   
           present(sheet, animated: true)
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
        
        return postsList.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
     
        if indexPath.row == 0 {
            
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath) as! StoriesCell
            cell.selectionStyle = .none
           
            return cell
        }
        
        else {
      
         let cell = homeTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewCommentsTapped))
            cell.viewCommentsButton.addGestureRecognizer(tapGesture)
            cell.selectionStyle = .none
           
            if indexPath.row-1 != postsList.count {
                 let post = postsList[indexPath.row-1]
                 cell.postContentLabel.text = post.content
                 cell.postOwnerName.text = post.userName
               
                if let imageUrl =  URL(string: post.imageUrl ?? "") {
                    cell.postImageView.kf.setImage(with: imageUrl)
                }
                        
            }
            return cell
        }
        

      
    
    }
    
    @objc func viewCommentsTapped() {
    
      viewCommentsVc()
        
    }
    
    func viewCommentsVc(){
        
        //Using fitted Sheet package
        let vc = CommentsVC()
        let options = SheetOptions( shrinkPresentingViewController: false)

        let sheetController = SheetViewController(controller: vc , sizes: [.percent(0.50) , .percent(0.80) ] ,options: options)

        self.present(sheetController, animated: true, completion: nil)
        
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


extension HomeVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: false)
        if let image = info[.originalImage] as? UIImage,
           let imageUrl = info[.imageURL] as? NSURL {
            self.presentImageViwer(
                image: image,
                imageUrl: imageUrl.absoluteString ?? "")
        }
        
    }
    
    
    private func presentImageViwer(image: UIImage, imageUrl: String) {
        let vc = ImageViewerVC(image: image,imageUrl: imageUrl, type: needToAddPost ? .post : .story) { confirmedImage in
                print("CONFIRM: \(self.needToAddPost)")
            }
         vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.getTopViewController()?.present(vc, animated: true)
            //UIApplication.getTopViewController()
        }
    }
}
    
    
   

