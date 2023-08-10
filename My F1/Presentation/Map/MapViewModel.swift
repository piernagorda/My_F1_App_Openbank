//
//  MapViewModel.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import Foundation
import MapKit

class MapViewModel{
    
    
    private var mapViewController: MapViewController?
    private var locations: [CLLocationCoordinate2D] = []
    
    init(location: Location, circuitName: String, country: String, mapViewController: MapViewController){
        self.mapViewController = mapViewController
    }
    
    func onPressed(){
        self.mapViewController!.goToMaps()
    }
    
}

