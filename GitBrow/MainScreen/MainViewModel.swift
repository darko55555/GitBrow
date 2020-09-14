//
//  MainViewModel.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 30/04/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel{
    
   let disposeBag = DisposeBag()
    
    var results = PublishSubject<Displayable>()
    var searchQuery = PublishSubject<String>()
    var searchTypeSwitch = BehaviorSubject<SearchType>(value: .users)
    var showsErrorMessage = BehaviorSubject<(Bool,String)>(value: (false,""))
    var showLoading = BehaviorSubject<Bool>(value:false)
    
    init(){
        subscribeToSearchQuery()

//        let result:GithubOwnerItemResult = APIClient.shared.fetchItems(forQuery: "darko55555")
    }
    
    private func subscribeToSearchQuery(){
        searchQuery.asObservable()
            .do(onNext: { [weak self] _ in
                //Prevent showing loader if there are items
                do{
                 //   let dataSourceEmpty = try? self?.results.value().isEmpty
//                    guard dataSourceEmpty != nil else { throw LoaderError.generalLoaderError }
//                    dataSourceEmpty! ? self?.showLoading.onNext(true) : nil
                }catch{
                    self?.showLoading.onNext(true)
                }
            })
            .flatMapLatest{APIClient.shared.fetchItems(forQuery: $0, andType: .repositories)}
            .flatMapLatest{
//                $0 is GithubRepoItemResult
                Observable.of($0 as GithubRepoItemResult)
            }
            .map{ $0.items }
            .subscribe(onNext:{ res in
                let result = res
                print("")
            })
//            .catchErrorJustReturn([Item]())
//            .do(onNext: { [weak self] _ in self?.showLoading.onNext(false)})
//            .bind(to: results)
         //   .disposed(by:disposeBag)
    }
    
}

public enum LoaderError: Error {
    case generalLoaderError
}


extension ObservableType {
    func filterByCast<T>() -> Observable<T> {
        return self.filter { $0 is T }.map { $0 as! T }
    }
}
