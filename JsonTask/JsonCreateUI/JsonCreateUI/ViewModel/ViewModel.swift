//
//  ViewModel.swift
//  JsonCreateUI
//
//  Created by Shubham Ramani on 08/03/24.
//

import Foundation


class ApiHandler {
    static var shared = ApiHandler()
    
    var userForm: UserFormResponse?
    
    func jsonCall(complition: @escaping ((_ data:UserFormResponse)->()) ){
        if let path = Bundle.main.path(forResource: "userForm", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                userForm = try JSONDecoder().decode(UserFormResponse.self, from: jsonData)
                
                if let userForm = userForm {
                   complition(userForm)
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    
}
