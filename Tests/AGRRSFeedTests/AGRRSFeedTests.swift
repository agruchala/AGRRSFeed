import XCTest
@testable import AGRRSFeed

final class AGRRSFeedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AGRRSFeed().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
