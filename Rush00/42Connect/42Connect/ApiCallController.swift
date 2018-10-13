//
//  ApiCallController.swift
//  42Connect
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/07.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import Foundation

struct Topic {
    var name: String;
    var user: String;
    var date: String;
    var messages_url: String!
    var id: Int!
    
    init(name: String, user: String, date: String, messages_url: String, id: Int) {
        self.name = name;
        self.user = user;
        self.date = date;
        self.messages_url = messages_url;
        self.id = id;
    }
}

var Topics: [Topic] = [];

class ApiCallController: NSObject {
    
    let uid = "2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4";
    let secret = "429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74";
    let UID = "2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4";
    let SECRET = "429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74";
    let redirectUri = "https://profile.intra.42.fr/";
    let baseUrl = "https://api.intra.42.fr";
    
    var count: Int = 0;
    
    var token: String?;
    var authorId: Int?;
    var login: String?;
    
    func handleDate(created_at: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX";
        let date = dateFormatter.date(from: created_at);
        dateFormatter.dateFormat = "MM/dd/yy HH:mm";
        if let d = date {
            return (dateFormatter.string(from: d));
        }
        return (created_at);
    }
    
    func handleTopics(dic: [Any]) {
        Topics.removeAll();
        for i in 0...(dic.count - 1) {
            if let topic = dic[i] as? [String: Any] {
                if let topicInfo = topic["topic"] as? [String: Any] {
                    if let user = topicInfo["author"] as? [String: Any] {
                        Topics.append(Topic(
                            name: topicInfo["name"] as! String,
                            user: user["login"] as! String,
                            date: handleDate(created_at: topicInfo["created_at"] as! String),
                            messages_url: topicInfo["messages_url"] as! String,
                            id: topic["topic_id"] as! Int
                        ));
                        if (count < 10){
                            print(Topic(
                                name: topicInfo["name"] as! String,
                                user: user["login"] as! String,
                                date: handleDate(created_at: topicInfo["created_at"] as! String),
                                messages_url: topicInfo["messages_url"] as! String,
                                id: topic["topic_id"] as! Int
                            ))
                            count = count + 1;
                        }
                    }
                }
            }
        }
    }
    
    func getAppToken(){
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!;
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        let postString = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data");
                return;
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []);
            if let responseJSON = responseJSON as? [String: Any] {
                print("---------------------------- App Token -------------------------------");
                print(responseJSON)
                let dictionary = responseJSON;
                let newAccessToken  = (dictionary["access_token"] as? String)!;
                print("App Access Token = \(newAccessToken)");
                appToken = newAccessToken;
                self.getAuthorisedApp();
                print("-----------------------------App Token ------------------------------");
            }
        }
        task.resume();
    }
    
    func getAccessToken(){
        // create post request
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!;
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        
        let postString = "grant_type=authorization_code&client_id=\(uid)&client_secret=\(secret)&code=\(code)&redirect_uri=\(redirectUri)&state=a_very_long_random_string_witchmust_be_unguessable"
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print();
                print("---------------------------- Access Token -------------------------------");
                print(responseJSON)
                let dictionary = responseJSON;
                let newAccessToken  = (dictionary["access_token"] as? String)!;
                let tokenType  = (dictionary["token_type"])!;
                let refresh_token  = (dictionary["refresh_token"])!;
                let expiresIn  = (dictionary["expires_in"])!;
                let scope  = (dictionary["scope"])!;
                print("Access Token = \(newAccessToken)");
                print("Token Type = \(tokenType)");
                print("Refresh Token = \(refresh_token)");
                print("Expires In = \(expiresIn)");
                print("Scope = \(scope)");
                accessToken = newAccessToken;
                self.getAuthorisedUser();
                print("---------------------------- Access Token -------------------------------");
            }
        }
        task.resume()
    }
    
    func getAuthorisedUser(){
        // create post request
        let url = URL(string: "https://api.intra.42.fr/v2/me")!;
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("-------------------------- Check User ---------------------------------");
                print(accessToken);
                print(responseJSON);
                print("--------------------------- Check User --------------------------------");
            }
        }
        task.resume();
    }
    
    func getAuthorisedApp(){
        // create post request
        let url = URL(string: "https://api.intra.42.fr/v2/me")!;
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("Bearer \(appToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("-------------------------- Check User ---------------------------------");
                print(appToken);
                print(responseJSON);
                print("--------------------------- Check User --------------------------------");
            }
        }
        task.resume();
    }
    
    func getPublicTopics() {
        let url = URL(string: "https://api.intra.42.fr/v2/cursus/1/cursus_topics?page[size]=100");
        var request = URLRequest(url: url!);
        request.httpMethod = "GET";
        request.setValue("Bearer \(appToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print();
                print("------------------------- Public Topics ----------------------------------");
                print(appToken);
                print(responseJSON)
                print("------------------------- Public Topics ----------------------------------");
            }
        }
        task.resume();
    }
    
    func getAllTopics(){
        let url = URL(string: "https://api.intra.42.fr/v2/topics?access_token=\(accessToken)")!;
        //let url = URL(string: "https://api.intra.42.fr/v2/cursus/1/cursus_topics?page[size]=100");
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        //request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print();
                print("------------------------ All Topics -----------------------------------");
                print(accessToken);
                print(responseJSON)
                print("------------------------ All Topics -----------------------------------");
            }
        }
        task.resume();
    }
    
    func getMyTopics(){
        guard let url = URL(string: "https://api.intra.42.fr/v2/cursus/1/cursus_topics") else { return };
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("curl/7.54.0", forHTTPHeaderField: "User-Agent");
        request.setValue("Accept", forHTTPHeaderField: "*/*");
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization");
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print();
                print("------------------------- My Topics ----------------------------------");
                print(accessToken);
                print(responseJSON)
                print("------------------------- My Topics ----------------------------------");
            }
        }
        task.resume();
    }
}
