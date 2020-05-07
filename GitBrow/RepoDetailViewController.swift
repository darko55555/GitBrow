//
//  RepoDetailViewController.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 05/05/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import UIKit
import Kingfisher

class RepoDetailViewController: UIViewController {

    var item:Item!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var languageLabel: UILabel!
    
    public init(nibName:String, item:Item){
        self.item = item
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = item.name
        repoTitle.text = item.fullName
        authorButton.setTitle(item.owner.login, for: .normal)
        watchersLabel.text = String(item.watchersCount)
        forksLabel.text = String(item.forksCount)
        issuesLabel.text = String(item.openIssuesCount)
        descriptionTextView.text = item.itemDescription ?? "No description provided"
        languageLabel.text = item.language
        
        authorButton.addTarget(self, action: #selector(openUserProfile), for: .touchUpInside)
        
        let url = URL(string: item.owner.avatarURL)
        profileImageView?.kf.setImage(with: url)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        
        
    }
    
    @objc
    func openUserProfile(){
        let authorDetailsViewController = AuthorDetailsViewController(nibName: "AuthorDetailsViewController", item: item)
        navigationController?.pushViewController(authorDetailsViewController, animated: true)
    }

}
