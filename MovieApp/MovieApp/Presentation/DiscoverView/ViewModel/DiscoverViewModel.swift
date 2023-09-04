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
    
    var movieListData = BehaviorRelay<[DiscoverCollectionViewSection]>(value: [])
    private var disposeBag = DisposeBag()
        
    func requestData(page: Int) {
        let url = APIService.configureUrlString(category: .NowPlaying, language: .English, page: page)
        APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                guard let response = try? JSONDecoder().decode(MovieList.self, from: data) else { return [] }
                return response.results
            }.map({ movieList in
                let items = movieList.map { DiscoverCollectionViewItem(movie: MovieFront.convertFromMovieInfo(movie: $0))}
                return [DiscoverCollectionViewSection(items: items)]
            })
            .take(1)
            .bind(to: movieListData)
            .disposed(by: disposeBag)
    }
    
    func requestData(keyword: String, page: Int) {
        
        if keyword.count == 0 {
            self.requestData(page: 1)
            return
        }
        
        let url = APIService.configureUrlString(keyword: keyword, language: .English, page: page)
        APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                return response.results
            }.map({ movieList in
                let items = movieList.map { DiscoverCollectionViewItem(movie: MovieFront.convertFromMovieInfo(movie: $0))}
                return [DiscoverCollectionViewSection(items: items)]
            })
            .take(1)
            .bind(to: movieListData)
            .disposed(by: disposeBag)
    }
    

}
