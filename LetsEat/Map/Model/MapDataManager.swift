//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Dmitry on 23.07.2021.
//

import Foundation

class MapDataMager {
    fileprivate var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        return items
    }
    
    func fetch(complition: (_ annotations: [RestaurantItem]) -> Void) {
        if items.count > 0 { items.removeAll()}
        for data in loadData() {
            items.append(RestaurantItem(dict: data))
        }
        complition(items)
    }
    
    fileprivate func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        
        return items as! [[String: AnyObject]]
    }
}
