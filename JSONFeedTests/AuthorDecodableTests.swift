//
//  AuthorDecodableTests.swift
//  JSONFeedTests
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import JSONFeed


final class AuthorDecodableTests: XCTestCase {


    // MARK: -

    func testEmptyDictionaryShouldReturnNil() {
        // given:
        let payload = """
            {}
        """

        // when:
        let error: Author.Error? = decode(Author.self, from: payload)

        // then:
        XCTAssertNotNil(error)
        XCTAssertTrue(error! == .oneMemberRequired)
    }


    // MARK: -

    func testDictionaryShouldReturnName() {
        // given:
        let payload = """
            { "name": "Jon Snow" }
        """

        // when:
        let author = decode(Author.self, from: payload)

        // then:
        XCTAssertNotNil(author)

        XCTAssertNotNil(author!.name)
        XCTAssertEqual(author!.name!, "Jon Snow")

        XCTAssertNil(author!.avatar)
        XCTAssertNil(author!.url)
    }

    func testDictionaryShouldReturnAvatar() {
        // given:
        let payload = """
            { "avatar": "https://example.org/avatar.png" }
        """

        // when:
        let author = decode(Author.self, from: payload)

        // then:
        XCTAssertNotNil(author)

        XCTAssertNotNil(author!.avatar)
        XCTAssertEqual(author!.avatar!, URL(string: "https://example.org/avatar.png")!)

        XCTAssertNil(author!.name)
        XCTAssertNil(author!.url)
    }

    func testDictionaryShouldReturnURL() {
        // given:
        let payload = """
            { "url": "https://example.org/owner" }
        """

        // when:
        let author = decode(Author.self, from: payload)

        // then:
        XCTAssertNotNil(author)

        XCTAssertNotNil(author!.url)
        XCTAssertEqual(author!.url!, URL(string: "https://example.org/owner")!)

        XCTAssertNil(author!.name)
        XCTAssertNil(author!.avatar)
    }

    func testDictionaryShoulwReturnAll() {
        // given:
        let payload = """
            { "name": "Jon Snow", "avatar": "https://example.org/avatar.png", "url": "https://example.org/owner" }
        """

        // when:
        let author = decode(Author.self, from: payload)

        // then:
        XCTAssertNotNil(author)

        XCTAssertNotNil(author!.name)
        XCTAssertEqual(author!.name!, "Jon Snow")

        XCTAssertNotNil(author!.url)
        XCTAssertEqual(author!.url!, URL(string: "https://example.org/owner")!)

        XCTAssertNotNil(author!.avatar)
        XCTAssertEqual(author!.avatar!, URL(string: "https://example.org/avatar.png")!)
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
