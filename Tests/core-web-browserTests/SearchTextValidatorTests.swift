//
//  SearchTextValidator.swift
//  
//
//  Created by Mauricio Cesar on 22/10/22.
//

import Foundation
import XCTest
import core_web_browser

final class SearchTextValidator {
    func makeURL(from text: String) -> URL {
        if let url = URIFixup.getURL(text) {
            return url
        } else {
            return SearchURLBuilder.buildURL(fromTerm: text)
        }
    }
}

class SearchTextValidatorTests: XCTestCase {
    func test_makeURL_withCorrectURLText_deliversURL() {
        let sut = SearchTextValidator()
        
        let url = sut.makeURL(from: "https://apple.com")
        
        XCTAssertEqual(url.absoluteString, "https://apple.com")
    }
    
    func test_makeURL_withoutURLText_deliversSearchEngineURL() {
        let sut = SearchTextValidator()
        
        let url = sut.makeURL(from: "apple")
        
        XCTAssertEqual(url.absoluteString, "https://www.google.com/search?q=apple&ie=utf-8&oe=utf-8")
    }
}
