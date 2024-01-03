//
//  APIService.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/11.
//

import Foundation
import RxSwift

class APIService {
    
    static func fetchRequest(url: String, retries: Int, onComplete: @escaping (Result<Data, Error>) -> Void) {
        
        guard let urlString = URL(string: url) else {
            print("Error: invalid url")
            return
        }
        
        let task = URLSession(configuration: .default).dataTask(with: urlString) { (data, response, error) in
            
            print("[Request] \(urlString.absoluteString)")
            if let error = error {
                print("Error: \(error.localizedDescription)")
                onComplete(.failure(error))
                return
            }
            
            guard let safeData = data else {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("Error: no data")
                onComplete(.failure(NSError(domain: "no data", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            onComplete(.success(safeData))
            
        }
        task.resume()
    }
    
    static func fetchWithRx(url: String, retries: Int) -> Observable<Data> {
        return Observable.create { emitter in
            
            fetchRequest(url: url, retries: retries) { result in
                print("---------------------------\n[Response] \(url)")
                switch result {
                case .success(let data):
                    print("Success \(String(decoding: data, as: UTF8.self))")
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

extension String {
    var fullImagePath: String {
        return "https://image.tmdb.org/t/p/original/\(self)"
    }
}
