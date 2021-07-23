//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Dmitry on 21.07.2021.
//

import Foundation

struct ExploreItem {
    var name: String
    var image: String
}

extension ExploreItem {
    init(dict: [String: AnyObject]) {
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
