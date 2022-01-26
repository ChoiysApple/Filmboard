//
//  DiscoverViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/14.
//

import Foundation
import RxSwift


class DiscoverViewModel {
    
    var movieFrontObservable = BehaviorSubject<[DiscoverCollectionViewSection]>(value: [])
    let dataSource = DiscoverCollectionViewDataSource.dataSource()
    
    func requestData() {
        let url = APIService.configureUrlString(category: .NowPlaying, language: .English, page: 1)
        _ = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                return response.results
            }.map({ movieList in
                let items = movieList.map { DiscoverCollectionViewItem(movie: MovieFront.convertFromMovieInfo(movie: $0))}
                return [DiscoverCollectionViewSection(items: items)]
            })
            .take(1)
            .bind(to: movieFrontObservable)
    }
    

}
