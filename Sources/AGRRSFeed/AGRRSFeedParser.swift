//
//  AGRRSFeedParser.swift
//  AGRRSFeed
//
//  Created by Artur Gruchała on 25/04/2021.
//

import Foundation

final class AGRRSFeedParser: NSObject {
    
    var parser: XMLParser? = nil
    var feed: AGRRSChannel! = nil
    var parsingItems: Bool = false
    
    var currentItem: AGRRSItem! = nil
    var currentString: String!
    var currentAttributes: [String: String]? = nil
    var parseError: Error? = nil
    
    func parse(data: Data) -> AGRRSChannel? {
        
        parser = XMLParser(data: data)
        parser?.delegate = self
        feed = AGRRSChannel()
        self.currentItem = nil
        currentAttributes = nil
        currentString = String()
        parser?.parse()
        return feed
    }
}

extension AGRRSFeedParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentString = String()
        
        currentAttributes = attributeDict
        
        if ((elementName == "item") || (elementName == "entry")) {
            currentItem = AGRRSItem()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let currentItem = self.currentItem {
            if ((elementName == "item") || (elementName == "entry")) {
                feed?.items.append(currentItem)
                return
            }
            
            if (elementName == "title") {
                currentItem.title = self.currentString
            }
            
            if (elementName == "description") {
                currentItem.description = self.currentString
            }
            
            if (elementName == "link") {
                currentItem.link = self.currentString
            }
        } else {
            if (elementName == "title") {
                feed?.title = self.currentString
            }
            
            if (elementName == "description") {
                feed?.description = self.currentString
            }
            
            if (elementName == "link") {
                feed?.link = self.currentString
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString.append(string)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        self.parseError = parseError
        parser.abortParsing()
    }
}
