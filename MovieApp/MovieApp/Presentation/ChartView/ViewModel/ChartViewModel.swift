//
//  ChartViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/14.
//

import Foundation
import RxSwift
import RxRelay

class ChartViewModel {
    
    let movieListData = BehaviorRelay<[MovieFront]>(value: [])
    let listTitle = BehaviorSubject<String>(value: MovieListCategory.Popular.title)
    
    var currentPage = 1
    var currentCategory = MovieListCategory.Popular
    var existingData: [MovieFront] = []
    
    func requestData() {
        self.requestData(category: self.currentCategory)
    }
    
    func requestData(category: MovieListCategory) {
        
        if currentCategory != category { currentPage = 1 }
        currentCategory = category
        fetchData(category: category)
        
        currentPage += 1
    }
    
    func refreshData() {
        currentPage = 1
        fetchData(category: currentCategory)
    }
    
    func fetchData(category: MovieListCategory) {
        
        let url = APIService.configureUrlString(category: category, language: .English, page: currentPage)
        let data = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                
                self.listTitle.onNext(category.title)
                
                return response.results
            }.map { return $0.map { return MovieFront.convertFromMovieInfo(movie: $0) } }
            .take(1)
            .bind(to: movieListData)
    }

}
