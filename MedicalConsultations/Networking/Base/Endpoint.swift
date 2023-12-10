//
//  Endpoint.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 10/12/23.
//

import Foundation

protocol Endpoint {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var schema: String {
        "http"
    }
    
    var host: String {
        "localhost"
    }
}
