//
//  WebViewController.swift
//  42Connect
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/06.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{

    
    @IBOutlet weak var authWebView: WKWebView!
    
    @IBAction func nextButton(_ sender: UIButton) {
        let str  = (authWebView.url?.absoluteString)!;
        let array = str.components(separatedBy: "=");
        code = array[array.count - 1];
        print("my code is \(code)");
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4&redirect_uri=https%3A%2F%2Fprofile.intra.42.fr%2F&response_type=code&scope=public&state=a_very_long_random_string_witchmust_be_unguessable");
        let request = URLRequest(url: url!);
        authWebView.load(request);
        authWebView.navigationDelegate = self;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link \((authWebView.url?.absoluteString)!)")
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        var link: String = (authWebView.url?.absoluteString)!;
        if (link.contains("https://profile.intra.42.fr/"))
        {
            print("link \((authWebView.url?.absoluteString)!)")
            let str  = (authWebView.url?.absoluteString)!;
            let array = str.components(separatedBy: "=");
            let str2 = array[array.count - 2];
            let array2 = str2.components(separatedBy: "&");
            code = array2[0];
            print("my code is \(code)");
            let apiCall = ApiCallController();
            apiCall.getAccessToken();
            apiCall.getAppToken();
            let HomeViewPage:HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController;
            self.navigationController?.pushViewController(HomeViewPage, animated: true);
        }
        link = "";
        decisionHandler(WKNavigationActionPolicy.allow)
    }

}
