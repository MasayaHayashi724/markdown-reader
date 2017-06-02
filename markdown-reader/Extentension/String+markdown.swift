//
//  String+markdown.swift
//  markdown-reader
//
//  Created by Masaya Hayashi on 2017/06/02.
//  Copyright © 2017年 Masaya Hayashi. All rights reserved.
//

import Foundation

extension String {
    func hasHeaderPrefix() -> Bool {
        let lineArray = self.components(separatedBy: " ")
        guard let prefix = lineArray.first else { return false }
        switch prefix {
        case HeaderPrefix.first.rawValue: return true
        case HeaderPrefix.second.rawValue: return true
        case HeaderPrefix.third.rawValue: return true
        case HeaderPrefix.fourth.rawValue: return true
        case HeaderPrefix.fifth.rawValue: return true
        default: return false
        }
    }
}
