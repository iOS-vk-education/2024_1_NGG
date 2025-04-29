//
//  MovieListInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class MovieListInteractor: MovieListBusinessLogic {
    var presenter: MovieListPresenterInput!
    var networkService: MovieListNetworkProtocol

    init(networkService: MovieListNetworkProtocol) {
        self.networkService = networkService
    }

    func getMovies(genres: [String], directors: [Int], page: Int) async {
        do {
            let (genres, directors) = try await fetchUserPreference()
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

    private func fetchUserPreference() async throws -> ([String], [Int]) {
        guard let uid = Auth.auth().currentUser?.uid else { return ([], []) }

        let userDoc = try await Firestore.firestore().collection("users").document(uid).getDocument()
        guard let data = userDoc.data() else { return ([], []) }

        let genres = data["genres"] as? [String] ?? []
        let directorsRaw = data["directors"] as? [[String: Any]] ?? []

        let directors = directorsRaw.compactMap { $0["id"] as? Int }
        let directorNames = directorsRaw.compactMap { $0["name"] as? String }

        UserDefaults.standard.set(directorNames, forKey: "selectedDirectors")
        UserDefaults.standard.set(genres, forKey: "selectedGenres")

        return (genres, directors)
    }

    func transformMoviesToCards(_ movies: MoviesResponseModel) async -> [MovieCard] {
        var movieCards: [MovieCard] = []
        movieCards.reserveCapacity(movies.docs.count)

        for movie in movies.docs {
            let posterUrlString = movie.poster.url
            let genreString = movie.genres.map { $0.name }.joined(separator: ", ")

            let imageData = (try? await networkService.fetchImageData(from: posterUrlString)) ?? Data()

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
