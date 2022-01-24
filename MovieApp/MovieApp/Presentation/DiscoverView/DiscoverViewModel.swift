//
//  DiscoverViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/14.
//

import Foundation
import RxSwift


class DiscoverViewModel {
    
    let movieFrontObservable = BehaviorSubject<[MovieFront]>(value: [])

    init () {
        
    }
    
    func requestData() {
        let url = APIService.configureUrlString(category: .NowPlaying, language: .English, page: 1)
        _ = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                
                return response.results
            }.map { return $0.map { return MovieFront.convertFromMovieInfo(movie: $0) } }
            .take(1)
            .debug()
            .bind(to: movieFrontObservable)
    }
    

}
