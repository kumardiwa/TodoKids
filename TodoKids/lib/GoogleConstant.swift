//
//  GoogleConstant.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps
import CoreLocation
import Alamofire
enum GoogleKeys : String {
    case apiKey = "AIzaSyAYnrr5b5riPxnRZlwCyQtkFRNL5j6BZSk"
    
    case serverKey = "AIzaSyDEqXnX27t8p70vjxZWlPbaix5L-v0XxYs"
}
enum DKPlaceType : String {
    case atm = "atm"
    case bakery = "bakery"
    case bank = "bank"
    case bar = "bar"
    case cafe = "cafe"
    case casino = "casino"
    case food = "food"
    case meal_delivery = "meal_delivery"
    case meal_takeaway = "meal_takeaway"
    case night_club = "night_club"
    case park = "park"
    case restaurant = "restaurant"
}
struct DKGooglePlace {
    var title : String?
    var subtitle : String?
    var placeId : String?
    var fullAddress : String?
}
class DKNearbyPlace {
    var coordinate : CLLocationCoordinate2D?{
        get{
            return CLLocationCoordinate2D(latitude: latitude ?? 0.00, longitude: longitude ?? 0.00)
        }
    }
    var id : String?
    var name : String?
    var iconUrl : URL?
    var place_id : String?
    var isOpen : Bool?
    var reference : String?
    var vicinity : String?
    var photoHeight : Float?
    var photoWidth : Float?
    var photo_reference : String?
    var latitude : CLLocationDegrees?
    var longitude : CLLocationDegrees?
    var image : UIImage?
    var imageMetaData : GMSPlacePhotoMetadata?
    var rating : Float = 0.0
    var type : DKPlaceType?
    
    
    func loadFirstPhoto(completion : @escaping (_ photo : UIImage? , _ errorStr : String? ) -> Void) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: self.place_id!) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                completion(nil, error.localizedDescription)
            } else {
                if let firstPhoto = photos?.results.first {
                    self.imageMetaData = firstPhoto
                    self.loadImageForMetadata(photoMetadata: firstPhoto, completion: { (photo, errorStr) in
                       completion(photo,errorStr)
                    })
                }
                else{
                    completion(nil, "Unable to find metadeta")
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata , completion : @escaping (_ photo : UIImage?, _ errorStr : String? ) -> Void) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                completion(nil,error.localizedDescription)
            } else {
                self.image = photo
                completion(photo,nil)
                //self.imageView.image = photo;
              //  self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
    func loadPhoto(completion : @escaping (_ photo : UIImage?, _ errorStr : String?) -> Void){
        self.loadFirstPhoto { (photo, errorStr) in
            completion(photo,errorStr)
        }
    }
    
    func updatePlaceDetails(){
        let placesClient : GMSPlacesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(self.place_id!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for")
                return
            }
            self.rating = place.rating
            //print("Place name \(place.name)")
            //print("Place address \(place.formattedAddress)")
           // print("Place placeID \(place.placeID)")
           // print("Place attributions \(place.attributions)")
        })
    }
    
    func getDetails(){
        let placesClient : GMSPlacesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(self.place_id!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
               // completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),error.localizedDescription)
                return
            }
            
            guard let place = place else {
                print("No place details for")
                //completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),"No place details for this place")
                return
            }
            let coordinate : CLLocationCoordinate2D? = place.coordinate
            if coordinate == nil{
               // completion(CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),"No coordinate details for this place")
                return
            }
            //completion(coordinate!,nil)
        })
    }
    
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
    func getNearByPlaces(_ coordinate : CLLocationCoordinate2D? , type : DKPlaceType, completion: @escaping(_ places : [DKNearbyPlace], _ errorStr : String?)-> Void ){
       //rankby=distance
        let urlStr = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(LocationTracker.shared.latitude!),\(LocationTracker.shared.longitude!)&rankby=distance&type=\(type.rawValue)&key=\(GoogleKeys.serverKey.rawValue)"
        Alamofire.request(urlStr).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let dict : [String : Any]? = json as? Dictionary
                guard let results : [[String : Any]] = dict?["results"] as? Array else{
                     completion([],"Unable to find Places")
                    return
                }
                let places = self.nearByPlaces(results, type: type)
                completion(places,nil)
            }
            else{
                 completion([],"Unable to find Places")
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    func getRestaurents(){
        
    }
    func nearByPlaces(_ results : [[String : Any]], type : DKPlaceType) -> [DKNearbyPlace]{
        var places : [DKNearbyPlace] = []
        for result in results {
            let geometry : [String : Any]? = result["geometry"] as? Dictionary
            let location : [String :Any]? = geometry?["location"] as? Dictionary
            let opening_hours : [String : Any]? = result["opening_hours"] as? Dictionary
            let photos : [Any]? = result["photos"] as? Array
            let photoDict : [String : Any]? = photos?.first as? Dictionary
            
            let latitude : CLLocationDegrees? = location?["lat"] as? CLLocationDegrees
            let longitude : CLLocationDegrees? = location?["lng"] as? CLLocationDegrees
            let name : String? = result["name"] as? String
            let id : String? = result["id"] as? String
            let icon : String? = result["icon"] as? String
            let placeId : String? = result["place_id"] as? String
            let reference : String? = result["reference"] as? String
            let vicinity : String? = result["vicinity"] as? String
            let isOpen : Bool? = opening_hours?["open_now"] as? Bool
            let photoHeight : Float? = photoDict?["height"] as? Float
            let photoWidth : Float? = photoDict?["width"] as? Float
            let photoReference : String? = photoDict?["photo_reference"] as? String
            
            let place = DKNearbyPlace()
            place.latitude = latitude
            place.longitude = longitude
            place.name = name
            place.id = id
            place.iconUrl = URL(string: icon ?? "")
            place.place_id = placeId
            place.reference = reference
            place.vicinity = vicinity
            place.isOpen = isOpen
            place.photoHeight = photoHeight
            place.photoWidth = photoWidth
            place.photo_reference = photoReference
            place.type = type
            place.updatePlaceDetails()
//            place.loadFirstPhoto(completion: { (photo, errorStr) in
//                //
//            })
            places.append(place)

        }
        return places
    }
    

}
