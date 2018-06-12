//
//  ItemDecodableTests.swift
//  JSONFeedTests
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import JSONFeed


class ItemDecodableTests: XCTestCase {

    let decoder = JSONDecoder()

    // MARK: -

    override func setUp() {
        super.setUp()
        decoder.dateDecodingStrategy = .iso8601
    }


    // MARK: -

    func testIdAttribute() {
        // given:
        let payload = """
            { "id": "identifier" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)


        // then:
        XCTAssertNotNil(item)
        XCTAssertEqual(item!.id, "identifier")
    }

    func testURLAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "url": "https://example.org/identifier" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)


        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.url)
        XCTAssertEqual(item!.url!, URL(string: "https://example.org/identifier")!)
    }

    func testExternalAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "external_url": "https://example.org/identifier" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)


        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.external)
        XCTAssertEqual(item!.external!, URL(string: "https://example.org/identifier")!)
    }

    func testTitleAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "title": "This is title" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.title)
        XCTAssertEqual(item!.title!, "This is title")
    }

    func testSummaryAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "summary": "This is summary" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.summary)
        XCTAssertEqual(item!.summary!, "This is summary")
    }

    func testImageAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "image": "https://example.org/image.png" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.image)
        XCTAssertEqual(item!.image!, URL(string: "https://example.org/image.png")!)
    }

    func testBannerAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "banner_image": "https://example.org/banner.png" }
        """

        // when:
        let item = try? JSONDecoder().decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.banner)
        XCTAssertEqual(item!.banner!, URL(string: "https://example.org/banner.png")!)
    }

    func testPublishedDateAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "date_published": "2010-02-07T14:04:00-05:00" }
        """

        // when:
        let item = try? decoder.decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.published)
        XCTAssertEqual(item!.published!, Date(timeIntervalSince1970: 1265569440))
    }

    func testModifiedDateAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "date_modified": "2010-02-07T14:04:00-05:00" }
        """

        // when:
        let item = try? decoder.decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.modified)
        XCTAssertEqual(item!.modified!, Date(timeIntervalSince1970: 1265569440))
    }

    func testAuthorAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "author": { "name": "Jon Snow" } }
        """

        // when:
        let item = try? decoder.decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.author)
        XCTAssertNotNil(item!.author!.name)
        XCTAssertEqual(item!.author!.name!, "Jon Snow")
    }

    func testTagsAttribute() {
        // given:
        let payload = """
            { "id": "identifier", "tags": ["first", "second"] }
        """

        // when:
        let item = try? decoder.decode(Item.self, from: payload)

        // then:
        XCTAssertNotNil(item)
        XCTAssertNotNil(item!.tags)
        XCTAssertEqual(item!.tags!.count, 2)
        XCTAssertEqual(item!.tags![0], "first")
        XCTAssertEqual(item!.tags![1], "second")
    }

}
