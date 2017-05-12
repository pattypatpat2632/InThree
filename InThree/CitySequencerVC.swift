//
//  CitySequencerVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/8/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import CoreLocation

class CitySequencerVC: SequencerVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.sharedInstance.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        FirebaseManager.sharedInstance.observeAllScoresIn(locationID: "No Neighborhood")
    }
}

extension CitySequencerVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            setLocationData()
        } else if status == .denied {
            returnToDashboard()
        }
    }
    
    func setLocationData() {
        print("LOCATION DATA BEING SET**************")
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let title = "NYC"
            let coordinate = CLLocationCoordinate2DMake(40.705253, -74.014070)
            let regionRadius = 1609.34 * 8
            let clCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = CLCircularRegion(center: clCoordinate, radius: regionRadius, identifier: title)
            print("LOCATION MANAGER START MONITORING**************")
            locationManager?.startMonitoring(for: region)
            
            let rochester = "Rochester"
            let rochesterCoordinate = CLLocationCoordinate2DMake(43.1610, 77.6109)
            let rochesterRadius = 1609.34 * 5
            let clRocCoordinate = CLLocationCoordinate2D(latitude: rochesterCoordinate.latitude, longitude: rochesterCoordinate.longitude)
            let rocRegion = CLCircularRegion(center: clRocCoordinate, radius: rochesterRadius, identifier: rochester)
            locationManager?.startMonitoring(for: rocRegion)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("LOCATION MANAGER DID START MONITORING FOR REGION: \(region.identifier)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print(state)
        print("region :\(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("DID ENTER REGION*****************")
        sequencerEngine.mode = .neighborhood(region.identifier)
        FirebaseManager.sharedInstance.observeAllScoresIn(locationID: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //TODO: stop local sequence
        print("DID EXIT REGION*****************")
        sequencerEngine.mode = .neighborhood("No Neighborhood")
        sequencerEngine.sequencer.tracks[1].clear()
        FirebaseManager.sharedInstance.observeAllScoresIn(locationID: "No Neighborhood")
    }
    
}
//MARK: Location based sequencer
extension SequencerVC {
    func grabLocalSequence() {
        guard FirebaseManager.sharedInstance.allLocationScores.count > 0 else {return}
        let scoredIndex = UInt32(FirebaseManager.sharedInstance.allLocationScores.count - 1)
        let randNum = Int(arc4random_uniform(scoredIndex))
        let randomScore = FirebaseManager.sharedInstance.allLocationScores[randNum]
        sequencerEngine.generateSequence(fromScore: randomScore, forUserNumber: 1)
    }
}
