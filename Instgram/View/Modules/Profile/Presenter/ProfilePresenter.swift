//
//  ProfilePresenter.swift
//  Instgram
//
//  Created by ahlam on 24/12/2023.
//

import Foundation

protocol ProfilePresenterProtocol {
    
    func viewDidLoad()
    func didPressedFollow()
}

class ProfilePresenter : NSObject {
    
    private var delegate: ProfileVCProtocol?
    
    init(delegate: ProfileVCProtocol?) {
        self.delegate = delegate
    }
    
}


// MARK: - [View] -> [Presenter]

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad()
    {
    
    }
    
    func didPressedFollow()
    {
        
    }
    

}
