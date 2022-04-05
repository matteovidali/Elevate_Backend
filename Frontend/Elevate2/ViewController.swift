//
//  ViewController.swift
//  Elevate2
//
//  Created by Elevate App on 9/30/20.
//

import UIKit
import MapKit
import CoreLocation

class ViewController:  UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters = 1000.0
    let luddy = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        luddy.coordinate = CLLocationCoordinate2D(latitude: 39.172717, longitude: -86.523224)
        luddy.title = "Luddy Hall"
        mapView.addAnnotation(luddy)
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
    }
    
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            //show map
            setupLocationManager()
            checkLocationAuthorization()
            centerOnUserLocation()
        } else {
            //show alert to turn on location services
        }
        
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            //show location on map
            mapView.showsUserLocation = true
            centerOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //show alert to turn on location
            break
        case .notDetermined:
            //request to turn on location services
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //show alert letting them know thy are restricted
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            centerOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            fatalError()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "mapToElevator", sender: luddy)
        
    }
    
//    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView){
//      performSegue(withIdentifier: "ElevatorHomePage", sender: luddy)
//    }
//
//
//    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!)
//    {
//        print("this runs")
//
//        if let annotationTitle = view.annotation?.title
//        {
//            print("User tapped on annotation with title: \(annotationTitle!)")
//        }
//    }
    
//    var selectedAnnotation: MKPointAnnotation?
//
//    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
//        self.selectedAnnotation = view.annotation as? MKPointAnnotation
//    }
//
//    func info(sender: UIButton) {
//        print(selectedAnnotation?.coordinate)
//    }
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView Id")
//            if view == nil{
//                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView Id")
//                view!.canShowCallout = true
//            } else {
//                view!.annotation = annotation
//            }
//
//            view?.leftCalloutAccessoryView = nil
//            view?.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
//
//            return view
//        }
//
//        func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            if (control as? UIButton)?.buttonType == UIButton.ButtonType.detailDisclosure {
//                mapView.deselectAnnotation(view.annotation, animated: false)
//                performSegue(withIdentifier: "you're segue Id to detail vc", sender: view)
//            }
//        }
    
}

//extensions

extension MapScreen: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

