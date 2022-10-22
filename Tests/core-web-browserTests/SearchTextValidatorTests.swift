//
//  SearchTextValidator.swift
//  
//
//  Created by Mauricio Cesar on 22/10/22.
//

import Foundation
import XCTest
import core_web_browser

class SearchTextValidatorTests: XCTestCase {
    func test_makeURL_withCorrectURLText_deliversURL() {
        let url = SearchTextValidator.makeURL(from: "https://apple.com")
        
        XCTAssertEqual(url.absoluteString, "https://apple.com")
    }
    
    func test_makeURL_withoutURLText_deliversSearchEngineURL() {
        let url = SearchTextValidator.makeURL(from: "apple")
        
        XCTAssertEqual(url.absoluteString, "https://www.google.com/search?q=apple&ie=utf-8&oe=utf-8")
    }
}
