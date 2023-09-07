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
    
    var movieListData = BehaviorRelay<[MovieFront]>(value: [])
    private var disposeBag = DisposeBag()
        
    func requestData(page: Int) {
        let url = APIService.configureUrlString(category: .NowPlaying, language: .English, page: page)
        APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieFront] in
                guard let response = try? JSONDecoder().decode(MovieList.self, from: data) else { return [] }
                return response.results.map { MovieFront.convertFromMovieInfo(movie: $0) }
            }
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
            .map { data -> [MovieFront] in
                guard let response = try? JSONDecoder().decode(MovieList.self, from: data) else { return [] }
                return response.results.map { MovieFront.convertFromMovieInfo(movie: $0) }
            }
            .take(1)
            .bind(to: movieListData)
            .disposed(by: disposeBag)
    }
    

}
