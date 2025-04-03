//
//  NetworkService.swift
//  cinematch
//
//  Created by Ксения Панкратова on 01.04.2025.
//

import Foundation

protocol MovieListNetworkServiceProtocol {
    func fetchMovies() async throws -> [Module]
}

final class NetworkService: MovieListNetworkServiceProtocol {
    func fetchMovies() async throws -> [Module] {
        try await Task.sleep(for: .seconds(2))
        return MockData.stories
    }
}

// MARK: - Mock Data -

private extension NetworkService {
    enum MockData {
        static let stories = (1...10).map {
            let tempStory = Module.generateStory(number: $0)
            let similarMovies = ($0...$0 + 3).map { Module.generateStory(number: $0) }

            return Module(
                id: tempStory.id,
                mainImage: tempStory.mainImage,
                title: tempStory.title,
                director: tempStory.director,
                description: tempStory.description,
                rating: tempStory.rating,
                type: tempStory.type,
                year: tempStory.year,
                genre: tempStory.genre,
                imagesData: tempStory.imagesData,
                similarMovies: similarMovies,
                viewingPlatforms: tempStory.viewingPlatforms
            )
        }
    }
}
