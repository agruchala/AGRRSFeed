//
//  AGRRSResponse.swift
//  AGRRSFeed
//
//  Created by Artur Gruchała on 25/04/2021.
//

import Foundation

public class AGRRSItem {
    internal(set) public var title: String!
    internal(set) public var link: String!
    internal(set) public var description: String!
}

public class AGRRSChannel {
    internal(set) public var title: String!
    internal(set) public var link: String!
    internal(set) public var description: String!
    internal(set) public var items: [AGRRSItem] = []
}
