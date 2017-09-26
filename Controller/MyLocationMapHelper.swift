//
//  MyLocationMapHelper.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 24/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GooglePlaces
import SVProgressHUD
import Alamofire
extension MyLocationViewController: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    //MARK: - Google Places
    func placeAutocomplete(_ text : String?) {
        DKGoogleClass.shared.placeAutocomplete(text) { (places, errorString) in
            if errorString == nil{
                self.placeArray = places
                self.tableView.reloadData()
            }
            else{
                SVProgressHUD.showError(withStatus: errorString)
            }
        }
    }
    func getPlaceDetailsAfterSelection(_ selectedPlace : DKGooglePlace){
        SVProgressHUD.show(withStatus: "Please wait...")
        DKGoogleClass.shared.getCoordinateFromPlaceId(selectedPlace.placeId) { (coordinate, errorStr) in
            if errorStr != nil  {
                SVProgressHUD.showError(withStatus:errorStr)
            }
            else{
                SVProgressHUD.dismiss()
                self.HideTableView()
            }
            
        }
    }
    //MARK: - SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.showTableView()
        let str = (searchBar.text ?? ""  + text)
        //self.placeAutocomplete(str)
        return true
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return false
    }
    
    //MARK: - TableViewDelegate/DataSource
    func showTableView(){
        tableViewHeight.constant = 260
    }
    func HideTableView(){
        tableViewHeight.constant = 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell  =  Bundle.main.loadNibNamed("AutoCompletePlaceCell", owner: self, options: nil)?.first as! AutoCompletePlaceCell
        cell.setCellData(placeArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let selectedCell = tableView.cellForRow(at: indexPath)
        
        //self.getPlaceDetailsAfterSelection(place)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
