//
//  visitasViewController.swift
//  Cocktail
//
//  Created by Mac2 on 22/01/21.
//

import UIKit
import CoreLocation

class visitasViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var lugarLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    


    @IBAction func ubicarButton(_ sender: UIButton) {
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
