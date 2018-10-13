//
//  HomeViewController.swift
//  42Connect
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/06.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("HomeViewController");
        let apiCall = ApiCallController();
        print("HomeViewController GetMyTopics");
        apiCall.getMyTopics();
        print("HomeViewController GetAllTopics");
        apiCall.getAllTopics();
        print("HomeViewController GetPublicTopics");
        apiCall.getPublicTopics();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popViewController(animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
