//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/11/22.
//

import Foundation

extension APIService {
    
    /// Movie list
    static func configureUrlString(category: MovieListCategory, language: Language, page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(category.key)?api_key=\(APIKey)&language=\(language.key)&page=\(page)"
    }
    
    /// Movie detail
    static func configureUrlString(id: Int, language: Language) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)?api_key=\(APIKey)&language=\(language)"
    }
    
    /// Imagepath
    static func configureUrlString(imagePath: String?) -> String? {
        guard let imagePath else { return nil }
        return "https://image.tmdb.org/t/p/original/\(imagePath)"
    }
    
    /// Keyword search
    static func configureUrlString(keyword: String, language: Language, page: Int) -> String {
        return "https://api.themoviedb.org/3/search/movie?query=\(keyword)&api_key=\(APIKey)&language=\(language.key)&page=\(page)"
    }

}

// MARK: - Enumerations for API url configuration
enum MovieListCategory {
    case popular, upcomming, topRated, nowPlaying
    
    var key: String {
        switch self {
        case .popular: return "popular"
        case .upcomming: return "upcomming"
        case .topRated: return "top_rated"
        case .nowPlaying: return "now_playing"
        }
    }
    
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .upcomming: return "Upcomming"
        case .topRated: return "Top Rated"
        case .nowPlaying: return "Now Playing"
        }
    }
}

enum Language {
    case korean, english
    
    var key: String {
        switch self {
        case .korean: return "ko-KR"
        case .english: return "en-US"
        }
    }
}
