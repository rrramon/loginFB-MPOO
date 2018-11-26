//
//  LoginAccountViewController.swift
//  LoginFB
//
//  Created by Germán Santos Jaimes on 11/7/18.
//  Copyright © 2018 Germán Santos Jaimes. All rights reserved.
//

import UIKit
import Firebase

class LoginAccountViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users").document(userID).getDocument {
            (documentQuery, error) in
            if let query = documentQuery, query.exists {
                let data = query.data()!
                let userName = data["username"] as! String
                self.nombre.text = userName
            }
        }
    }

    @IBAction func logoutUser(_ sender: UIButton) {
        try! Auth.auth().signOut()   
        navigationController?.popViewController(animated: true)
    }
    
}
