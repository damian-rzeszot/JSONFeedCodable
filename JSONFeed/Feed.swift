//
//  Feed.swift
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


public struct Feed {

    /// version (required, string) is the URL of the version of the format the feed uses. This should appear at the very top, though we recognize that not all JSON generators allow for ordering.
    public let version: URL

    /// title (required, string) is the name of the feed, which will often correspond to the name of the website (blog, for instance), though not necessarily.
    public let title: String

    /// home_page_url (optional but strongly recommended, string) is the URL of the resource that the feed describes. This resource may or may not actually be a “home” page, but it should be an HTML page. If a feed is published on the public web, this should be considered as required. But it may not make sense in the case of a file created on a desktop computer, when that file is not shared or is shared only privately.
    public let homepage: URL?

    /// feed_url (optional but strongly recommended, string) is the URL of the feed, and serves as the unique identifier for the feed. As with home_page_url, this should be considered required for feeds on the public web.
    public let feed: URL?

    /// description (optional, string) provides more detail, beyond the title, on what the feed is about. A feed reader may display this text.
    public let description: String?

    /// next_url (optional, string) is the URL of a feed that provides the next n items, where n is determined by the publisher. This allows for pagination, but with the expectation that reader software is not required to use it and probably won’t use it very often. next_url must not be the same as feed_url, and it must not be the same as a previous next_url (to avoid infinite loops).
    public let next: URL?

    /// icon (optional, string) is the URL of an image for the feed suitable to be used in a timeline, much the way an avatar might be used. It should be square and relatively large — such as 512 x 512 — so that it can be scaled-down and so that it can look good on retina displays. It should use transparency where appropriate, since it may be rendered on a non-white background.
    public let icon: URL?

    /// favicon (optional, string) is the URL of an image for the feed suitable to be used in a source list. It should be square and relatively small, but not smaller than 64 x 64 (so that it can look good on retina displays). As with icon, this image should use transparency where appropriate, since it may be rendered on a non-white background.
    public let favicon: URL?

    /// author (optional, object) specifies the feed author. The author object has several members. These are all optional — but if you provide an author object, then at least one is required:
    public let author: Author?

    /// expired (optional, boolean) says whether or not the feed is finished — that is, whether or not it will ever update again. A feed for a temporary event, such as an instance of the Olympics, could expire. If the value is true, then it’s expired. Any other value, or the absence of expired, means the feed may continue to update.
    public let expired: Bool?

    /// hubs (very optional, array of objects) describes endpoints that can be used to subscribe to real-time notifications from the publisher of this feed. Each object has a type and url, both of which are required. See the section “Subscribing to Real-time Notifications” below for details.
    // not supported yed


    public let items: [Item]
}


extension Feed {

    private enum Keys: String, CodingKey {
        case version
        case title
        case description
        case author
        case homepage = "home_page_url"
        case feed = "feed_url"
        case next = "next_url"
        case icon
        case favicon
        case expired
        case items
    }

}



extension Feed: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        version = try container.decode(URL.self, forKey: .version)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        author = try container.decodeIfPresent(Author.self, forKey: .author)

        homepage = try container.decodeIfPresent(URL.self, forKey: .homepage)
        feed = try container.decodeIfPresent(URL.self, forKey: .feed)
        next = try container.decodeIfPresent(URL.self, forKey: .next)

        icon = try container.decodeIfPresent(URL.self, forKey: .icon)
        favicon = try container.decodeIfPresent(URL.self, forKey: .favicon)

        expired = try container.decodeIfPresent(Bool.self, forKey: .expired)

        items = try container.decode([Item].self, forKey: .items)
    }

}
