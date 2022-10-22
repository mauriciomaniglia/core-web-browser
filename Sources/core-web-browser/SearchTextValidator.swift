//
//  SearchTextValidator.swift
//  
//
//  Created by Mauricio Cesar on 22/10/22.
//

import Foundation

public final class SearchTextValidator {

    public static func makeURL(from text: String) -> URL {
        if let url = URIFixup.getURL(text) {
            return url
        } else {
            return SearchURLBuilder.buildURL(fromTerm: text)
        }
    }
}
