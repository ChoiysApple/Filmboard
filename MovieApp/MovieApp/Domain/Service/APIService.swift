//
//  APIService.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/11.
//

import Foundation
import RxSwift

class APIService {
    
    let session = URLSession(configuration: .default)
    
    func fetchData() {
        
        var completeURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(APIKey)&language=en-US&page=1"
        let retryLimit = 2
        
        performRequest(url: completeURL, retries: retryLimit)
    }
    
    private func performRequest(url: String, retries: Int) {
        
        guard let Url = URL(string: url) else { return }
        
        let task = session.dataTask(with: Url) { [self] (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let safeData = data else { return }
            
            // Decode JSON
            do{
                let result = try JSONDecoder().decode(MovieList.self, from: safeData)
                //TODO: Task
            } catch {
                print(error)
                if retries > 0 {
                    print("\(retries) retries remaining. RETRYING VIA RECURSIVE CALL.")
                    performRequest(url: url, retries: retries-1)
                } else {
                    print("\(retries) retries remaining. EXIT WITH FAILURE.")
                    return
                }
                                
            }

        }
        
        task.resume()
    }
}


