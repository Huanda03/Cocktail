//
//  visitasViewController.swift
//  Cocktail
//
//  Created by Mac2 on 22/01/21.
//

import UIKit
import MapKit
import CoreLocation

class visitasViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var Mapa: MKMapView!
    @IBOutlet weak var BotonControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        Mapa.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func cambiarMapa(_ sender: Any) {
        switch BotonControl.selectedSegmentIndex {
        case 0:
            Mapa.mapType = .standard
        case 1:
            Mapa.mapType = .satellite
        case 2:
            Mapa.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func Ubicacion(_ sender: UIButton) {
        let permiso = CLLocationManager.authorizationStatus()
        if permiso == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if permiso == .denied{
            print("Permiso denegado")
        }else if permiso == .restricted{
            print("Permiso restringido")
        }else{
            guard let currentLocation = locationManager.location?.coordinate else { return }
            let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            Mapa.setRegion(region, animated: true)
        }
      
        
    }
}

extension visitasViewController :  CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Ubicacion obtenida")
        if let ubicacion = locations.last{
            print(ubicacion.coordinate.latitude)
            print(ubicacion.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
