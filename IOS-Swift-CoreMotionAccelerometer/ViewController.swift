//
//  ViewController.swift
//  IOS-Swift-CoreMotionAccelerometer
//
//  Created by Pooya Hatami on 2018-03-29.
//  Copyright © 2018 Pooya Hatami. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {
  
    @IBOutlet weak var xGyro: UILabel!
    @IBOutlet weak var yGyro: UILabel!
    @IBOutlet weak var zGyro: UILabel!

    @IBOutlet weak var XAccel: UILabel!
    @IBOutlet weak var yAccel: UILabel!
    @IBOutlet weak var zAccel: UILabel!
    
    @IBOutlet weak var xDevi: UILabel!
    @IBOutlet weak var yDevi: UILabel!
    @IBOutlet weak var zDevi: UILabel!
    
    @IBOutlet weak var devLatitude: UILabel!
    @IBOutlet weak var devlongitude: UILabel!
    
    var motion = CMMotionManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("start did load")
    }

    override func viewDidAppear(_ animated: Bool) {
        
        print("Start Did Appear")

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        myDeviceMotion()
//        myGyroscope()
//        myAccelerometer()
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let trueData: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(trueData.latitude) \(trueData.longitude)")
        self.devLatitude!.text = "Latitude: \(trueData.latitude)"
        self.devlongitude!.text = "Longitude: \(trueData.longitude)"
    }
    
    
    func myDeviceLocations(){
        print("Start DeviceLocations")
        motion.gyroUpdateInterval = 0.5
        motion.startGyroUpdates(to: OperationQueue.current!) {
            (data, error) in
            print(data as Any)
            if let trueData =  data {
                
                self.view.reloadInputViews()
                self.devLatitude!.text = "Latitude: \(trueData.rotationRate.x)"
                self.devlongitude!.text = "Longitude: \(trueData.rotationRate.y)"
            }
        }
        return
    }
    
    
    func myDeviceMotion(){
        print("Start DeviceMotion")
        motion.deviceMotionUpdateInterval  = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) {
            (data, error) in
            print(data as Any)
            if let trueData =  data {
                
                self.view.reloadInputViews()
                self.xDevi!.text = "x (pitch): \(trueData.attitude.pitch)"
                self.yDevi!.text = "y (roll): \(trueData.attitude.roll)"
                self.zDevi!.text = "z (yaw): \(trueData.attitude.yaw)"
            }
        }
        return
    }

    
    func myGyroscope(){
        print("Start Gyroscope")
        motion.gyroUpdateInterval = 0.5
        motion.startGyroUpdates(to: OperationQueue.current!) {
            (data, error) in
            print(data as Any)
            if let trueData =  data {
                
                self.view.reloadInputViews()
                self.xGyro!.text = "x: \(trueData.rotationRate.x)"
                self.yGyro!.text = "y: \(trueData.rotationRate.y)"
                self.zGyro!.text = "z: \(trueData.rotationRate.z)"
            }
        }
        return
    }
    
    
    func myAccelerometer() {
        print("Start Accelerometer")
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!) {
            (data, error) in
            print(data as Any)
            if let trueData =  data {
                
                self.view.reloadInputViews()
                self.XAccel!.text = "x: \(trueData.acceleration.x)"
                self.yAccel!.text = "y: \(trueData.acceleration.y)"
                self.zAccel!.text = "z: \(trueData.acceleration.z)"
            }
        }

        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

