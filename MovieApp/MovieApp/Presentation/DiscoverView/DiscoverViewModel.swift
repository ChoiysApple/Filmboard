//
//  DiscoverViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/14.
//

import Foundation
import RxSwift
import RxRelay


class DiscoverViewModel {
    
    static let shared = DiscoverViewModel()
    
    var movieFrontObservable = BehaviorRelay<[DiscoverCollectionViewSection]>(value: [])
    let dataSource = DiscoverCollectionViewDataSource.dataSource()
    
    func requestData(page: Int) {
        let url = APIService.configureUrlString(category: .NowPlaying, language: .English, page: page)
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
    
    func requestData(keyword: String, page: Int) {
        
        if keyword.count == 0 {
            self.requestData(page: 1)
            return
        }
        
        let url = APIService.configureUrlString(keyword: keyword, language: .English, page: page)
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
