//
//  HomeViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    

    
    @IBAction func btnOrderMenu(_ sender: Any) {
        performSegue(withIdentifier: "order", sender: (Any).self)
    }
    @IBAction func btnBookBuffet(_ sender: Any) {
        performSegue(withIdentifier: "book", sender: (Any).self)
    }
    @IBAction func btnProfil(_ sender: Any) {
        performSegue(withIdentifier: "profil", sender: (Any).self)
    }
    @IBAction func btnLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true;        // Do any additional setup after loading the view.
    }
    
}
