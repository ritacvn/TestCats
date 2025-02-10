//
//  SecretsManager.swift
//  CatsTest
//
//  Created by Rita Vasconcelos on 10/02/25.
//
import Foundation

class SecretsManager {
    static func getAPIKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let apiKey = dict["API_KEY"] as? String else {
            return nil
        }
        return apiKey
    }
}
