//
//  SearchURLBuilder.swift
//  
//
//  Created by Mauricio Cesar on 12/10/22.
//

import XCTest
import core_web_browser

class SearchURLBuilderTests: XCTestCase {
    func test_buildURLFromTerm_deliversCorrectURL() {
        let url1 = SearchURLBuilder.buildURL(fromTerm: "computer")
        let url2 = SearchURLBuilder.buildURL(fromTerm: "computer science")
        
        XCTAssertEqual(url1.absoluteString, "https://www.google.com/search?q=computer&ie=utf-8&oe=utf-8")
        XCTAssertEqual(url2.absoluteString, "https://www.google.com/search?q=computer%20science&ie=utf-8&oe=utf-8")
    }
}

