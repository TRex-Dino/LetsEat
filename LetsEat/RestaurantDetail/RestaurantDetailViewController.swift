//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Dmitry on 23.07.2021.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    // NAV Bar
    @IBOutlet weak var bthHeart: UIBarButtonItem!
    // Cell One
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeadAddress: UILabel!
    // Cell Two
    @IBOutlet weak var lblTableDetails: UILabel!
    // Cell three
    @IBOutlet weak var lblOverallRating: UILabel!
    // Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    // Cell Nine
    @IBOutlet weak var imgMap: UIImageView!

    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension RestaurantDetailViewController {
    
    func initialize() {
        setupLabels()
        createMap()
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else { return }
        
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        
        if let cuisine = restaurant.subtitle {
            lblCuisine.text = cuisine
        }
        
        if let address = restaurant.address {
            lblAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant,
              let long = annotation.long,
              let lat = annotation.lat else {
            return
        }
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapShot(with: location)
    }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapShotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        
        mapSnapShotOptions.region = region
        mapSnapShotOptions.scale = UIScreen.main.scale
        mapSnapShotOptions.size = CGSize(width: 340,
                                         height: 208)
        mapSnapShotOptions.showsBuildings = true
        mapSnapShotOptions.pointOfInterestFilter = .includingAll
        
        let snapShooter = MKMapSnapshotter(options: mapSnapShotOptions)
        snapShooter.start { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            UIGraphicsBeginImageContextWithOptions(
                mapSnapShotOptions.size,
                true,
                0)
            
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation,
                                              reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")
            
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.imgMap.bounds
            
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
}
