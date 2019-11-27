//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        checkIfSignedIn()
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        /*Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)*/
        
    }
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        self.showError("")        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            self.showError("Email tidak boleh Kosong!!!")
        }else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
              self.showError("Password tidak boleh Kosong!!!")
        }
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result {
              let user = result.user
                if user.isEmailVerified {
                if error != nil {
                    // Couldn't sign in
                    
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    self.transitionToHome()
                    
                    /*let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()*/

                }
                
              } else {
                self.showError("Please Verified Your Email")
                // do whatever you want to do when user isn't verified
              }
            }
           
            
        }
        
      
        
    }
    
    func showError(_ message:String) {
              
              errorLabel.text = message
              errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        performSegue(withIdentifier: "toHome", sender: (Any).self)
        
    }
    
    func checkIfSignedIn() {
        if Auth.auth().currentUser != nil {
          performSegue(withIdentifier: "toMenu", sender: (Any).self)       } else {
          //User Not logged in
       }
    }
    
}
