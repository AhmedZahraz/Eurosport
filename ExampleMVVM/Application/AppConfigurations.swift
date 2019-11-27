//
//  AppConfigurations.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 25.02.19.
//

import Foundation

class AppConfigurations {
    lazy var apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as! String
}
