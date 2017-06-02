//
//  ViewController+TableView.swift
//  markdown-reader
//
//  Created by Masaya Hayashi on 2017/06/02.
//  Copyright © 2017年 Masaya Hayashi. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = headers[indexPath.row]
        return cell
    }
}
