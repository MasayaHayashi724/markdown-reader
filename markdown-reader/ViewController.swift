//
//  ViewController.swift
//  markdown-reader
//
//  Created by Masaya Hayashi on 2017/06/01.
//  Copyright © 2017年 Masaya Hayashi. All rights reserved.
//

import UIKit

enum HeaderPrefix: String {
    case first = "#"
    case second = "##"
    case third = "###"
    case fourth = "####"
    case fifth = "#####"
}

class ViewController: UIViewController {

    // - UI

    @IBOutlet private weak var headerTableView: UITableView!

    // - Properties

    var fullContent: [String] = []
    var headers: [String] = [] {
        didSet {
            self.headerTableView.reloadData()
        }
    }

    // - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getContent()
    }

    private func getContent() {
        guard let path: String = Bundle.main.path(forResource: "portfolio", ofType: "md") else { fatalError("No file named portfolio.md") }
        do {
            let fullContent = try String(contentsOfFile: path)
            self.fullContent = fullContent.components(separatedBy: .newlines)
            self.headers = self.fullContent.filter { $0.hasHeaderPrefix() }
        } catch {
            print("Failed to get content of file")
        }
    }
}

