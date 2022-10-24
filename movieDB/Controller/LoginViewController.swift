//
//  ViewController.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 17/10/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let requestToken = RequestTokenNetwork()
    let requestAuth = AuthenticationNetwork()
    
    private var token:RequestToken?
    private var checkLogin:Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.password.isSecureTextEntry = true
    }
    
    @IBAction func signIn(_ sender: Any) {
        Task {
            do {
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let now = Date()
                let expiredDate = dateFormat.date(from:User.expiredAt) ?? Date().addingTimeInterval(-60 * 60)
                
                if expiredDate < now {
                    self.token = try await requestToken.getToken()
                    User.expiredAt = customDateString(60, "yyyy-MM-dd HH:mm:ss")
                    User.token = self.token!.requestToken
                }
            }catch{
                print("gagal load api")
            }
        }
        self.requestAuth.getAuth(self.username.text!, self.password.text!, User.token) { result in
            
            DispatchQueue.main.async {
                self.createAlert("Authentication", result.statusMessage)
            }
        }
    }
    
}

