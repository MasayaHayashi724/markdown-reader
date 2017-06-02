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

    @IBOutlet weak var mdWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // - View Life Cycle

    override func viewDidLoad() {
        self.activityIndicator.startAnimating()
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "md", withExtension: "html") else { return }
        let req = URLRequest(url: url)
        self.mdWebView.loadRequest(req)
    }

    func set(title: String, content: String) {
        self.title = title.headerWithoutPrefix()
        self.content = content
    }
}

extension MarkdownViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let js = "insert('\(content)');"
        self.mdWebView.stringByEvaluatingJavaScript(from: js)
        self.activityIndicator.stopAnimating()
    }
}
