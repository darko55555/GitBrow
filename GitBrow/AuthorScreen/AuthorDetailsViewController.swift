//
//  AuthorDetailsViewController.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 05/05/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import UIKit

class AuthorDetailsViewController: UIViewController {

    var item:RepoItem!
    
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var visitUsersProfileButton: UIButton!
    @IBOutlet weak var usersBioTextField: UITextView!
    
    public init(nibName:String, item:RepoItem){
        self.item = item
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: item.owner.avatarURL)
        authorAvatarImageView?.kf.setImage(with: url)
        authorAvatarImageView.layer.cornerRadius = authorAvatarImageView.frame.size.width/2
        
        visitUsersProfileButton.addTarget(self, action: #selector(openUserProfileOnWeb), for: .touchUpInside)
        
        authorNameLabel.text = item.owner.name
        
        usersBioTextField.text = item.owner.bio ?? "No bio for this user"
    }
    
    @objc
    func openUserProfileOnWeb(){
        guard let url = URL(string: item.owner.htmlURL) else { return }
        UIApplication.shared.open(url)
    }

}
