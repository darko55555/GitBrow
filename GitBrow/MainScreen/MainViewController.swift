//
//  ViewController.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 17/04/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import Lottie
import RxKeyboard

class MainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = MainViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var loadingView:AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Git browser"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        configureLoader()
        
        let resultsTableviewCell = UINib(nibName: "ResultsTableViewCell", bundle: nil)
        tableView.register(resultsTableviewCell, forCellReuseIdentifier: "ResultsTableViewCell")
        tableView.separatorStyle = .none
        
        loadSearchbar()
        initTableview()
        observeLoader()
        
    }
    
    private func configureLoader(){
        //Loading view
        loadingView = AnimationView(name:"14476-rainbow-cat-remix")
        loadingView.loopMode = .loop
        loadingView.contentMode = .scaleAspectFit
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(loadingView)
        
        loadingView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -150).isActive = true
        loadingView.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        loadingView.play()
    }
    
    private func loadSearchbar(){
        searchBar
            .rx.text
            .orEmpty
            .throttle(.milliseconds(1700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .skip(1)
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)
        
        
       RxKeyboard.instance.visibleHeight
        .drive(onNext: { [tableView] keyboardVisibleHeight in
            tableView?.contentInset.bottom = keyboardVisibleHeight
        })
        .disposed(by: disposeBag)
    }
    
    private func initTableview(){
        viewModel.results.bind(to: tableView.rx.items(cellIdentifier: "ResultsTableViewCell")) { index, model, cell in
           
            let cell = cell as? ResultsTableViewCell
            cell?.repoName.text = model.name
            cell?.authorLabel.text = model.owner.login
            cell?.issuesLabel.text = String(model.openIssuesCount)
            cell?.watchersLabel.text = String(model.watchersCount)
            cell?.forksLabel.text = String(model.forksCount)
          
            let url = URL(string: model.owner.avatarURL)
            cell?.profileImageView?.kf.setImage(with: url)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext:{[weak self] in
            HapticFeedbackGenerator.generateHapticFeedbackLight()
            let repoDetailViewController = RepoDetailViewController(nibName: "RepoDetailViewController", item: $0)
            self?.navigationController?.pushViewController(repoDetailViewController, animated: true)
        })
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
        .subscribe(onNext:{ [weak self] in
            self?.tableView.deselectRow(at: $0, animated: false)
        })
        .disposed(by: disposeBag)
    }
    
    
    private func observeLoader(){
        viewModel.showLoading.distinctUntilChanged().map{!$0}.bind(to: loadingView.rx.isHidden).disposed(by: disposeBag)
    }
    
}


