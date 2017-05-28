//
//  ViewController.swift
//  Fetch Json
//
//  Created by Jin Kato on 5/27/17.
//  Copyright © 2017 Jin Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK : Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        
    }
    
    //MARK : Helper
    
    func fetchVideos() {
        let url = URL(string: "http://realtime.mbta.com/developer/api/v2/routes?api_key=wX9NwuHnZU2ToO7GmGR9uw&format=json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "nil")
                return
            }
            self.convertToDictionary(data: data!)
        }.resume()
    }
    func convertToDictionary(data:Data){
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dictionary = json as! [String: AnyObject]
            let modeArray = dictionary["mode"]
            for mode in modeArray as! [[String: AnyObject]] {
                guard let modeName = mode["mode_name"] else { return }
                print(modeName)
            }
        } catch let jsonError {
            print(jsonError)
        }
    }
}

