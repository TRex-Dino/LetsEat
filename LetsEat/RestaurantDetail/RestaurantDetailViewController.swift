//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Dmitry on 23.07.2021.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {

    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)
    }
}
