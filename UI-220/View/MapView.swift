//
//  MapView.swift
//  UI-220
//
//  Created by にゃんにゃん丸 on 2021/06/03.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var model : MapViewModel
    
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = model.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator:NSObject,MKMapViewDelegate{
        
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation.isKind(of: MKUserLocation.self){return nil}
            
            
            else{
                
                
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                
                pinAnnotation.pinTintColor = .green
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                
                
                
                return pinAnnotation
                
                
            }
            
        }
        
        
        
    }
}

