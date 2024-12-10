//
//  OnboardingViewModel.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 20/10/24.
//

import Foundation

class OnboardingViewModel {
    
    var countries : [String] = []
    var countryCodes : [String] = []
    var selectedIndex: Int?

    func fetchCountries(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://api.first.org/data/v1/countries") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let countryData = json["data"] as? [String: [String: String]] {
                    
                    self.countries = countryData.values.compactMap { $0["country"] }
                    self.countryCodes = countryData.keys.compactMap { $0 }
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print("Failed to load countries: \(error)")
                completion(false)
            }
        }
        task.resume()
    }
    
    func setDefaultCountryFromIP(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://ip-api.com/json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let countryCode = json["countryCode"] as? String {
                    
                    
                        if let index = self.countryCodes.firstIndex(of: countryCode) {
                            self.selectedIndex = index
                        }
                        completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print("Failed to get country from IP: \(error)")
                completion(false)
            }
        }
        task.resume()
    }
}
