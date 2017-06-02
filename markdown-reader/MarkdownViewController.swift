//
//  MarkdownViewController.swift
//  markdown-reader
//
//  Created by Masaya Hayashi on 2017/06/02.
//  Copyright © 2017年 Masaya Hayashi. All rights reserved.
//

import UIKit

class MarkdownViewController: UIViewController {

    // - Properties

    var content: String = ""

    // - UI

    @IBOutlet private weak var mdTextView: UITextView!

    // - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mdTextView.text = content
    }

    func set(title: String, content: String) {
        self.title = title.headerWithoutPrefix()
        self.content = content
    }
}
