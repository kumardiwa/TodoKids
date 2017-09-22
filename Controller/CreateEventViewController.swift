//
//  CreateEventViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 21/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtCotegory: UITextField!
    @IBOutlet weak var txtAboutEvent: UITextView!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    // MARK: - Properties

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - SetupLayouts
    func setupLayouts(){
        self.title = "Create Event"
        setupUpdateView()
        setupAboutEventTextView()
        setupSubmitButton()
        
    }
    func setupSubmitButton(){
        btnSubmit.layer.cornerRadius = 6.0
    }
    func setupUpdateView(){
        uploadView.layer.cornerRadius = 6.0
    }
    func setupAboutEventTextView(){
        txtAboutEvent.layer.cornerRadius = 6.0
    }
    
    // MARK: - Actions&Methods
    @IBAction func uploadButtonAction(_ sender: Any) {
    }
    @IBAction func submitButtonAction(_ sender: Any) {
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
