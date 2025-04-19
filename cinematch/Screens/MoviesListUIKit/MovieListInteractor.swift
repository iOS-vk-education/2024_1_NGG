//
//  MovieListInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

final class MovieListInteractor: MovieListBusinessLogic {
    var presenter: MovieListPresenterInput!
    var networkService: MovieListNetworkProtocol

    init(networkService: MovieListNetworkProtocol) {
            self.networkService = networkService
        }

    func getMovies(genres: [String], directors: [Int], page: Int) async {
        do {
            let movies = try await networkService.fetchMovies(genres: genres, directors: directors, page: page)

            let moviesCard = await transformMoviesToCards(movies)

            await MainActor.run {
                presenter?.didFetchMoviesSuccess(with: moviesCard)
            }
        } catch {
            await MainActor.run {
                presenter?.didFetchMoviesFailure(with: error)
            }
        }
    }

    func transformMoviesToCards(_ movies: MoviesResponseModel) async -> [MovieCard] {
        var movieCards: [MovieCard] = []

        for movie in movies.docs {
            let posterUrlString = movie.poster.url
            let genreString = movie.genres.map { $0.name }.joined(separator: ", ")

            let imageData = await networkService.fetchImageData(from: posterUrlString)

            let card = MovieCard(
                id: movie.id,
                title: movie.name,
                genre: genreString,
                type: movie.type,
                year: movie.year,
                mainImage: imageData
            )
            movieCards.append(card)
        }

        return movieCards
    }

    func getDescriptionMovie(movieId: Int) async {
        do {
            let movie = try await networkService.fetchMovieDescription(id: movieId)

            await MainActor.run {
                presenter?.didFetchMovieDescriptionSuccess(with: movie)
            }
        } catch {
            await MainActor.run {
                presenter?.didFetchMovieDescriptionFailure(with: error)
            }
        }
    }
}
