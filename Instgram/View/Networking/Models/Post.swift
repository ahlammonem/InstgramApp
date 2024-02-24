//
//  Post.swift
//  Instgram
//
//  Created by ahlam on 18/12/2023.
//

import Foundation
import FirebaseDatabaseInternal

struct Post {
    let userName:String?
    let imageUrl : String?
    let content : String?
    
    
    init(data:DataSnapshot ){
    
        imageUrl = data.childSnapshot(forPath: "imageUrl").value as? String
        userName = data.childSnapshot(forPath: "username").value as? String
        content = data.childSnapshot(forPath: "content").value as? String
    }
}
