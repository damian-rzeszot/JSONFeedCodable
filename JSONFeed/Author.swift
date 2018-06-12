//
//  Author.swift
//  JSONFeed
//
//  Copyright (c) 2018 Damian Rzeszot <damian.rzeszot@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation


public struct Author {

    /// name (optional, string) is the author’s name.
    public let name: String?

    /// url (optional, string) is the URL of a site owned by the author. It could be a blog, micro-blog, Twitter account, and so on. Ideally the linked-to page provides a way to contact the author, but that’s not required. The URL could be a mailto: link, though we suspect that will be rare.
    public let url: URL?

    /// avatar (optional, string) is the URL for an image for the author. As with icon, it should be square and relatively large — such as 512 x 512 — and should use transparency where appropriate, since it may be rendered on a non-white background.
    public let avatar: URL?

}


extension Author {

    private enum Keys: String, CodingKey {
        case name
        case url
        case avatar
    }

    public enum Error: Swift.Error {
        case oneMemberRequired
    }

}


extension Author: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        avatar = try container.decodeIfPresent(URL.self, forKey: .avatar)

        if name == nil && url == nil && avatar == nil {
            throw Error.oneMemberRequired
        }
    }

}
