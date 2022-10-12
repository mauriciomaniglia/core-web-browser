//
//  SearchURLBuilder.swift
//  
//
//  Created by Mauricio Cesar on 12/10/22.
//

import XCTest

final class SearchURLBuilder {
    static func buildURL(fromTerm query: String) -> URL {
        let searchTemplate = "https://www.google.com/search?q={searchTerms}&ie=utf-8&oe=utf-8"
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .searchTermsAllowed)!
        
        let templateAllowedSet = NSMutableCharacterSet()
        templateAllowedSet.formUnion(with: .URLAllowed)
        templateAllowedSet.formUnion(with: CharacterSet(charactersIn: "{}"))

        let encodedSearchTemplate = searchTemplate.addingPercentEncoding(withAllowedCharacters: templateAllowedSet as CharacterSet)!
        let urlString = encodedSearchTemplate.replacingOccurrences(of: "{searchTerms}", with: escapedQuery, options: .literal, range: nil)

        return URL(string: urlString)!
    }
}

class SearchURLBuilderTests: XCTestCase {
    func test_buildURLFromTerm_deliversCorrectURL() {
        let url1 = SearchURLBuilder.buildURL(fromTerm: "computer")
        let url2 = SearchURLBuilder.buildURL(fromTerm: "computer science")
        
        XCTAssertEqual(url1.absoluteString, "https://www.google.com/search?q=computer&ie=utf-8&oe=utf-8")
        XCTAssertEqual(url2.absoluteString, "https://www.google.com/search?q=computer%20science&ie=utf-8&oe=utf-8")
    }
}

