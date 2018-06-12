//
//  Item.swift
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


public struct Item {

    /// id (required, string) is unique for that item for that feed over time. If an item is ever updated, the id should be unchanged. New items should never use a previously-used id. If an id is presented as a number or other type, a JSON Feed reader must coerce it to a string. Ideally, the id is the full URL of the resource described by the item, since URLs make great unique identifiers.
    public let id: String

    /// url (optional, string) is the URL of the resource described by the item. It’s the permalink. This may be the same as the id — but should be present regardless.
    public let url: URL?

    /// external_url (very optional, string) is the URL of a page elsewhere. This is especially useful for linkblogs. If url links to where you’re talking about a thing, then external_url links to the thing you’re talking about.
    public let external: URL?

    /// title (optional, string) is plain text. Microblog items in particular may omit titles.
    public let title: String?

    /// content_html and content_text are each optional strings — but one or both must be present. This is the HTML or plain text of the item. Important: the only place HTML is allowed in this format is in content_html. A Twitter-like service might use content_text, while a blog might use content_html. Use whichever makes sense for your resource. (It doesn’t even have to be the same for each item in a feed.)

    /// summary (optional, string) is a plain text sentence or two describing the item. This might be presented in a timeline, for instance, where a detail view would display all of content_html or content_text.
    public let summary: String?

    /// image (optional, string) is the URL of the main image for the item. This image may also appear in the content_html — if so, it’s a hint to the feed reader that this is the main, featured image. Feed readers may use the image as a preview (probably resized as a thumbnail and placed in a timeline).
    public let image: URL?

    /// banner_image (optional, string) is the URL of an image to use as a banner. Some blogging systems (such as Medium) display a different banner image chosen to go with each post, but that image wouldn’t otherwise appear in the content_html. A feed reader with a detail view may choose to show this banner image at the top of the detail view, possibly with the title overlaid.
    public let banner: URL?

    /// date_published (optional, string) specifies the date in RFC 3339 format. (Example: 2010-02-07T14:04:00-05:00.)
    public let published: Date?

    /// date_modified (optional, string) specifies the modification date in RFC 3339 format.
    public let modified: Date?

    /// author (optional, object) has the same structure as the top-level author. If not specified in an item, then the top-level author, if present, is the author of the item.
    public let author: Author?

    /// tags (optional, array of strings) can have any plain text values you want. Tags tend to be just one word, but they may be anything. Note: they are not the equivalent of Twitter hashtags. Some blogging systems and other feed formats call these categories.
    public let tags: [String]?

}


extension Item {

    private enum Keys: String, CodingKey {
        case id
        case url
        case external = "external_url"
        case title
        case summary
        case image
        case banner = "banner_image"
        case published = "date_published"
        case modified = "date_modified"
        case author
        case tags
    }

}


extension Item: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        id = try container.decode(String.self, forKey: .id)

        url = try container.decodeIfPresent(URL.self, forKey: .url)
        external = try container.decodeIfPresent(URL.self, forKey: .external)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)
        image = try container.decodeIfPresent(URL.self, forKey: .image)
        banner = try container.decodeIfPresent(URL.self, forKey: .banner)

        published = try container.decodeIfPresent(Date.self, forKey: .published)
        modified = try container.decodeIfPresent(Date.self, forKey: .modified)

        author = try container.decodeIfPresent(Author.self, forKey: .author)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
    }

}
