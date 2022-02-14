//
//  MovieFront.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/12.
//

import Foundation

// Model for Discover and Chart View Models
struct MovieFront {
    let id: Int
    let title: String
    let posterPath: String
    
    let genre: String
    let releaseDate: String
    let ratingScore: Double
    let ratingCount: Int
}


extension MovieFront{
    static func convertFromMovieInfo(movie: MovieListResult) -> MovieFront {
        return MovieFront(id: movie.id, title: movie.title, posterPath: "https://image.tmdb.org/t/p/original/\(movie.posterPath)", genre: genreCode[movie.genreIDS[0]] ?? "", releaseDate: movie.releaseDate, ratingScore: movie.voteAverage, ratingCount: movie.voteCount)
    }
}
