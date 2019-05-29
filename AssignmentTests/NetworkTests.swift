//
//  NetworkTests.swift
//  AssignmentTests
//
//  Created by test on 29/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
import Foundation

class NetworkTests: XCTestCase {
    var sut: URLSession!
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    // Asynchronous test: success fast, failure slow
    func testValidCallToFactsUrlGetsHTTPStatusCode200() {
        // given
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        // 1
        let promise = expectation(description: "Status code: 200")
        // when
        let dataTask = sut.dataTask(with: url!) { (_ data, response, error) in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    func testCallToFactsUrlCompletes() {
        // given
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        // when
        let dataTask = sut.dataTask(with: url!) { (_ data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
