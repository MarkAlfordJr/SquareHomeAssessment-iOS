//
//  EndPoint.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import Foundation

protocol EndPoint {
    var scheme: String {get}
    
    var baseUrl: String {get}
    
    var path: String {get}
    
    var queryParameters: [URLQueryItem] {get}
    
    var httpMethod: String {get}
}
