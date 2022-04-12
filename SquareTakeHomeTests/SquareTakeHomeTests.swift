//
//  SquareTakeHomeTests.swift
//  SquareTakeHomeTests
//
//  Created by Mark Alford on 4/5/22.
//

import XCTest
@testable import SquareTakeHome

class SquareTakeHomeTests: XCTestCase {
    
    // determine the number of times API is first called from viewDidLoad
    func test_ViewDidLoad_CallsApi() throws {
        // make mock Serice object
        let mockApiService = MockApiManager()
        // access viewController
        let viewController: ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        // have new object = Mock service now
        viewController.networkObject = mockApiService
        
        viewController.loadViewIfNeeded()
    
        XCTAssertEqual(mockApiService.requestCallCount, 1)
    }
   
    //MARK: - Mock Api
    class MockApiManager: ApiManager {
        var requestCallCount = 0
        
        override func getRequest<T>(endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
            requestCallCount += 1
        }
    }
}
