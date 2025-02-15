//
//  NetworkManager.swift
//  MobileDevProject
//
//  Created by Baptiste Keunebroek on 22/01/2024.
//

import Foundation



struct NetworkManager {
    var apiKey: String {
            ProcessInfo.processInfo.environment["AIRTABLE_API_KEY"] ?? "DefaultAPIKey"
        }
    let baseId = "apps3Rtl22fQOI9Ph"
    let tableId = "tbl5Ti8iSeVNkebs7"
    
    func fetchTalks(completion: @escaping ([Fields]) -> Void) {
        
        let urlString = "https://api.airtable.com/v0/\(baseId)/\(tableId)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        let authValue = "Bearer \(apiKey)"
            request.setValue(authValue, forHTTPHeaderField: "Authorization")

        print("Request URL: \(url.absoluteString)")
           print("Authorization Header: \(authValue)")
           print("All Headers: \(request.allHTTPHeaderFields ?? [:])")

        

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            
            if let json = String(data: data, encoding: .utf8) {
                print("JSON String: \(json)")
            }

            do {
                let decodedData = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData.records.map { $0.fields })
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }




}

