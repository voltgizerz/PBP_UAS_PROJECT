//
//  NotificationController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 9 on 21/11/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import FirebaseAuth

class NotificationController: UITableViewController {
    @IBOutlet weak var btnKeLogin: UIButton!
    
    @IBAction func keLogin(_ sender: Any) {
           try! Auth.auth().signOut()
        performSegue(withIdentifier: "notiftologin", sender: (Any).self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
}
