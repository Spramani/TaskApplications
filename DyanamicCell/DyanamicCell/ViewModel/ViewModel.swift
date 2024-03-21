//
//  ViewModel.swift
//  DyanamicCell
//
//  Created by Shubham Ramani on 12/03/24.
//

import Foundation


class ApiHandler {
    static var shared = ApiHandler()
    
    var userForm: MultidimensionalArrays?
    
    func jsonCall(complition: @escaping ((_ data:MultidimensionalArrays)->()) ){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                userForm = try JSONDecoder().decode(MultidimensionalArrays.self, from: jsonData)
                
                if let userForm = userForm {
                   complition(userForm)
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    
}
