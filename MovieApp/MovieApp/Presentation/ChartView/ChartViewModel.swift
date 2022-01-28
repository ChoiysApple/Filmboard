//
//  ChartViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/14.
//

import Foundation
import RxSwift

class ChartViewModel {
    
    let movieFrontObservable = BehaviorSubject<[MovieFront]>(value: [])
    
    func requestData(category: MovieListCategory) {
        let url = APIService.configureUrlString(category: category, language: .English, page: 1)
        _ = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                
                return response.results
            }.map { return $0.map { return MovieFront.convertFromMovieInfo(movie: $0) } }
            .take(1)
            .bind(to: movieFrontObservable)
    }

}
