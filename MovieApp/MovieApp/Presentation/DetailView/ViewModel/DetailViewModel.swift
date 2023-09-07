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
    
    let movieDetailData = BehaviorRelay<MovieDetail?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(contentId: Int) {
        self.requestData(contentId: contentId)
    }
    
    func requestData(contentId: Int) {
        let url = APIService.configureUrlString(id: contentId, language: .English)
        APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> MovieDetail in
                
                let response = try! JSONDecoder().decode(MovieDetail.self, from: data)
                return response
            }
            .take(1)
            .bind(to: movieDetailData)
            .disposed(by: disposeBag)
    }
                        
}
    

