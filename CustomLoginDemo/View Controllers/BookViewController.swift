//
//  BookViewController.swift
//  CustomLoginDemo
//
//  Created by Pantat Alien on 11/12/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    @IBAction func btnAddBook(_ sender: Any) {
        performSegue(withIdentifier: "addB", sender: (Any).self)
    }
    
    @IBAction func btnShowBook(_ sender: Any) {
        performSegue(withIdentifier: "showB", sender: (Any).self)
    }
    
    @IBAction func btnEditBook(_ sender: Any) {
        performSegue(withIdentifier: "editB", sender: (Any).self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
