//
//  Buttton.swift
//  JsonCreateUI
//
//  Created by Shubham Ramani on 08/03/24.
//

import Foundation


struct UserFormResponse: Codable {
    let form: Form
}

struct Form: Codable {
    let title: String
    let fields: [FormField]
}

struct FormField: Codable {
    let type: String
    let text: String?
    let items:[String]?
    let placeholder: String?
    let layout: LayoutProperties?
}

struct LayoutProperties: Codable {
    let backgroundColor: String?
    let borderColor: String?
    let borderWidth: CGFloat?
    let textColor: String?
}


