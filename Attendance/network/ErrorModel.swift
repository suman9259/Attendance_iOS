//
//  ErrorModel.swift
//  qootuma
//
//  Created by Dhruv Rawat on 24/09/24.
//

import Foundation


struct ErrorModel: Codable {
    let status: Int?
    let message: String?
    let errors: [Errors]?
}

struct Errors: Codable {
    let  msg, param, location: String?
}
