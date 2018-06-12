//
//  JSONDecoder+String.swift
//  JSONFeedTests
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation


extension JSONDecoder {

    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        return try decode(type, from: string.data(using: .utf8)!)
    }

}
