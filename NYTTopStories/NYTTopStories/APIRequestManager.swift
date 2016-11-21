//
//  APIRequestManager.swift
//  NYTTopStories
//
//  Created by Tong Lin on 11/20/16.
//  Copyright © 2016 Tong Lin. All rights reserved.
//

import Foundation

internal class APIRequestManager{
    internal static let manager = APIRequestManager()
    init() {}
    
    func getData(urlString: String, callback: @escaping (Data) -> () ) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, _, error: Error?) in
            if error != nil{
                print(error!)
            }
            if data != nil{
                callback(data!)
            }
        }.resume()
    }
    
}
