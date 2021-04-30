//
//  AGRRSFeed.swift
//  AGRRSFeed
//
//  Created by Artur Gruchała on 25/04/2021.
//

import Combine
import Foundation

/// Public protocl, can be used for mocking in testing
public protocol AGRRSFeedProtocol {
    
    /// Fetches channel from given RSS feed url, returns nothing if error occurs
    /// - Parameter from: url of RSS feed channel
    func channel(from: URL) -> AnyPublisher<AGRRSChannel,Never>
}

/// RSS Feed parser
public struct AGRRSFeed: AGRRSFeedProtocol {
    public init() { }
    public func channel(from url: URL) -> AnyPublisher<AGRRSChannel, Never> {
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .map { data -> AGRRSChannel? in
                let parser = AGRRSFeedParser()
                return parser.parse(data: data)
            }.replaceError(with: nil)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
