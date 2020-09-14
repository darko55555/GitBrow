////
////  Owner.swift
////  UndabotTest2
////
////  Created by Darko Dujmovic on 20/04/2020.
////  Copyright © 2020 Darko Dujmovic. All rights reserved.
////

import Foundation

struct OwnerItem:Displayable {
    var name: String


    let nodeID, avatarURL, gravatarID, url, htmlURL, followersURL, followingURL, gistsURL, starredURL,subscriptionsURL, organizationsURL, reposURL, eventsURL, receivedEventsURL, type: String
    let bio: String?
    let id: Int
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case bio
    }
}
