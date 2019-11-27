//
//  ProfileViewController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 20/11/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
     let db = Firestore.firestore()
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let currentUser = Auth.auth().currentUser
        db.collection("users").document(currentUser!.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                self.txtUsername.text=document.get("firstname") as? String
                self.txtPassword.text=document.get("password") as? String
                self.txtEmail.text=document.get("email") as? String
                
            } else {
                print("Anda Siapa bisa disini? data anda tidak ada!")
            }
        }
        
        
       
        // Do any additional setup after loading the view.
    }
    
 		
    @IBAction func editProfile(_ sender: Any) {
        
        
         let currentUser = Auth.auth().currentUser
         let changeName: String = txtUsername.text!
         let changePassword: String = txtPassword.text!
        
        Auth.auth().currentUser?.updatePassword(to: changePassword) { (error) in
            }
        db.collection("users").document(currentUser!.uid).updateData([
            "firstname": changeName,
            "password": changePassword,
            "uid": currentUser!.uid]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                 print("Profile Updated")
                self.performSegue(withIdentifier: "toUtama", sender: (Any).self)
            }
        }
    }
    
    @IBAction func deleteProfile(_ sender: Any) {
        let user = Auth.auth().currentUser
        

        user?.delete { error in
            if error != nil {
            print("Error Bos!")
          } else {
                self.db.collection("users").document(user!.uid).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            print("Account Deleted!")
                 try! Auth.auth().signOut()
               self.navigationController?.popToRootViewController(animated: true);
          }
        }
    }
    
  
    
}

