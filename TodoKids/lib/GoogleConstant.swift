//
//  GoogleConstant.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import GooglePlaces
import CoreLocation
import GooglePlacePicker
import Alamofire
enum GoogleKeys : String {
    case apiKey = "AIzaSyAYnrr5b5riPxnRZlwCyQtkFRNL5j6BZSk"
    case serverKey = "AIzaSyDEqXnX27t8p70vjxZWlPbaix5L-v0XxYs"
}
struct DKGooglePlace {
    var title : String?
    var subtitle : String?
    var placeId : String?
    var fullAddress : String?
}
class DKGoogleClass {
    class var shared: DKGoogleClass {
        struct Static {
            static let instance = DKGoogleClass()
        }
        return Static.instance
    }
    func placeAutocomplete(_ text : String?, completion:@escaping (_ places : [DKGooglePlace], _ errorStr : String?) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        let placeClient : GMSPlacesClient = GMSPlacesClient()
        var places : [DKGooglePlace] = []
        placeClient.autocompleteQuery(text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                completion(places,error.localizedDescription)
                // SVProgressHUD.showInfo(withStatus: error.localizedDescription)
                
                return
            }
            
            if let results = results {
                for prediction in results {
                    var place : DKGooglePlace = DKGooglePlace()
                    place.title = prediction.attributedPrimaryText.string
                    place.subtitle = prediction.attributedSecondaryText?.string
                    place.placeId = prediction.placeID
                    place.fullAddress = prediction.attributedFullText.string
                    places.append(place)
                    //label.attributedText = bolded
                }
                
            }
            completion(places,nil)
        })
    }
    func getCoordinateFromPlaceId(_ placeId : String?, completion:@escaping (_ coordinate : CLLocationCoordinate2D, _ errorStr : String?) -> Void ){
        let placesClient : GMSPlacesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeId!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),error.localizedDescription)
                return
            }
            
            guard let place = place else {
                print("No place details for")
                completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),"No place details for this place")
                return
            }
            let coordinate : CLLocationCoordinate2D? = place.coordinate
            if coordinate == nil{
                completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),"No coordinate details for this place")
                return
            }
            completion(coordinate!,nil)
        })
    }
    func getRootFromGoogle(sourceCoordinate : CLLocationCoordinate2D , destinationCoordinate : CLLocationCoordinate2D, completion: @escaping(_ roots : [Any], _ errorStr : String?)-> Void ){
        let sourceLocation = String.init(format: "%f,%f", sourceCoordinate.latitude,sourceCoordinate.longitude)
        let destinationLocaion = String.init(format: "%f,%f", destinationCoordinate.latitude,destinationCoordinate.longitude)
        let urlStr = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocaion)&key=\(GoogleKeys.apiKey.rawValue)"
        Alamofire.request(urlStr).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let dict : [String : Any]? = json as? Dictionary
                guard let routesArr : [Any] = dict?["routes"] as? Array else{
                    completion([],"Unable to find root")
                    return
                }
                completion(routesArr,nil)
            }
            else{
                completion([],"Unable to find root")
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    func getDistanceFrom(_ fromCoordinate : CLLocationCoordinate2D, To toCoordinate : CLLocationCoordinate2D) -> Double{
        
        let coordinate₀ = CLLocation(latitude: fromCoordinate.latitude, longitude: fromCoordinate.longitude)
        let coordinate₁ = CLLocation(latitude: toCoordinate.latitude, longitude: toCoordinate.longitude)
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        return distanceInMeters
    }
    func getAddress(_ coordinate : CLLocationCoordinate2D, completion:@escaping (_ address : String?, _ error : String?, _ country : String?, _ postalCode : String?, _ title : String? ) -> Void){
        let geoCoder : GMSGeocoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinate) { (responce, error) in
            if error != nil{
                completion("",error?.localizedDescription,"","","")
            }
            else{
                let address  = responce?.results()?.first
                var fullAddress : String!
                if address?.lines?.count != 0{
                    fullAddress = (address?.lines?.joined(separator: " "))!
                }
                else{
                  //  fullAddress = (address?.thoroughfare ?? "") + (address?.subLocality ?? "") + (address?.locality ?? "") + (address?.administrativeArea ?? "") + (address?.country ?? "") + (address?.postalCode ?? "")
                }
                completion(fullAddress,nil,address?.country ?? "",address?.postalCode ?? "",(address?.subLocality ?? "") + (address?.locality ?? ""))
            }
            
        }
    }
    func getNearByPlaces(_ coordinate : CLLocationCoordinate2D?){
        
        let urlStr = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.6516,77.1582&radius=5000&type=clubs&keyword=cruise&key=\(GoogleKeys.serverKey.rawValue)"
        Alamofire.request(urlStr).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let dict : [String : Any]? = json as? Dictionary
                print(dict)
                guard let routesArr : [Any] = dict?["routes"] as? Array else{
                    // completion([],"Unable to find root")
                    return
                }
                print(routesArr)
                //completion(routesArr,nil)
            }
            else{
                // completion([],"Unable to find root")
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
