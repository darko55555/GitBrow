////
////  Item.swift
////  UndabotTest2
////
////  Created by Darko Dujmovic on 20/04/2020.
////  Copyright © 2020 Darko Dujmovic. All rights reserved.
////

import Foundation

struct RepoItem:Displayable{

    let id, watchersCount, forksCount, openIssuesCount, forks, openIssues: Int
    var nodeID, name, fullName: String
    let owner: OwnerItem
    let itemDescription, language: String?
    let fork: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemDescription = "description"
        case fork
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case forks
        case openIssues = "open_issues"
    }
}
