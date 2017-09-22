//
//  PlayGroundsViewController.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit

class PlayGroundsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - SetupLayouts
    func setupLayouts(){
        self.title = "Playgrounds"
    }
    
    // MARK: - TableViewDelegate&datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PlayGroundCell", owner: self, options: nil)?.first as! PlayGroundCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: - Actions&Methods

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
