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
    let host = "127.0.0.1:3000"
    let namespace = "api"
    let apiVersion = "v1"
    
    func baseUrl () -> String {
        return self.requestProtocol + self.host + "/" + self.namespace + "/" + self.apiVersion
    }
    
    func call(data: AnyObject) {
        
    }
}