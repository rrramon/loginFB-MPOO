//
//  InfoViewController.swift
//  LoginFB
//
//  Created by Ramon Ramos Rosales on 11/22/18.
//  Copyright © 2018 Germán Santos Jaimes. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tablita: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablita.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
    

    var users = [String]()
    func fetchUsers(onSuccess: @escaping ([String]) -> Void) {
        Firestore.firestore().collection("users").getDocuments {
            (querySnapshot, error) in
            if let error = error {
                debugPrint(error)
            } else {
                var userList = [String]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["username"] as! String
                    
                    userList.append(name)
                }
                onSuccess(userList)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablita.delegate = self
        tablita.dataSource = self
        
        fetchUsers {
            (userList) in
            self.users = userList
            print(userList)
            self.tablita.reloadData()
        }
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
