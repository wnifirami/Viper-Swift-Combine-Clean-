//
//  ApiKeys.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import UIKit
struct ParsePlist {
    static func valueForAPIKey(named keyname: String) -> String {
      let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") ?? ""
      let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: keyname) as? String else {
            fatalError("No api key provided")
        }
      return value
    }
}






