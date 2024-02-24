//
//  ImageViewerVC.swift
//  Instgram
//
//  Created by ahlam on 05/02/2024.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

enum ImageViewerType {
    case story
    case post
    case profile
}

class ImageViewerVC: NibVC {
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    private var image : UIImage
    private var imageUrl : String
    private var type : ImageViewerType
    private let dbRef = Database.database().reference()
    private let didConfirm: (UIImage) -> ()
    private let authRepo = AuthRepo()
    
    
    init(image: UIImage , imageUrl :String ,type: ImageViewerType,
         didConfirm: @escaping (UIImage) -> ()) {
        self.image = image
        self.imageUrl = imageUrl
        self.type = type
        self.didConfirm = didConfirm
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
        switch type {
        case .story:
            confirmButton.setTitle("Add story", for: .normal)
            postTextView.isHidden = true
        case .post:
            confirmButton.setTitle("Add post", for: .normal)
            postTextView.isHidden = false
        case .profile:
            confirmButton.setTitle("Change profile photo", for: .normal)
            postTextView.isHidden = true
        }
    }
    
    private func addStory() {
        uploadImage(folder: "Stories", imageUrl: imageUrl)
    }
    
    private func addPost() {
        uploadImage(folder: "Posts", imageUrl: imageUrl)
    }
    
    private func changeProfilePhoto() {
        uploadImage(folder: "Profiles", imageUrl: imageUrl)
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func uploadImage(folder: String, imageUrl: String ){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageName: String = String(imageUrl.split(separator: "/").last ?? "")
        let localFile = URL(string: imageUrl)!
        let ref = storageRef.child("\(folder)/\(imageName)")
        
        let uploadTask = ref.putFile(
            from: localFile,
            metadata: nil) { metadata, error in
                ref.downloadURL { (url, error) in
                    if let downloadURL = url {
                        self.setPostToDB(downloadURL)
                    }
                }
            }
        
    }
    
    func setPostToDB(_ url: URL) {
        authRepo.getUser { userDic in
            
            guard let id = userDic?["id"] as? String,
                  let username = userDic?["username"] as? String else {
                return
            } 
            
            self.dbRef.child("Posts")
                .child(UUID().uuidString).setValue(
                    ["userId": id,
                     "username": username,
                     "imageUrl": url.absoluteString ,
                     "content": self.postTextView.text ?? ""])
    
            self.didConfirm(self.image)
            self.loader.stopAnimating()
            self.dismiss(animated: true)
            
        }
    }
        
    @IBAction func actionConfirm(_ sender: Any) {
           loader.startAnimating()
            switch type {
            case .story: addStory()
            case .post: addPost()
            case .profile: changeProfilePhoto()
            }
        }
    }

