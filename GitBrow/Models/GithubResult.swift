//
//  GithubResult.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 04/05/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation

struct GithubResult:Codable{
    let totalCount:Int
    let incompleteResults:Bool
    let items:[Item]
    
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
