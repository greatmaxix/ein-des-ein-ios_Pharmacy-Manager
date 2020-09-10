//
//  String+URL.swift
//  KyivPost
//
//  Created by Anton Bal’ on 27.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

extension String {
    var url: URL? {
        guard let url = try? self.asURL() else {
            let urlAllowed = CharacterSet.urlFragmentAllowed
                .union(.urlHostAllowed)
                .union(.urlPasswordAllowed)
                .union(.urlQueryAllowed)
                .union(.urlUserAllowed)
            
            return URL(string: addingPercentEncoding(withAllowedCharacters: urlAllowed) ?? "")
        }
        return url
    }
}
