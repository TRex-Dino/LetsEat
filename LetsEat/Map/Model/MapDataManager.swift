//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Dmitry on 23.07.2021.
//

import Foundation
import MapKit

class MapDataManager: DataManager {
    fileprivate var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        return items
    }
    
    func fetch(complition: (_ annotations: [RestaurantItem]) -> Void) {
        if items.count > 0 { items.removeAll()}
        for data in load(file: "MapLocations") {
            items.append(RestaurantItem(dict: data))
        }
        complition(items)
    }
    
    func currentRegion(letDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else {
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: letDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
