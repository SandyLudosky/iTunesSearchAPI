//
//  iTunesSearchAPITests.swift
//  iTunesSearchAPITests
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import XCTest
@testable import iTunesSearchAPI


internal class SearchAPITests: XCTestCase  {
     let client = APIClient<APIService>()
     let dataController = DataManager()

    func testAPIService() {
        let service = APIService.search(term: "eminem", media: .music(entity: .mix, attribute: nil), country: nil)
        XCTAssertTrue(service.request?.url == URL(string: "https://itunes.apple.com/search?term=eminem&country&media=music&entity=mix"), "URL should be well formatted - see iTunesSearchAPI docs")
    }
    
    func testAPIServiceFail() {
        let service = APIService.search(term: "eminem", media: .music(entity: .mix, attribute: nil), country: nil)
        XCTAssertTrue(service.request?.url != URL(string: "https://itunes.apple.com/search?"), "fatal error")
    }
}

internal class DataControllerTests: XCTestCase  {
    let client = APIClient<APIService>()
    let dataController = DataManager()
    func testDataControllerResultsShouldSucceed() {
        let service = APIService.search(term: "eminem", media: .music(entity: .mix, attribute: nil), country: nil)
        XCTAssertTrue(service.request?.url == URL(string: "https://itunes.apple.com/search?term=eminem&country&media=music&entity=mix"), "URL should be well formatted - see iTunesSearchAPI docs")
    }
    
    func testDataControllerResultsShouldFail() {
        let service = APIService.search(term: "eminem", media: .music(entity: .mix, attribute: nil), country: nil)
        dataController.search(for: service) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(true, "result should be success")
            case .failure(_):
                XCTAssertTrue(false, "result should be success")
            }
        }
    }
    
    func testAPIServiceShouldFail() {
        let service = APIService.lookup(id: "34", entity: nil)
        dataController.lookup(with:  "34", entity: nil, completion: { results in
            switch results {
            case .success(_):
                XCTAssertTrue(false, "result should be success")
            case .failure(_):
                XCTAssertTrue(true, "result should be error")
            }
        })
    }
}
