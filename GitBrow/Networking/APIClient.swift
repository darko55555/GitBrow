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
    
    public func fetchItems(forQuery query:String, completion:@escaping(_ result:Result<GithubResult, APIError>)->()){
        Networking.shared.makeUrlRequest(createDefaultRequest(forQuery: query)!, resultHandler: { (result:Result<GithubResult, APIError>) in
            completion(result)
        })
        
    }
    
    public func fetchItems(forQuery query:String) -> Observable<[Item]> {
        return Observable.create { [unowned self] observer in
            if query.isEmpty {
                observer.onNext([Item]())
                return Disposables.create()
            }
            Networking.shared.makeUrlRequest(self.createDefaultRequest(forQuery: query)!, resultHandler: { (result:Result<GithubResult, APIError>) in
                switch result{
                case .success(let githubResult):
                    observer.onNext(githubResult.items)
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

    
    func createDefaultRequest(forQuery query:String)->URL?{
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = urlComponents.url else { return nil }
        return url
    }

}


public enum APIError: Error {
    case generalAPIError, tooMuchRequestsError
}
