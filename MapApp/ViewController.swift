//
//  ViewController.swift
//  MapApp
//
//  Created by Евгений Андронов on 23.02.2022.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    
    // добавление точки на карту, сейчас она используется для постановки точки твоего местоположения по координатам
    
    func PointOnMap(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let latitude: CLLocationDegrees = 38.28472
        let longitude: CLLocationDegrees = 39.9672416
        
        let lanDelta = 0.15
        let lonDelta = 0.15
        //размеры отображения
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        
        let locate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: locate, span: span)
        
        map.setRegion(region, animated: true)
        //добавление аннотаций для отображения
        let annotation = MKPointAnnotation()
        
        annotation.title = "Me"
        annotation.subtitle = "I'm heare"
        annotation.coordinate = locate
        map.addAnnotation(annotation)
    }
    //создание точки на карте, две следующие функции addNewPointOnMap, longpress
    func addNewPointOnMap(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpress))
        longPress.minimumPressDuration = 1
        map.addGestureRecognizer(longPress)
    }
    //отработка нажатия
    @objc func longpress(gestureRecognize: UIGestureRecognizer){
        let touchPoint = gestureRecognize.location(in: self.map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        annotation.title = "New point"
        annotation.coordinate = coordinate
        self.map.addAnnotation(annotation)
    }
    //настройки для отображения себя
    func addMyLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //мои координаты, скорость движения, время, дата
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locate:[CLLocation]){
        print(locate)
        
        let userLocation = locate.first!
        let coordinate = userLocation.coordinate
        let lon = coordinate.longitude // долгота
        let lat = coordinate.latitude // широта
        let speed = userLocation.speed // скорость передвижения
        let time = userLocation.timestamp// 2022-02-24 17:22:03 +0000 format like this
        
        print("\(lon)  -----   \(lat) --- \(time) --- \(speed)")
        PointOnMap(lat: lat, lon: lon)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        addMyLocation()
        //PointOnMap()
        
        addNewPointOnMap()
        
    }
    


}

