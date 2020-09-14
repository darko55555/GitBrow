//
//  GithubOwnerItemResult.swift
//  GitBrow
//
//  Created by Darko Dujmovic on 14.09.2020..
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation

struct GithubOwnerItemResult:GithubResult{

    typealias ItemType = OwnerItem

    var totalCount:Int
    var incompleteResults:Bool
    var items: [OwnerItem]


    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
