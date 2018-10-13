//
//  ApiController.swift
//  42Connect
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/06.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class ApiController: NSObject {

    let uid = "2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4";
    let secret = "429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74";
    let redirectUri = "https://profile.intra.42.fr/";
    let baseUrl = "https://api.intra.42.fr";
    let BEARER = accessToken;
    let UID = "2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4";
    let SECRET = "429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74";
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
    
//    curl -F grant_type=authorization_code \
//    -F client_id=2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4 \
//    -F client_secret=429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74 \
//    -F code=781101fa6e9416c9c4a786997f4b94fe888ffa80b9cf575bec84130406e76e9c \
//    -F redirect_uri=https://profile.intra.42.fr/ \
//    -X POST https://api.intra.42.fr/oauth/token
    
    func getAppToken(){
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!;
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        let postString = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                let dictionary = responseJSON;
                let newAccessToken  = (dictionary["access_token"] as? String)!;
//                let tokenType  = (dictionary["token_type"])!;
//                let refresh_token  = (dictionary["refresh_token"])!;
//                let expiresIn  = (dictionary["expires_in"])!;
//                let scope  = (dictionary["scope"])!;
                print("-----------------------------------------------------------");
                print("App Access Token = \(newAccessToken)");
//                print("Token Type = \(tokenType)");
//                print("Refresh Token = \(refresh_token)");
//                print("Expires In = \(expiresIn)");
//                print("Scope = \(scope)");
                print("-----------------------------------------------------------");
                appToken = newAccessToken;
                //self.getAuthorisedUser();
            }
        }
        task.resume()
    }
    
    func getAccessToken(){
        // prepare json data
//        let json: [String: Any] = [
//            "grant_type": "authorization_code",
//            "client_id": "\(uid)",
//            "client_secret": "\(secret)",
//            "code": "\(code)",
//            "redirect_uri": "\(redirectUri)"
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: json);
        
        // create post request
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!;
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        
        // insert json data to the request
        //request.httpBody = jsonData
       
        let postString = "grant_type=authorization_code&client_id=\(uid)&client_secret=\(secret)&code=\(code)&redirect_uri=\(redirectUri)&state=a_very_long_random_string_witchmust_be_unguessable"
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                let dictionary = responseJSON;
                let newAccessToken  = (dictionary["access_token"] as? String)!;
                let tokenType  = (dictionary["token_type"])!;
                let refresh_token  = (dictionary["refresh_token"])!;
                let expiresIn  = (dictionary["expires_in"])!;
                let scope  = (dictionary["scope"])!;
                print("-----------------------------------------------------------");
                print("Access Token = \(newAccessToken)");
                print("Token Type = \(tokenType)");
                print("Refresh Token = \(refresh_token)");
                print("Expires In = \(expiresIn)");
                print("Scope = \(scope)");
                print("-----------------------------------------------------------");
                accessToken = newAccessToken;
                self.getAuthorisedUser();
            }
        }
        task.resume()
    }
    
    func getToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token");
        var request = URLRequest(url: url!);
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        let body = [
            "grant_type": "authorization_code",
            "client_id": UID,
            "client_secret": SECRET,
            "code": code,
            "redirect_uri": "https://profile.intra.42.fr/"
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted);
        } catch let error {
            print(error.localizedDescription)
            return ;
        }
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let err = error {
                print(err);
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let t = dic["access_token"] as? String {
                            self.token = t;
                            accessToken = t;
                            print("Access Token: \(t)")
                        }
                    }
                } catch {
                    print(error.localizedDescription);
                }
            }
            group.leave();
        };
        group.enter();
        task.resume();
        group.wait();
    }
    
    
    func getAccessTokenAgain() {
        let uid = "2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4";
        let secret = "429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74";
        let url = URL(string: "https://api.intra.42.fr/oauth/token");
        var request = URLRequest(url: url!);
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        let body = [
            "grant_type": "authorization_code",
            "client_id": uid,
            "client_secret": secret,
            "code": code,
            "redirect_uri": "http://www.rush00.piscine-swift.com"
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted);
        } catch let error {
            print(error.localizedDescription)
            return ;
        }
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let err = error {
                print(err);
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let t = dic["access_token"] as? String {
                            accessToken = t;
                            print(t);
                            self.getAuthorisedUser();
                        }
                    }
                } catch {
                    print(error.localizedDescription);
                }
            }
            group.leave();
        };
        group.enter();
        task.resume();
        group.wait();
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
                print("------------------------- Public Topics ----------------------------------");
                print(appToken);
                print(responseJSON)
                print("------------------------- Public Topics ----------------------------------");
            }
        }
        task.resume();
    }
    
    func getTopics() {
        let url = URL(string: "https://api.intra.42.fr/v2/cursus/1/cursus_topics?page[size]=100");
        var request = URLRequest(url: url!);
        request.httpMethod = "GET";
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization");
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print("enter");
            if let err = error {
                print(err);
            } else if let d = data {
                do {
                    if let dic: [Any] = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] {
                        self.handleTopics(dic: dic);
                        print("done")
                    }
                } catch {
                    print(error.localizedDescription);
                }
            }
            print("leave");
            group.leave();
        };
        group.enter();
        task.resume();
        group.wait();
        print("stop waiting");
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
        //request.setValue("/v2/cursus/1/cursus_topics HTTP/1.1", forHTTPHeaderField: "GET");
        //request.setValue("api.intra.42.fr", forHTTPHeaderField: "Host");
        //request.setValue("curl/7.54.0", forHTTPHeaderField: "User-Agent");
        request.setValue("curl/7.54.0", forHTTPHeaderField: "User-Agent");
        request.setValue("Accept", forHTTPHeaderField: "*/*");
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization");
        
//        GET /v2/cursus/1/cursus_topics HTTP/1.1
//        Host: api.intra.42.fr
//        User-Agent: curl/7.54.0
//        Accept: */*
//         Authorization: Bearer 84f505a31ec0c1ebf43660146365eea34178a16933794fbdf6e9cb4f65fb21a1

        
//        var items = [URLQueryItem]();
//        var myURL = URLComponents(string: "https://api.intra.42.fr/v2/me/topics");
//        let param = ["access_token":"\(code)"]
//        for (key,value) in param {
//            items.append(URLQueryItem(name: key, value: value))
//        }
//        myURL?.queryItems = items
//        let request =  URLRequest(url: (myURL?.url)!)
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("------------------------- My Topics ----------------------------------");
                print(accessToken);
                print(responseJSON)
            }
            if let httpResponse = response as? HTTPURLResponse {
                if let xDemAuth = httpResponse.allHeaderFields["X-Dem-Auth"] as? String {
                    // use X-Dem-Auth here
                    for test in xDemAuth{
                        print(test.description);
                    }
                }
            }
            print("------------------------- My Topics ----------------------------------");
        }
        task.resume();
    }
  
}
