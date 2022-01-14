//
//  Singleton.swift
//  Consult Repos
//
//  Created by Carlos Bernardino on 14/01/2022.
//

import UIKit

class Singleton{
    static let sharedInstance = Singleton()
    var repos = [Repos]()
}
