//
//  LocationsModel.swift
//  Arcade App Base
//
//  Created by Paul Dickey on 12/3/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsModel {
    
    var geoFenceLatitude = 0.0
    var geoFenceLongitude = 0.0
    var geoFenceRadius = 0.0
    
    
    func canWeWorkout(latitude: Double, longitude: Double) -> Bool {
        
        let fromLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        var places:[Places] = [
            
            Places( title: "Bear Cave Fitness",
                    cllocation: CLLocation( latitude :36.6157, longitude: -121.8285), regionRadius: 100.0, location: "Bear Cave Fitness",
                    type: "Gym",distance : CLLocation( latitude :36.6157,
                                                       longitude: -121.8285).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6157,-121.8285)),
            Places( title: "Otters Sports Center",
                    cllocation: CLLocation(latitude:36.6545,longitude:-121.8084), regionRadius:100.0, location:"CSUMB",
                    type: "Gym",distance : CLLocation(latitude:36.6545,
                                                      longitude:-121.8084).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6545,-121.8084)),
            Places( title: "Anytime Fitness Marina",
                    cllocation: CLLocation(latitude:36.6654,longitude:-121.8109), regionRadius:100.0, location:"Anytime Fitness Marina",
                    type: "Gym",distance : CLLocation(latitude:36.6654,
                                                      longitude:-121.8109).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6654,-121.8109)),
            Places( title: "In Shape Monterey - Fremont Street",
                    cllocation: CLLocation(latitude:36.5967713919556,longitude:-121.85367114721271), regionRadius:100.0, location:"In Shape Monterey - Fremont Street",
                    type: "Gym",distance : CLLocation(latitude:36.5967713919556,
                                                      longitude:-121.85367114721271).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5967713919556,-121.85367114721271)),
            Places( title: "Crossfit Monterey",
                    cllocation: CLLocation(latitude:36.6015,longitude:-121.8653), regionRadius:100.0, location:"Crossfit Monterey",
                    type: "Gym",distance : CLLocation(latitude:36.6015,
                                                      longitude:-121.8653).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6015,-121.8653)),
            Places( title: "First City Crossfit",
                    cllocation: CLLocation(latitude:36.5851,longitude:-121.8504), regionRadius:100.0, location:"First City Crossfit",
                    type: "Gym",distance : CLLocation(latitude:36.5851,
                                                      longitude:-121.8504).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5851,-121.8504)),
            Places( title: "In Shape Pacific Grove",
                    cllocation: CLLocation(latitude:36.608,longitude:-121.9224), regionRadius:100.0, location:"In Shape Pacific Grove",
                    type: "Gym",distance : CLLocation(latitude:36.608,
                                                      longitude:-121.9224).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.608,-121.9224)),
            Places( title: "In Shape Carmel",
                    cllocation: CLLocation(latitude:36.5419,longitude:-121.9064), regionRadius:100.0, location:"In Shape Carmel",
                    type: "Gym",distance : CLLocation(latitude:36.5419,
                                                      longitude:-121.9064).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5419,-121.9064)),
            Places( title: "Cycle Bar - Carmel",
                    cllocation: CLLocation(latitude:36.5428,longitude:-121.9038), regionRadius:100.0, location:"Cycle Bar - Carmel",
                    type: "Gym",distance : CLLocation(latitude:36.5428,
                                                      longitude:-121.9038).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5428,-121.9038)),
            Places( title: "Monterey Sports Center",
                    cllocation: CLLocation(latitude:36.6001,longitude:-121.8916), regionRadius:150.0, location:"Monterey Sports Center",
                    type: "Gym",distance : CLLocation(latitude:36.6001,
                                                      longitude:-121.8916).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6001,-121.8916)),
            Places( title: "Golds Gym - Del Monte",
                    cllocation: CLLocation(latitude:36.5839,longitude:-121.8952), regionRadius:100.0, location:"Golds Gym - Del Monte",
                    type: "Gym",distance : CLLocation(latitude:36.5839,
                                                      longitude:-121.8952).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5839,-121.8952)),
            Places( title: "Fit Republic",
                    cllocation: CLLocation(latitude:36.5861,longitude:-121.8620), regionRadius:100.0, location:"Fit Republic",
                    type: "Gym",distance : CLLocation(latitude:36.5861,
                                                      longitude:-121.8620).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.5861,-121.8620)),
            Places( title: "Montage Wellness Center",
                    cllocation: CLLocation(latitude:36.6672,longitude:-121.8085), regionRadius:50.0, location:"Montage Wellness Center",
                    type: "Gym",distance : CLLocation(latitude:36.6672,
                                                      longitude:-121.8085).distance(from: fromLocation),
                    coordinate : CLLocationCoordinate2DMake(36.6672,-121.8085)),
            ]
        
        //Before sort the array
        for k in 0...(places.count-1) {
            print("\(places[k].distance!)")
        }
        //sort the array based on the current location to calculate the distance to compare the each and every array objects to sort the values
        for place in places {
            place.calculateDistance(fromLocation: fromLocation) // Replace YOUR_LOCATION with the location you want to calculate the distance to.
        }
        
        for k in 0...(places.count-1) {
            if places[k].distance! > places[k].regionRadius {
                print("Distance too far \(places[k].distance!)")
            } else {
                print("Distance close enough \(places[k].distance!)")
                print("Location of workout is: \(places[k].title!)")
                print("Latitude of location is: \(places[k].cllocation.coordinate.latitude)")
                print("Longitude of location is: \(places[k].cllocation.coordinate.longitude)")
                geoFenceLatitude = places[k].cllocation.coordinate.latitude
                geoFenceLongitude = places[k].cllocation.coordinate.longitude
                geoFenceRadius = places[k].regionRadius
                return true
                //This ONLY prints the one that a user is closest to for working out
            }
        }
        return false
    }
}
