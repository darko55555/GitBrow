//
//  GithubResult.swift
//  UndabotTest2
//
//  Created by Darko Dujmovic on 04/05/2020.
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation

struct GithubRepoItemResult:GithubResult{

    typealias ItemType = RepoItem

    var totalCount:Int
    var incompleteResults:Bool
    var items:[RepoItem]
    
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
