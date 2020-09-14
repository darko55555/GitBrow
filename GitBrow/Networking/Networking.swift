//
//  Networking.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 30/04/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation

class Networking{
   
    private init() {}
    static var shared = Networking()
    private let userAgent = UUID().uuidString
    
    func makeUrlRequest<T: GithubResult>(_ queryURL: URL, resultHandler: @escaping (Result<T, APIError>) -> Void) {
        var request = URLRequest(url: queryURL)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                resultHandler(.failure(.generalAPIError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                 resultHandler(.failure(.generalAPIError))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.generalAPIError))
                return
            }
           
            let result = try! JSONDecoder().decode(T.self, from: data)
            
            resultHandler(.success(result))
        }
        
        urlTask.resume()
    }
    
}
