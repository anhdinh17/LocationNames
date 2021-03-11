//
//  ViewController.swift
//  LocationNames
//
//  Created by Anh Dinh on 3/6/21.
//
import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add subview of map
        view.addSubview(map)
        
        title = "Home"
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                // What is this?
                guard let strongSelf = self else {
                    return
                }
                // I think strongSelf is the view itself
                strongSelf.addMapPin(with: location)
                
            }
        }
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds // I think this one is to set the frame of the map variable
    }
    
    // func to create pin on map
    func addMapPin(with location: CLLocation){
        // Create a pin on the location
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)),
                      animated: true)
        // add the pin to map
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
    
}

