//
//  File.swift
//  p3OC
//
//  Created by Merouane Bellaha on 18/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension String {
    /// remove white spaces before the first characters and after the last characters, of the String.
    var trimWhiteSpaces: String {
        return capitalized.trimmingCharacters(in: .whitespaces)
    }
}
