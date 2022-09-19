//
//  MapView.swift
//  LearningEnglish
//
//  Created by Mert on 19.09.2022.
//

import SwiftUI
import MapKit
struct MapView: View {
    
  
    
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        Map(coordinateRegion: $viewModel.region,showsUserLocation: true).ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}



final class MapViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
    
    @Published var region: MKCoordinateRegion =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.0, longitude: 10.45)
        ,span: MKCoordinateSpan(
            latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            //            locationManager?.desiredAccuracy=kCLLocationAccuracyBest
            //            checkLocationAuthorization()
            locationManager!.delegate = self
        }
        else
        {
            print("test")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        checkLocationAuthorization()
    }
}
