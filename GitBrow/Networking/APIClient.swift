//
//  APIClient.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 30/04/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation
import RxSwift

class APIClient{
    
    static var shared = APIClient()
    private init() {}
    
    public func fetchItems<T:GithubResult>(forQuery query:String, andType type:SearchType, completion:@escaping(_ result:Result<T, APIError>)->()){
        Networking.shared.makeUrlRequest(createDefaultRequest(forQuery: query, andSearchType: type)!, resultHandler: { (result:Result<T, APIError>) in
            completion(result)
        })

    }
    
    public func fetchItems<T:GithubResult>(forQuery query:String, andType type:SearchType) -> Observable<T> {

        return Observable.create { [unowned self] observer in
//            if query.isEmpty {
//                observer.onNext(T]())
//                return Disposables.create()
//            }
            Networking.shared.makeUrlRequest(self.createDefaultRequest(forQuery: query, andSearchType: type)!, resultHandler: { (result:Result<T, APIError>) in
                switch result{
                case .success(let githubResult):
                    observer.onNext(githubResult)
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
    }

    
    func createDefaultRequest(forQuery query:String, andSearchType searchType:SearchType)->URL?{
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/\(searchType)"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = urlComponents.url else { return nil }
        return url
    }

}


public enum APIError: Error {
    case generalAPIError, tooMuchRequestsError
}

public enum SearchType:String{
    case users, repositories
}

protocol GithubItem:Codable {
    associatedtype DataType
}
