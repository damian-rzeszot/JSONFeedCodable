//
//  FeedDecodableTests.swift
//  JSONFeedTests
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import JSONFeed


class FeedDecodableTests: XCTestCase {

    let decoder = JSONDecoder()


    // MARK: -

    override func setUp() {
        super.setUp()
        decoder.dateDecodingStrategy = .iso8601
    }


    // MARK: -

    func testVersion() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [] }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertEqual(feed!.version, URL(string: "https://jsonfeed.org/version/1")!)
    }

    func testTitle() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "This is title", "items": [] }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertEqual(feed!.title, "This is title")
    }

    func testDescription() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "description": "This is description" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.description)
        XCTAssertEqual(feed!.description!, "This is description")
    }

    func testAuthor() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "author": { "name": "Jon Snow" } }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.author)
        XCTAssertNotNil(feed!.author!.name)
        XCTAssertEqual(feed!.author!.name!, "Jon Snow")
    }

    func testHomepage() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "home_page_url": "https://example.org/" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.homepage)
        XCTAssertEqual(feed!.homepage!, URL(string: "https://example.org/")!)
    }

    func testFeed() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "feed_url": "https://example.org/" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.feed)
        XCTAssertEqual(feed!.feed!, URL(string: "https://example.org/")!)
    }

    func testNext() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "next_url": "https://example.org/" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.next)
        XCTAssertEqual(feed!.next!, URL(string: "https://example.org/")!)
    }

    func testIcon() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "icon": "https://example.org/image.png" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.icon)
        XCTAssertEqual(feed!.icon!, URL(string: "https://example.org/image.png")!)
    }

    func testFavicon() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "favicon": "https://example.org/image.png" }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.favicon)
        XCTAssertEqual(feed!.favicon!, URL(string: "https://example.org/image.png")!)
    }

    func testExpired() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [], "expired": true }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertNotNil(feed!.expired)
        XCTAssertTrue(feed!.expired!)
    }

    func testItems() {
        // given:
        let payload = """
            { "version": "https://jsonfeed.org/version/1", "title": "", "items": [ { "id": "11" }, { "id": "22" } ] }
        """

        // when:
        let feed = try? decoder.decode(Feed.self, from: payload)

        // then:
        XCTAssertNotNil(feed)
        XCTAssertEqual(feed!.items.count, 2)
        XCTAssertEqual(feed!.items[0].id, "11")
        XCTAssertEqual(feed!.items[1].id, "22")
    }


    // MARK: -

    func decode<T: Decodable>(_ type: T.Type, from string: String) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: string.data(using: .utf8)!)
    }

    func decode<T: Decodable, E: Error>(_ type: T.Type, from string: String) -> E? {
        let decoder = JSONDecoder()

        do {
            _ = try decoder.decode(type, from: string.data(using: .utf8)!)
            return nil
        } catch {
            return error as? E
        }
    }

}
