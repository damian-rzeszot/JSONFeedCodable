//
//  FeedViewController.swift
//  Example
//
//  Created by Damian Rzeszot on 12/06/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit
import JSONFeed


class FeedViewController: UITableViewController {

    var url: URL!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let session = URLSession.shared
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let feed = try decoder.decode(Feed.self, from: data)
                print("ok \(feed)")
            } catch {
                print("error \(error)")
            }

        }

        task.resume()
    }

}
