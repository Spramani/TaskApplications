//
//  Model.swift
//  DyanamicCell
//
//  Created by Shubham Ramani on 12/03/24.
//

import Foundation



struct MultidimensionalArrays: Codable {
    var multidimensional_arrays : [ArrayItem]?
  
}

struct ArrayItem : Codable {
    var id : Int?
    var description : String?
    var sub_layers : [Sub_layers]?
}

struct Sub_layers : Codable {
    var id : Int?
    var description : String?
    var sub_layers : [Sub_layers]?

}


