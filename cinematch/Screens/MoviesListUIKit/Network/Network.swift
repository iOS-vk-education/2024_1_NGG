//
//  Network.swift
//  cinematch
//
//  Created by Ксения Панкратова on 06.04.2025.
//

import Foundation
import Combine

protocol MovieListNetworkProtocol {
    func fetchMovies(genres: [String], directors: [Int], page: Int) async throws -> MoviesResponseModel
    func fetchMovieDescription(id: Int) async throws -> MovieDescription
    func fetchImageData(from urlString: String) async throws -> Data

    func fetchAllGenresPublisher() -> AnyPublisher<[GenreResponse], Error>
}

final class Network: MovieListNetworkProtocol {
    private func sendRequest<T: Decodable>(
        service: MovieService,
        response: T.Type
    ) async throws  -> T {
        guard var components = URLComponents(string: service.baseUrl + service.path) else {
            throw NetworkError.invalidUrl
        }

        if let parameters = service.parameters {
            components.queryItems = parameters.flatMap { key, value -> [URLQueryItem] in
                if let array = value as? [Any] {
                    return array.map { URLQueryItem(name: key, value: "\($0)") }
                } else {
                    return [URLQueryItem(name: key, value: "\(value)")]
                }
            }
        }

        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = service.method
        request.allHTTPHeaderFields = service.header

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }

    func fetchMovies(genres: [String], directors: [Int], page: Int) async throws -> MoviesResponseModel {
        return try await sendRequest(service: .recMovies(genres: genres, directors: directors, page: page), response: MoviesResponseModel.self)
    }

    func fetchMovieDescription(id: Int) async throws -> MovieDescription {
        return try await sendRequest(service: .descriptionMovie(id: id), response: MovieDescription.self)
    }

    func fetchImageData(from urlString: String) async throws -> Data {
        guard
            let url = URL(string: urlString.trimmingCharacters(in: .whitespacesAndNewlines)),
            !urlString.isEmpty
        else {
            throw ImageFetchError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw ImageFetchError.networkError(error)
        }
    }
}

extension Network {
    private func sendRequest<T: Decodable>(
        service: MovieService,
        response: T.Type
    ) -> AnyPublisher<T, Error> {
        guard var components = URLComponents(string: service.baseUrl + service.path) else {
            return Fail(error: NetworkError.invalidUrl)
                .eraseToAnyPublisher()
        }

        if let parameters = service.parameters {
            components.queryItems = parameters.flatMap { key, value -> [URLQueryItem] in
                if let array = value as? [Any] {
                    return array.map { URLQueryItem(name: key, value: "\($0)") }
                } else {
                    return [URLQueryItem(name: key, value: "\(value)")]
                }
            }
        }

        guard let url = components.url else {
            return Fail(error: NetworkError.invalidUrl)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = service.method
        request.allHTTPHeaderFields = service.header

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }

                guard !data.isEmpty else {
                    throw NetworkError.noData
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchAllGenresPublisher() -> AnyPublisher<[GenreResponse], Error> {
        return sendRequest(service: .genres, response: [GenreResponse].self)
            .eraseToAnyPublisher()
    }
}

//MARK: - Error

enum NetworkError: Error {
    case invalidUrl
    case noData
    case invalidResponse
    case decodingError
}

enum ImageFetchError: Error {
    case invalidURL
    case networkError(Error)
}
