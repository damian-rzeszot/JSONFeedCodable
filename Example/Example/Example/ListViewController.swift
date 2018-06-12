//
//  ListViewController.swift
//  Example
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit
import JSONFeed


class ListViewController: UITableViewController {


    // MARK: -

    var feeds: [URL] = [
        URL(string: "https://soffes.blog/feeds/json")!
    ]


    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = feeds[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = feed.absoluteString
        return cell
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let cell = sender as? UITableViewCell else { return }
        guard let path = tableView.indexPath(for: cell) else { return }
        guard let destination = segue.destination as? FeedViewController else { return }

        let feed = feeds[path.row]

        destination.url = feed
    }

}
