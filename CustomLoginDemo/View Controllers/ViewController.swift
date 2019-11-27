//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfSignedIn()              // Do any additional setup after loading the view.
        
        //setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    func checkIfSignedIn() {
        if Auth.auth().currentUser != nil {
          performSegue(withIdentifier: "toMenu", sender: (Any).self)       } else {
          //User Not logged in
       }
    }
    


}

