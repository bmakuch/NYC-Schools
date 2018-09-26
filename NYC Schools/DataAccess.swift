//
//  DataAccess.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import Foundation

enum DataAccessError: Error {
    case noResults
}



class DataAccess {
    
    static func getSchools(completion: ((DataResult<[NYCSchoolSummary]>) -> Void)?) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "/resource/97mf-9njv.json"
        let selectItem = URLQueryItem(name: "$select", value: "dbn,school_name,neighborhood")
        let orderItem = URLQueryItem(name: "$order", value: "school_name")
        urlComponents.queryItems = [selectItem, orderItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let schools = try decoder.decode([NYCSchoolSummary].self, from: jsonData)
                        completion?(.success(schools))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "DataAccess", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not retrieve data"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }

    static func getSchoolInfo(for id: String, completion: ((DataResult<NYCSchoolDetail>) -> Void)?) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "/resource/97mf-9njv.json"
        let selectItem = URLQueryItem(name: "$select", value: "dbn,school_name,neighborhood,overview_paragraph")
        let whereItem = URLQueryItem(name: "dbn", value: id)
        urlComponents.queryItems = [selectItem, whereItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let schools = try decoder.decode([NYCSchoolDetail].self, from: jsonData)
                        if (schools.count > 0) {
                            completion?(.success(schools.first!))
                        } else {
                            completion?(.failure(DataAccessError.noResults))
                        }
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "DataAccess", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not retrieve data"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    static func get2012SATResults(for id: String, completion: ((DataResult<NYCSchoolSATResults>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "/resource/734v-jeq5.json"
        let dbnItem = URLQueryItem(name: "dbn", value: id)
        urlComponents.queryItems = [dbnItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let scores = try decoder.decode([NYCSchoolSATResults].self, from: jsonData)
                        if (scores.count > 0) {
                            completion?(.success(scores.first!))
                        } else {
                            completion?(.failure(DataAccessError.noResults))
                        }
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "DataAccess", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not retrieve data"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
}
