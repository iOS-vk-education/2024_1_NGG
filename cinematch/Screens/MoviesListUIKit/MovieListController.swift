//
//  MovieListController.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import UIKit
import SwiftUI

final class MovieListController: UIViewController {
    private let viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: Constants.cellSpacing,
                                           left: Constants.cellSpacing,
                                           bottom: Constants.cellSpacing,
                                           right: Constants.cellSpacing)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    init(viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        viewModel.loadMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: - Setup

    private func setup() {
        view.backgroundColor = .background
        view.addSubview(collectionView)
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self)
        collectionView.register(SkeletonCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let shimmerCells = (viewModel.uiProperties.isLoading && !viewModel.uiProperties.isLastPage) ? 6 : 0
        return viewModel.stories.count + shimmerCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.uiProperties.isLoading &&
            !viewModel.uiProperties.isLastPage &&
            indexPath.item >= viewModel.stories.count {
            return collectionView.dequeueReusableCell(SkeletonCell.self, for: indexPath)
        }

        let cell = collectionView.dequeueReusableCell(FilmCell.self, for: indexPath)
        if let config = viewModel.configuration(at: indexPath.item) {
            cell.configuration = config
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !viewModel.uiProperties.isLoading && !viewModel.uiProperties.isLastPage && indexPath.item == viewModel.stories.count - 1 {
            viewModel.loadMovies { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.stories.count else { return }

        let selectedStory = viewModel.stories[indexPath.item]
        viewModel.didTapCell(story: selectedStory)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - Constants.cellSpacing * 2
        return CGSize(width: width, height: Constants.cellHeight)
    }
}

// MARK: - Constants

private extension MovieListController {
    enum Constants {
        static let cellSpacing: CGFloat = 16
        static let cellHeight: CGFloat = 130
    }
}
