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
        guard let prefix = headers[indexPath.row].components(separatedBy: " ").first else { fatalError("Invalid prefix") }
        guard let header = headers[indexPath.row].headerWithoutPrefix() else { fatalError("Invalid header") }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let indent = createIndent(for: prefix.characters.count)
        cell.textLabel?.text = indent + header
        return cell
    }

    private func createIndent(for level: Int) -> String {
        var indent = ""
        for i in 1..<level {
            if i == 1 {
                indent = "-- " + indent
            } else {
                indent = "   " + indent
            }
        }
        return indent
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sb = self.storyboard else { return }
        guard let content = getContent(in: headers[indexPath.row]) else { return }
        let vc = sb.instantiateViewController(withIdentifier: "MarkdownViewController") as! MarkdownViewController
        vc.set(title: headers[indexPath.row], content: content)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func getNextLineNumber(to line: String) -> Int? {
        guard let prefix = line.components(separatedBy: " ").first else { return nil }
        guard let headerPrefix = HeaderPrefix(rawValue: prefix) else { return nil }
        guard let firstIndex = fullContent.index(of: line) else { return nil }
        for i in (firstIndex + 1)..<fullContent.count {
            if fullContent[i].hasHeaderPrefix(of: headerPrefix) { return i }
            if fullContent[i].hasHeaderPrefix(upperThan: headerPrefix) { return i }
        }
        return fullContent.count - 1
    }

    private func getContent(in header: String) -> String? {
        guard let startIndex = fullContent.index(of: header) else { return nil }
        guard let endIndex = getNextLineNumber(to: header) else { return nil }
        var contentArray: [String] = []
        for i in startIndex..<endIndex {
            contentArray.append(fullContent[i])
        }
        return contentArray.joined(separator: "\\n")
    }
}
