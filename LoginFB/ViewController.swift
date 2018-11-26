//
//  ViewController.swift
//  LoginFB
//
//  Created by Germán Santos Jaimes on 11/7/18.
//  Copyright © 2018 Germán Santos Jaimes. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toLoginAccountVC", sender: nil)
        }
        
    }
    @IBAction func loginUser(_ sender: UIButton) {
        guard let correo = email.text,
            let pass = password.text else { return }
        Auth.auth().signIn(withEmail: correo, password: pass) { (data, error) in
            if let error = error{
                debugPrint(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "toLoginAccountVC", sender: nil )
            }
        }
    }
}

