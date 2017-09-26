//
//  NavigationViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 23/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class NavigationViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: - Init
    convenience init(source : CLLocationCoordinate2D, destination : CLLocationCoordinate2D) {
        self.init(nibName: "NavigationViewController", bundle: nil)
        self.sourceCoordinate = source
        self.destinationCoordinate = destination
    }
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var avi: UIActivityIndicatorView!
    
    // MARK: - Properties
    var sourceCoordinate : CLLocationCoordinate2D?
    var destinationCoordinate : CLLocationCoordinate2D?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawPath()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func drawPath(){
        
        let start : CLLocationCoordinate2D = sourceCoordinate!
        let destination : CLLocationCoordinate2D = destinationCoordinate!
        
        let urlStr = "http://maps.google.com/?saddr=\(start.latitude),\(start.longitude)&daddr=\(destination.latitude),\(destination.longitude)&output=embed"
        let url  = URL(string: urlStr)
        
        let embadedHTML = "<html><head><title>.</title><style>body,html,iframe{margin:0;padding:0;}</style></head><body><iframe width=\"\(webView.frame.size.width)\" height=\"\(webView.frame.size.height)\" src=\"\(url!)\" frameborder=\"0\" allowfullscreen></iframe></body></html>"
        webView.loadHTMLString(embadedHTML, baseURL: url)
        webView.delegate = self;
        avi.isHidden = false
        avi.startAnimating()
       
    }
    
    // MARK: - Web View
    func webViewDidStartLoad(_ webView: UIWebView) {
        //
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //
         SVProgressHUD.showError(withStatus: error.localizedDescription)
        avi.stopAnimating()
        avi.isHidden = true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //
       
        avi.stopAnimating()
        avi.isHidden = true
    }
    

    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
