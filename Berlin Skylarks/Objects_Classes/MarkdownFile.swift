//
//  MarkdownFile.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 17.12.22.
//

import Foundation

struct MarkdownFile: ExpressibleByStringLiteral {
    
    let bundleName: String
    let rawMarkdown: String?
    
    init(stringLiteral: String) {
        
        bundleName = stringLiteral
        
        var loadedMarkdown: String? = nil
                
        if let filepath = Bundle.main.path(forResource: bundleName, ofType: nil) {
        //By skipping the ofType argument above, we'll match to the first file whose name
        //exactly matches bundleName
            do {
                let loadedString = try String(contentsOfFile: filepath)
                loadedMarkdown = loadedString
            } catch {
                print("Could not load string: \(error)")
            }
        } else {
            print("Could not find file: \(bundleName)")
        }
        
        rawMarkdown = loadedMarkdown
    }
}
