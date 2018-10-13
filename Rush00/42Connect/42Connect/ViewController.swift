//
//  ViewController.swift
//  42Connect
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/06.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

//import oauth2
//import p2_OAuth2

var code: String = "code"
var accessToken: String = "token"
var appToken: String = "apptoken"

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
//    let uid = "7e66ea1f01ef9bf057d50f28f68e6b0d6a2d6179012b51e5c8e0ba9ce97c42f2";
//    let secret = "057cf7ccc9de80a7ca27deeacf0116dd7b469b4fb78f01b86f0f89ec82ea43dc";
//    let baseUrl = NSUrl(string: "https://api.intra.42.fr/");
//    let BEARER = (())
    
    
    var userName: String = "";
    var userPassword: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print(code);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClick(_ sender: UIButton) {
        /*userName = userNameTextField.text!;
        userPassword = userPasswordTextField.text!;
        if (userName != "" && userPassword != ""){
            let alert = UIAlertController(title: "Login", message: "Logging in \(userName)", preferredStyle: .alert);
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true);
            
            
            
        } else {
            let alert = UIAlertController(title: "Error!", message: "Please enter a valid Username and Password!", preferredStyle: .alert);
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true);
        }*/
        
    }
    
}

