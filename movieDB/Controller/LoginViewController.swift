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
    @IBOutlet weak var signInLoading: UIActivityIndicatorView!
    @IBOutlet weak var signIn: UIButton!
    
    let requestToken = RequestTokenNetwork()
    let requestAuth = AuthenticationNetwork()
    
    private var token:RequestToken?
    private var checkLogin:Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator(self.signInLoading, "hide")
        self.password.isSecureTextEntry = true
    }
    
    @IBAction func signIn(_ sender: Any) {
        self.loadingIndicator(self.signInLoading, "show")
        self.signIn.isEnabled = false
        Task {
            do {
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let now = Date()
                let expiredDate = dateFormat.date(from:User.expiredAt) ?? Date().addingTimeInterval(-60 * 60)

                if expiredDate < now {
                    self.token = try await requestToken.getToken()
                    User.expiredAt = self.customDateString(60, "yyyy-MM-dd HH:mm:ss")
                    User.token = self.token!.requestToken
                }
                self.authProccess(self.username.text!, self.password.text!, User.token)
            }catch{
                print("gagal load api")
            }
        }
    }
    
    fileprivate func authProccess(_ username:String,_ password:String,_ token:String) -> Void {
        self.requestAuth.getAuth(username, password, token) { result in
            DispatchQueue.main.async {
                self.createAlert("Authentication", result.statusMessage)
                if result.success {
                    print("success")
                }
                self.signIn.isEnabled = true
                self.loadingIndicator(self.signInLoading, "hide")
            }
        }
    }
}

