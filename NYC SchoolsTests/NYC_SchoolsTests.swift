//
//  NYC_SchoolsTests.swift
//  NYC SchoolsTests
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import XCTest
@testable import NYC_Schools

class NYC_SchoolsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataAccessGetSchoolsShouldReturnSchoolSummaries() {

        var schools = [NYCSchoolSummary]()
        
        let asyncDone = expectation(description: "Waiting to get school summaries")
        DataAccess.getSchools(completion: { (result) in
            switch result {
            case .success(let summaries):
                schools = summaries
            case .failure(let error):
                print(error)
                break
            }
            asyncDone.fulfill()
        })
        wait(for: [asyncDone], timeout: 10)

        XCTAssertGreaterThan(schools.count, 0)
    }

    func testDataAccessGetSchoolsShouldReturnSchoolDetailForGoodId() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let id = "21K410"
        var schoolInfo: NYCSchoolDetail? = nil
        
        let asyncDone = expectation(description: "Waiting for school details")
        DataAccess.getSchoolInfo(for: id, completion: { (result) in
            switch result {
            case .success(let schoolResult):
                schoolInfo = schoolResult
            case .failure(let error):
                print("error: \(error)")
            }
            asyncDone.fulfill()
        })
        wait(for: [asyncDone], timeout: 10)
        
        XCTAssertNotNil(schoolInfo)
    }

    func testDataAccessGetSchoolsShouldNotReturnSchoolDetailForBadId() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let id = "000000"
        var schoolInfo: NYCSchoolDetail? = nil
        
        let asyncDone = expectation(description: "Waiting for school details")
        DataAccess.getSchoolInfo(for: id, completion: { (result) in
            switch result {
            case .success(let schoolResult):
                schoolInfo = schoolResult
            case .failure(let error):
                print("error: \(error)")
            }
            asyncDone.fulfill()
        })
        wait(for: [asyncDone], timeout: 10)
        
        XCTAssertNil(schoolInfo)
    }

}
