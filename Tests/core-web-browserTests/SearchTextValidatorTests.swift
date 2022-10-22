//
//  SearchTextValidator.swift
//  
//
//  Created by Mauricio Cesar on 22/10/22.
//

import Foundation
import XCTest

final class SearchTextValidator {
    func makeURL(from text: String) -> URL {
        return URL(string: "https://apple.com")!
    }
}

class SearchTextValidatorTests: XCTestCase {
    func test_makeURL_withCorrectURLText_deliversURL() {
        let sut = SearchTextValidator()
        
        let url = sut.makeURL(from: "https://apple.com")
        
        XCTAssertEqual(url.absoluteString, "https://apple.com")
    }
}
