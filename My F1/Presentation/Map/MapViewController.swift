//
//  MapViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var circuitNameLabel: UILabel?
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var country: UILabel?
    @IBOutlet var locality: UILabel?
    @IBOutlet var latitude: UILabel?
    @IBOutlet var longitude: UILabel?
    @IBOutlet var mapsButton: UIButton?
    
    private var circuitName: String?
    private var location: Location?
    var mapViewModel: MapViewModel!
    
    convenience init(location: Location, circuitName: String, country: String) {
        self.init(nibName:"MapView", bundle:nil)
        self.mapView = MKMapView()
        self.location = location
        self.mapsButton = UIButton()
        
        self.circuitName = circuitName
        self.mapViewModel = MapViewModel(location: location, circuitName: circuitName, country: country, mapViewController: self)
    }
    
    @IBAction func openMapsPressed(sender: UIButton){
        self.mapViewModel.onPressed()
    }
    
    override func viewDidLoad() {
        self.circuitNameLabel?.text = circuitName
        self.country?.text = self.location?.country
        self.locality?.text = self.location?.locality
        self.latitude?.text = self.location?.lat
        self.longitude?.text = self.location?.long
        self.mapsButton?.layer.borderColor = UIColor.red.cgColor
        self.mapsButton?.layer.borderWidth = 1.5
        self.mapsButton?.layer.cornerRadius = 10.0
        self.mapsButton?.layer.masksToBounds = true
        super.viewDidLoad()
    }
    
    func goToMaps(){
        //http://maps.google.com/maps?z=12&t=m&q=loc:38.9419+-78.3020
        let url = URL(string: "http://maps.google.com/maps?z=15&t=m&q=loc:"+self.location!.lat+"+"+self.location!.long)
        UIApplication.shared.open(url!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lat = Double(self.location!.lat)
        let long = Double(self.location!.long)
        let restaurantLocation = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        //Center the map on the place location
        mapView.setCenter(restaurantLocation, animated: true)
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        annotation.coordinate = centerCoordinate
        annotation.title = self.circuitName!
        mapView.addAnnotation(annotation)
        let initialLocation = CLLocation(latitude: lat!, longitude: long!)
        mapView.centerToLocation(initialLocation)
    }

}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 2000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
}
