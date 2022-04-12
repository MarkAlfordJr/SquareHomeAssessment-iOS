//
//  EmployeeApi.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import Foundation

// https://s3.amazonaws.com/sq-mobile-interview/employees.json

enum EmployeeApi: EndPoint {
    
    case getEmployees(description: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseUrl: String {
        switch self {
        default:
            return "s3.amazonaws.com"
        }
    }
    
    var path: String {
        switch self {
        default:
            return "/sq-mobile-interview/employees.json"
        }
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case .getEmployees(_):
            return []
        }
    }
    
    var httpMethod: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    
}
