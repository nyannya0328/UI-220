//
//  MapViewModel.swift
//  UI-220
//
//  Created by にゃんにゃん丸 on 2021/06/03.
//

import SwiftUI
import MapKit


class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    
    
    @Published var mapView = MKMapView()
    
    @Published var region : MKCoordinateRegion!
    
    
    @Published var perimissionDeneied = false
    
    
    @Published var mapType : MKMapType = .standard
    
    
    @Published var searchText = ""
    
    
    
    @Published var places : [Place] = []
    
    
    
    func selectPlace(place : Place){
        
        
        searchText = ""
        
        
        guard let coordinate = place.placeMark.location?.coordinate else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placeMark.name ?? "No location"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        
        
        
        
    }
    
    
    func searhQuery(){
        
        places.removeAll()
        
        
        
        let request = MKLocalSearch.Request()
        
        
        request.naturalLanguageQuery = searchText
        
        MKLocalSearch(request: request).start { responce, _ in
            
            guard let result = responce else{return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                
                return Place(placeMark: item.placemark)
                
            })
            
        }
        
        
        
        
        
        
    }
   
    func updateMapView(){
        
        
        if mapView.mapType == .standard{
            
            mapType = .hybrid
            mapView.mapType = mapType
            
        }
        
        else if mapView.mapType == .hybrid{
            
            mapType = .satellite
            mapView.mapType = mapType
            
        }
        
        else{
            
            mapType = .standard
            
            mapView.mapType = mapType
        }
    }
    
    
    func foucusRegion(){
        
        
        guard let _ = region else {return}
        
        
        mapView.setRegion(region, animated: true)
        
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        
        
    }
   
    
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .denied:
            perimissionDeneied.toggle()
            
        case .authorized :
            
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse:
            
            manager.requestLocation()
            
        default:
            ()
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center:location.coordinate , latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        self.mapView.setRegion(self.region, animated: true)
        
        mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
    }
}


