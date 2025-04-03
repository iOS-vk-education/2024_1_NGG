//
//  MovieListInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

final class MovieListInteractor: MovieListBusinessLogic {
    var presenter: MovieListPresenterInput!
    var networkService: MovieListNetworkServiceProtocol

    init(networkService: MovieListNetworkServiceProtocol) {
            self.networkService = networkService
        }

    func getMovies() async {
        do {
            let movies = try await networkService.fetchMovies()
            await MainActor.run {
                presenter?.didFetchMoviewSuccess(with: movies)
            }
        } catch {
            print("[DEBUG]: \(error)")
            await MainActor.run {
                presenter?.didFetchMoviewFailure(with: error)
            }
        }
    }
}
