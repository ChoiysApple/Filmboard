//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class DetailViewModel {
    
    let movieDetailObservable = BehaviorRelay<MovieDetail?>(value: nil)

    
    init(contentId: Int) {
        self.requestData(contentId: contentId)
    }
    
    func requestData(contentId: Int) {
        let url = APIService.configureUrlString(id: contentId, language: .English)
        _ = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> MovieDetail in
                
                let response = try! JSONDecoder().decode(MovieDetail.self, from: data)
                return response
            }
            .take(1)
            .bind(to: movieDetailObservable)
    }

                                                 
}
    

