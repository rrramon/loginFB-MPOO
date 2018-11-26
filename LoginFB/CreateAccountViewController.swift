//
//  CreateAccountViewController.swift
//  LoginFB
//
//  Created by Germán Santos Jaimes on 11/7/18.
//  Copyright © 2018 Germán Santos Jaimes. All rights reserved.
//

import UIKit
import Firebase


class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToLogin(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        guard let correo = email.text,
            let pass = password.text,
            let username = nombre.text else { return }
        print(correo)
        Auth.auth().createUser(withEmail: correo, password: pass) { (data, error) in
            if let error = error{
                debugPrint(error.localizedDescription)
            }
            
            let user = data?.user
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error{
                    debugPrint(error.localizedDescription)
                }
            })
            
            guard let userId = user?.uid else { return }
            
            Firestore.firestore().collection("users").document(userId).setData([
                "username" : username,
                "date_created": FieldValue.serverTimestamp()
                ], completion: { (error) in
                if let error = error {
                    debugPrint(error)
                }else{
                    self.navigationController?.popViewController(animated: true)
                    }
            })
        }
    
    }
    
}
