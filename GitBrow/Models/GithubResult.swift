//
//  GithubResult.swift
//  GitBrow
//
//  Created by Darko Dujmovic on 14.09.2020..
//  Copyright © 2020 Darko Dujmovic. All rights reserved.
//

import Foundation

protocol GithubResult: Codable {
    associatedtype ItemType:Displayable
    var items:[ItemType] { get set }
}

protocol Displayable:Codable{
    var name:String { get set }
}
