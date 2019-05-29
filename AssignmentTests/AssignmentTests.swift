//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by test on 21/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    var viewControllerUnderTest: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewControllerTest = storyboard.instantiateViewController(withIdentifier: "ViewController")
            as? ViewController else {
            return
        }
        self.viewControllerUnderTest = viewControllerTest
        viewControllerUnderTest.setupView()
        viewControllerUnderTest.createTableView()
        viewControllerUnderTest.createServiceCall()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.myTableView)
    }
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.myTableView.delegate)
    }
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.myTableView.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to:
            #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to:
            #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    func testTableViewCellHasReuseIdentifier() {
        /*let cell = viewControllerUnderTest.myTableView.dequeueReusableCell
         (withIdentifier: "customCell", for: IndexPath(row: 0, section: 0)) as? TableViewCell*/
        /*let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView,
         cellForRowAt: IndexPath(row: 0, section: 0)) as? TableViewCell*/
        let cell = viewControllerUnderTest.myTableView.dequeueReusableCell(withIdentifier: "customCell")
        //(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "customCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
//        func testTableCellHasCorrectTitleLabelText() {
//            let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TableViewCell
//            XCTAssertNotNil(cell0?.titleLabel.text)
//            let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? TableViewCell
//            XCTAssertNotNil(cell1?.titleLabel.text)
//            let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? TableViewCell
//            XCTAssertNotNil(cell2?.titleLabel.text)
//        }
    //    func testTableCellHasCorrectDescriptionLabelText() {
    //        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TableViewCell
    //        XCTAssertNotNil(cell0?.descriptionLabel.text)
    //        let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? TableViewCell
    //        XCTAssertNotNil(cell1?.descriptionLabel.text)
    //        let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.myTableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? TableViewCell
    //        XCTAssertNotNil(cell2?.descriptionLabel.text)
    //    }
}
