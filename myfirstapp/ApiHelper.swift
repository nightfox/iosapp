//
//  ApiController.swift
//  myfirstapp
//
//  Created by Anirvan Mandal on 09/12/15.
//  Copyright © 2015 Anirvan Mandal. All rights reserved.
//

import Foundation

class ApiHelper {

    let requestProtocol = "http://"
    let host = "localhost.com:3000"
    let namespace = "api"
    let apiVersion = "v1"
    
    func baseUrl () -> String {
        return self.requestProtocol + self.host + "/" + self.namespace + "/" + self.apiVersion + "/" + "registrations"
    }
    
    func makePostRequest(data: NSObject, successHandler:(String) -> Bool, errorHandler: (AnyObject, AnyObject) -> Int) -> Void {
        let url = NSURL(string: self.baseUrl())!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["hello": "Hello POST world"]
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
        } catch {
            print("JSON Serialization failed. Fuck you Fuck you Fuck you json")
        }
        
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    errorHandler(data!, response!)
                    return
            }
            
            if let postString = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String {
                successHandler(postString)
            }
            
        }).resume()
        
    }
}