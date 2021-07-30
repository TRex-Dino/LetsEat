//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Dmitry on 21.07.2021.
//

import UIKit

class RestaurantListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let location = selectedCity?.city, let filter = selectedType else {
            return
        }
        let manager = RestaurantDataManager()
        
        manager.fetch(by: location, with: filter) { items in
            if manager.numberOfItems() > 0 {
                for item in items {
                    if let itemName = item.name {
                        print(itemName)
                    }
                }
            } else {
                print("No data")
            }
        }
    }
}

//MARK: Private Extension
private extension RestaurantListViewController {
    
}

//MARK: UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }
}
